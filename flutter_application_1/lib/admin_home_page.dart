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
    final List<Widget> _pages = [
      _buildAdminHomeContent(),
      const SettingsPage(),
    ];

    return Scaffold(
      body: _pages[_selectedIndex],  
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
            _showLogoutConfirmation(); 
          } else {
            _onItemTapped(index);  
          }
        },
      ),
    );
  }

  
  Widget _buildAdminHomeContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
      child: Column(
        children: [
          Row(
            children: [
              Flexible(
                child: GestureDetector(
                  onTap: () {
                    LocalNotifications.showSimpleNotification(title: "simpleNotification", body: "Just Try", payload: "Sample");
                  },
                  child: const SizedBox(
                    height: 100,
                    child: Card(
                      child: Center(
                        child: Text(
                          "Add New Employee",
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
                  onTap: () {},
                  child: const SizedBox(
                    height: 100,
                    child: Card(
                      child: Center(
                        child: Text(
                          "Add New Admin",
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
                  onTap: () {},
                  child: const SizedBox(
                    height: 100,
                    child: Card(
                      child: Center(
                        child: Text(
                          "Add or Change Geofencing",
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
                  onTap: () {},
                  child: const SizedBox(
                    height: 100,
                    child: Card(
                      child: Center(
                        child: Text(
                          "Employees Attendance Status",
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
                  onTap: () {},
                  child: const SizedBox(
                    height: 100,
                    child: Card(
                      child: Center(
                        child: Text(
                          "Update Employee Details",
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
                  onTap: () {},
                  child: const SizedBox(
                    height: 100,
                    child: Card(
                      child: Center(
                        child: Text(
                          "Dashboard",
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
