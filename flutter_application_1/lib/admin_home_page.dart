import 'package:flutter/material.dart';
import 'package:flutter_application_1/local_notifications.dart';
import 'package:flutter_application_1/model.dart';
import 'package:flutter_application_1/settings_page.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AdminHomePage extends StatefulWidget {
  final MyData data;

  const AdminHomePage({super.key, required this.data});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int _selectedIndex = 0;
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadThemePreference();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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
    Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    final _storage = FlutterSecureStorage();
    await prefs.setBool('isLoggedIn', false);
    await _storage.deleteAll();
    context.pushReplacement('/');
  }

  // Save theme preference to storage
  Future<void> _saveThemePreference(bool isDarkMode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
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

  @override
  Widget build(BuildContext context) {
    // Use a list of widgets to switch between pages based on selected index
    final List<Widget> _pages = [
      _buildAdminHomeContent(),
      SettingsPage(data:widget.data,onThemeChanged: _onThemeChanged,isDarkTheme: _isDarkMode, ),
    ];

    return 
    Scaffold(
      body:SingleChildScrollView(child: _pages[_selectedIndex],),
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
        onTap: (index) {
          if (index == 2) {
            _showLogoutConfirmation(); // Handle logout separately
          } else {
            _onItemTapped(index);  // Handle home/settings navigation
          }
        },
      ),
    );
  }

  Widget _buildAdminHomeContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 35.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30),
          const Text(
            'Admin Home',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildActionRow(
            "addEmployee",
            "addAdmin",
            () {
              context.push('/AddEmployee');
            },
            () {
              LocalNotifications.showSimpleNotification(
                title: "addAdmin",
                body: "Functionality to add a new admin.",
                payload: "AddAdmin"
              );
            }
          ),
          const SizedBox(height: 20),
          _buildActionRow(
            "geofencing",
            "attendanceStatus",
            () {
              LocalNotifications.showSimpleNotification(
                title: "geofencing",
                body: "Functionality to add or change geofencing.",
                payload: "Geofencing"
              );
            },
            () {
              LocalNotifications.showSimpleNotification(
                title: "attendanceStatus",
                body: "Functionality to view employees' attendance status.",
                payload: "AttendanceStatus"
              );
            }
          ),
          const SizedBox(height: 20),
          _buildActionRow(
            "updateEmployee",
            "dashboard",
            () {
              
              LocalNotifications.showSimpleNotification(
                title: "updateEmployee",
                body: "Functionality to update employee details.",
                payload: "UpdateEmployee"
              );
            },
            () {
              LocalNotifications.showSimpleNotification(
                title: "dashboard",
                body: "Functionality to view dashboard.",
                payload: "Dashboard"
              );
            }
          ),
        ],
      ),
    );
  }

  Widget _buildActionRow(String title1, String title2, VoidCallback onTap1, VoidCallback onTap2) {
    return Row(
      children: [
        Flexible(
          child: GestureDetector(
            onTap: onTap1,
            child: SizedBox(
              height: 100,
              child: Card(
                child: Center(
                  child: Text(
                    title1,
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
            onTap: onTap2,
            child: SizedBox(
              height: 100,
              child: Card(
                child: Center(
                  child: Text(
                    title2,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
