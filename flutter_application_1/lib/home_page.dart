import 'package:flutter/material.dart';
import 'package:flutter_application_1/fetch.dart';
import 'package:flutter_application_1/local_notifications.dart';
import 'package:flutter_application_1/model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatefulWidget {
  final MyData data;
  const HomePage({super.key, required this.data});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    initLocationService();
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    switch (index) {
      case 0:
        if(context.mounted){
          //Do Nothing
          break;
        }
        else{
          context.push('/AdminHome',extra: widget.data);
          break;
        }
      case 1:
        print('Settings tapped');
        break;
      case 2:
        _showLogoutConfirmation();
        break;
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
                GoRouter.of(context).go('/');
              },
            ),
          ],
        );
      },
    );
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
    // await getLocationDataFromDB();
    getLocationData();
    checkGeofence(position.latitude, position.longitude, context);
  }

  late double dummyLattitude;
  late double dummyLongitude;

  void getLocationData(){
    if(widget.data.branchId == 1){
      dummyLattitude = 10.9807761;
      dummyLongitude = 78.0787206;
    }
    else if(widget.data.branchId == 2){
      dummyLattitude = 10.000;
      dummyLongitude = 10.000;
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data For Your Branch Is Not Available. Please Contact Your Admin.")),
        );
    }
  }
/*   late double lattitudefromDB;
  late double longitudefromDB;
    getLocationDataFromDB() async {
    try {
      OfficeLocationData location = await getOfficeLocation(widget.data.branchId);
      if (location.latitude != null && location.longitude != null) {
        lattitudefromDB = location.latitude;
        longitudefromDB = location.longitude;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Data For Your Branch Is Not Available. Please Contact Your Admin.")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error Occurred During Fetch. Sorry For The Inconvenience.")),
      );
    }
  } */

 Future<UserAttendance?> autoCheckin() async {
  try {
    String formattedDate = DateTime.now().toIso8601String().split('.')[0];
    UserAttendance userAttendance = UserAttendance(
      userId: widget.data.id,
      userName: widget.data.username,
      autoGeoAttendance: GeoAttendance(
        checkIn: formattedDate,
        checkOut: null,
        totalHours: null,
      ),
      manualGeoAttendance: GeoAttendance(
        checkIn: null,
        checkOut: null,
        totalHours: null,
      ),
    );
    UserAttendance response = await newUserAttendance(userAttendance);
    if (response.userName == widget.data.username) {
      return response;
    } else {
      return null;
    }
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Failed to check in. Please try again.")),
    );
    return null;
  }
}



  void checkGeofence(double latitude, double longitude, BuildContext context) {
    double geofenceLat = dummyLattitude;
    double geofenceLon = dummyLongitude;
    const double geofenceRadius = 200.0;

    double distance = Geolocator.distanceBetween(
        latitude, longitude, geofenceLat, geofenceLon);

    if (distance <= geofenceRadius) {
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
      LocalNotifications.showSimpleNotification(title: "Your Attendance is marked", body: "You are inside the office premesis", payload: "Attendance");

    } else {
      print("User is outside the geofence.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home',
        style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),),),
        backgroundColor: const Color.fromARGB(255, 77, 79, 79),
        leading: Container(),
        leadingWidth: 12,
        elevation: 6,
        shadowColor: Colors.blueGrey,
        ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      initLocationService();
                    },
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
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text("Attendance"),
                            content: const Text("Your Attendance Has Been Marked! Enjoy Your day."),
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
                      context.push('/Timesheet',extra: widget.data);
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
      ),
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
        backgroundColor: Colors.grey,
        selectedItemColor: const Color.fromARGB(255, 147, 0, 150),
        unselectedItemColor: Colors.white,
        elevation: 6,
        selectedIconTheme: IconThemeData(
          color:const Color.fromARGB(255, 147, 0, 150),
          shadows: [
            Shadow(
              color: Colors.black.withOpacity(0.88), 
              offset:const Offset(0, 3), 
              blurRadius: 15, 
            ),
          ],),
        selectedLabelStyle: const TextStyle(
          color: Colors.white,
        ),
        unselectedLabelStyle: const TextStyle(
          color: Colors.grey, 
        ),
      ),
    );
  }
}
