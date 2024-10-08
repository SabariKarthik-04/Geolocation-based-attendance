import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_1/fetch.dart';
import 'package:flutter_application_1/local_notifications.dart';
import 'package:flutter_application_1/model.dart';
import 'package:flutter_application_1/settings_page.dart';

class HomePage extends StatefulWidget {
  final MyData data;
  const HomePage({super.key, required this.data});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    initLocationService();
    _loadThemePreference();
  }

   void _onThemeChanged(bool isDarkMode) {
    setState(() {
      _isDarkMode = isDarkMode;
    });
    _saveThemePreference(isDarkMode);
  }

  // Load theme preference from storage
  Future<void> _loadThemePreference() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  // Save theme preference to storage
  Future<void> _saveThemePreference(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  void _onItemTapped(int index) {
    if (index == 2) {
      _showLogoutConfirmation();
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  void _showLogoutConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Logout"),
              onPressed: () {
                Navigator.of(context).pop();
                logout();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final _storage = FlutterSecureStorage();
    await prefs.setBool('isLoggedIn', false);
    await _storage.deleteAll();
    context.pushReplacement('/');
  }

  void initLocationService() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    locationCallback(position);
  }

  void locationCallback(Position position) async {
    print("Location: ${position.latitude}, ${position.longitude}");
    getLocationData();
    checkGeofence(position.latitude, position.longitude, context);
  }

  late double dummyLatitude;
  late double dummyLongitude;

  void getLocationData() {
    if (widget.data.branchId == 1) {
      dummyLatitude = 10.9807761;
      dummyLongitude = 78.0787206;
    } else if (widget.data.branchId == 2) {
      dummyLatitude = 10.000;
      dummyLongitude = 10.000;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data for your branch is not available. Please contact your admin.")),
      );
    }
  }

  Future<bool> autoCheckin() async {
    try {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('dd-MM-yyyy').format(now);
      String formattedTime = DateFormat('HH:mm:ss').format(now);
      UserAttendance userAttendance = UserAttendance(
        userId: widget.data.id,
        userName: widget.data.username,
        date: formattedDate,
        autoGeoAttendance: AutomatedGeoAttendance(
          geoCheckIn: formattedTime,
          geoCheckOut: null,
          geoTotalHours: null,
        ),
        manualGeoAttendance: ManualAttendance(
          manualCheckIn: null,
          manualCheckOut: null,
          manualTotalHours: null,
        ),
      );
      await newUserAttendance(userAttendance);
      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to check in. Please try again.")),
      );
      return false;
    }
  }

  Future<bool> autoCheckOut() async {
    try {
      DateTime now = DateTime.now();
      String formattedDate = DateFormat('dd-MM-yyyy').format(now);
      String formattedTime = DateFormat('HH:mm:ss').format(now);
      UserAttendance userAttendance = UserAttendance(
        userId: widget.data.id,
        userName: widget.data.username,
        date: formattedDate,
        autoGeoAttendance: AutomatedGeoAttendance(
          geoCheckIn: null,
          geoCheckOut: formattedTime,
          geoTotalHours: null,
        ),
        manualGeoAttendance: ManualAttendance(
          manualCheckIn: null,
          manualCheckOut: null,
          manualTotalHours: null,
        ),
      );
      await newUserAttendance(userAttendance);
      return true;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Failed to check out. Please try again.")),
      );
      return false;
    }
  }

  void checkGeofence(double latitude, double longitude, BuildContext context) async {
    double geofenceLat = dummyLatitude;
    double geofenceLon = dummyLongitude;
    const double geofenceRadius = 200.0;

    double distance = Geolocator.distanceBetween(
        latitude, longitude, geofenceLat, geofenceLon);

    if (distance <= geofenceRadius) {
      if (await autoCheckin()) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Attendance"),
              content: const Text("Your attendance has been marked successfully."),
              actions: [
                TextButton(
                  child: const Text("OK"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
        LocalNotifications.showSimpleNotification(
            title: "Your Attendance is marked",
            body: "You are inside the office premises",
            payload: "Attendance");
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Check-Out"),
            content: const Text("You are outside the office premises. Do you want to check out?"),
            actions: [
              TextButton(
                child: const Text("Check-Out"),
                onPressed: () async {
                  if (await autoCheckOut()) {
                    LocalNotifications.showSimpleNotification(
                      title: "Your Check-Out is marked",
                      body: "Bye bye, see you tomorrow!",
                      payload: "Attendance"
                    );
                    Navigator.of(context).pop();
                  }
                },
              ),
              TextButton(
                child: const Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      _buildHomeContent(),
      SettingsPage(data: widget.data,onThemeChanged: _onThemeChanged,isDarkTheme: _isDarkMode,),
    ];

    return Scaffold(
      body: SingleChildScrollView(child:_pages[_selectedIndex],),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.logout),
            label: "Logout",
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  Widget _buildHomeContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          const Text(
            'Home',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Flexible(
                child: GestureDetector(
                  onTap: initLocationService,
                  child: const SizedBox(
                    height: 100,
                    child: Card(
                      child: Center(
                        child: Text(
                          "Refresh GeoLocation",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    context.push('/ManualAttendance', extra: widget.data);
                  },
                  child: const SizedBox(
                    height: 100,
                    child: Card(
                      child: Center(
                        child: Text(
                          "Manual Attendance",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    context.push('/Timesheet', extra: widget.data);
                  },
                  child: const SizedBox(
                    height: 100,
                    child: Card(
                      child: Center(
                        child: Text(
                          "TimeSheet",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Text("User: ${widget.data.username}"),
            ],
          ),
        ],
      ),
    );
  }
}
