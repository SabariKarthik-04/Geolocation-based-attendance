import 'package:flutter/material.dart';
import 'package:flutter_application_1/fetch.dart';
import 'package:flutter_application_1/model.dart';

class SettingsPage extends StatefulWidget {
  final MyData data;
  final ValueChanged<bool> onThemeChanged; // Callback for theme change
  final bool isDarkTheme; // Current theme

  const SettingsPage({
    super.key,
    required this.data,
    required this.onThemeChanged,
    required this.isDarkTheme,
  });

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late Future<UserData> _userDataFuture;
  late bool _isDarkTheme;

  @override
  void initState() {
    super.initState();
    _userDataFuture = getUserDatafromDb();
    _isDarkTheme = widget.isDarkTheme; // Initialize from the passed value
  }

  Future<UserData> getUserDatafromDb() async {
    return await getUserData(widget.data.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: FutureBuilder<UserData>(
          future: _userDataFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData) {
              return const Center(child: Text('No data available'));
            } else {
              final userData = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  const Text(
                    'Settings',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),

                  // Dark theme toggle switch
                  SwitchListTile(
                    title: const Text('Dark Theme'),
                    value: _isDarkTheme,
                    onChanged: (value) {
                      setState(() {
                        _isDarkTheme = value;
                      });
                      widget.onThemeChanged(_isDarkTheme); // Trigger the callback
                    },
                    secondary: const Icon(Icons.dark_mode),
                  ),

                  // Profile Section with ExpansionTile
                  ExpansionTile(
                    leading: const Icon(Icons.person),
                    title: const Text('Profile'),
                    children: [
                      Card(
                        elevation: 4,
                        margin: const EdgeInsets.all(16),
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: CircleAvatar(
                                  radius: 80,
                                  backgroundImage:
                                      const AssetImage('assets/image/profile.png'),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Text(
                                userData.userName,
                                style: const TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.phone, color: Colors.blue),
                                  const SizedBox(width: 8),
                                  Text(userData.userMobileNumber,
                                      style: const TextStyle(fontSize: 16)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.email, color: Colors.blue),
                                  const SizedBox(width: 8),
                                  Text(userData.userMail,
                                      style: const TextStyle(fontSize: 16)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.calendar_today,
                                      color: Colors.blue),
                                  const SizedBox(width: 8),
                                  Text('DOB: ${userData.userDOB}',
                                      style: const TextStyle(fontSize: 16)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.cake, color: Colors.blue),
                                  const SizedBox(width: 8),
                                  Text(
                                      'Age: ${DateTime.now().year - int.parse(userData.userDOB.split('-')[2])}',
                                      style: const TextStyle(fontSize: 16)),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.work, color: Colors.blue),
                                  const SizedBox(width: 8),
                                  Text('Posting: ${userData.userPosting}',
                                      style: const TextStyle(fontSize: 16)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Change Password Section
                  ExpansionTile(
                    leading: const Icon(Icons.lock),
                    title: const Text('Change Password'),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Password Change Screen',
                                style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Notification Settings Section
                  ExpansionTile(
                    leading: const Icon(Icons.notifications),
                    title: const Text('Notification Settings'),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Notification Settings Screen',
                                style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),

                  // Language Settings Section
                  ExpansionTile(
                    leading: const Icon(Icons.language),
                    title: const Text('Language'),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Text('Language Settings Screen',
                                style: TextStyle(fontSize: 16)),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}
