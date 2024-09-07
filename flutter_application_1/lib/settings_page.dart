import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});
   @override
  _SettingsPageState createState() => _SettingsPageState();
}


class _SettingsPageState extends State<SettingsPage> {
  bool _isDarkTheme = false; 
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical:40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
          const Divider(),
          SwitchListTile(
            title: const Text('Dark Theme'),
            secondary: const Icon(Icons.brightness_6),
            value: _isDarkTheme,
            onChanged: (value) {
              setState(() {
                _isDarkTheme = value;
              });
              // Update the app theme
              if (_isDarkTheme) {
                // Switch to dark theme
                Theme.of(context).copyWith(brightness: Brightness.dark);
              } else {
                // Switch to light theme
                Theme.of(context).copyWith(brightness: Brightness.light);
              }
            }
         )
        ],
      ),
    );
  }
}
