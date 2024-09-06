import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 30,),
          const Text(
            'Settings',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          ListTile(
            title: const Text('Change Password'),
            leading: const Icon(Icons.lock),
            onTap: () {
              // Handle password change tap
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Notification Settings'),
            leading: const Icon(Icons.notifications),
            onTap: () {
              // Handle notification settings tap
            },
          ),
          const Divider(),
          ListTile(
            title: const Text('Language'),
            leading: const Icon(Icons.language),
            onTap: () {
              // Handle language change tap
            },
          ),
        ],
      ),
    );
  }
}
