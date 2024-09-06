import 'package:flutter/material.dart';
import 'package:flutter_application_1/model.dart';
import 'package:go_router/go_router.dart';

class AdminHomePage extends StatefulWidget {
  final MyData data;
  
  const AdminHomePage({super.key,required this.data});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Home',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255)),),
        backgroundColor: const Color.fromARGB(255, 77, 79, 79),
        leading: Container(),
        leadingWidth: 12,
        elevation: 6,
        shadowColor: Colors.blueGrey,
      ),
      body: Padding(
        padding:const  EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
        child:  Column(
          children: [
            Row(
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      
                    },
                    child:const SizedBox(
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
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      
                    },
                    child:const SizedBox(
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
            Row(
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      
                    },
                    child:const SizedBox(
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
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      
                    },
                    child:const SizedBox(
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
            Row(
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      
                    },
                    child:const SizedBox(
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
                const SizedBox(
                  width: 10,
                ),
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      
                    },
                    child:const SizedBox(
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
      ),
    );
  }
}