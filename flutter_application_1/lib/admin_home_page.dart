import 'package:flutter/material.dart';
import 'package:flutter_application_1/local_notifications.dart';
import 'package:flutter_application_1/model.dart';
import 'package:flutter_application_1/settings_page.dart';
import 'package:go_router/go_router.dart';

class AdminHomePage extends StatefulWidget {
  final MyData data;

  const AdminHomePage({super.key, required this.data});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
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

  @override
  Widget build(BuildContext context) {
    // Use a list of widgets to switch between pages based on selected index
    final List<Widget> _pages = [
      _buildAdminHomeContent(),
      SettingsPage(data:widget.data ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Home',
          style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
        ),
        backgroundColor: const Color.fromARGB(255, 77, 79, 79),
        leading: Container(),
        leadingWidth: 12,
        elevation: 6,
        shadowColor: Colors.blueGrey,
      ),
      body: _pages[_selectedIndex],  // Display the selected page
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
              LocalNotifications.showSimpleNotification(
                title: "addEmployee",
                body: "Functionality to add a new employee.",
                payload: "AddEmployee"
              );
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
