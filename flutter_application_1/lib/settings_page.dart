import 'package:flutter/material.dart';
import 'package:flutter_application_1/fetch.dart';
import 'package:flutter_application_1/model.dart';

class SettingsPage extends StatefulWidget {
  final MyData data;
  const SettingsPage({super.key, required this.data});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late Future<UserData> _userDataFuture;

  @override
  void initState() {
    super.initState();
    // Initialize the Future when the widget is first created
    _userDataFuture = getUserDatafromDb();
  }

  Future<UserData> getUserDatafromDb() async {
    // Fetch user data from the database or API
    return await getUserData(widget.data.id);
    
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                                backgroundImage: AssetImage('assets/image/profile.png'),
                              ),
                            ),
                            const SizedBox(height: 30),
                            Text(
                              userData.userName,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.phone, color: Colors.blue),
                                SizedBox(width: 8),
                                Text(userData.userMobileNumber, style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.email, color: Colors.blue),
                                SizedBox(width: 8),
                                Text(userData.userMail, style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.calendar_today, color: Colors.blue),
                                SizedBox(width: 8),
                                Text('DOB: ${userData.userDOB}', style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.cake, color: Colors.blue),
                                SizedBox(width: 8),
                                Text('Age: ${DateTime.now().year - int.parse(userData.userDOB.split('-')[2])}', style: TextStyle(fontSize: 16)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Icon(Icons.work, color: Colors.blue),
                                SizedBox(width: 8),
                                Text('Posting: ${userData.userPosting}', style: TextStyle(fontSize: 16)),
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
                          Text('Password Change Screen', style: TextStyle(fontSize: 16)),
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
                          Text('Notification Settings Screen', style: TextStyle(fontSize: 16)),
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
                          Text('Language Settings Screen', style: TextStyle(fontSize: 16)),
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
    );
  }
}
