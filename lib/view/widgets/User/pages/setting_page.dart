import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          ListTile(
            title: Text('Theme'),
            trailing: Icon(Icons.color_lens, color: Color(0xFF00416A)),
            onTap: () {
              // Navigate to theme selection page
            },
          ),
          Divider(),
          ListTile(
            title: Text('Font'),
            trailing: Icon(Icons.font_download, color: Color(0xFF00416A)),
            onTap: () {
              // Navigate to font selection page
            },
          ),
          Divider(),
          ListTile(
            title: Text('Data Management'),
            trailing: Icon(Icons.storage, color: Color(0xFF00416A)),
            onTap: () {
              // Navigate to data management page
            },
          ),
          Divider(),
          ListTile(
            title: Text('Social Media'),
            trailing: Icon(Icons.people, color: Color(0xFF00416A)),
            onTap: () {
              // Navigate to social media integration page
            },
          ),
          Divider(),
          ListTile(
            title: Text('Accessibility'),
            trailing: Icon(Icons.accessibility, color: Color(0xFF00416A)),
            onTap: () {
              // Navigate to accessibility options page
            },
          ),
          Divider(),
          ListTile(
            title: Text('Backup & Restore'),
            trailing: Icon(Icons.backup, color: Color(0xFF00416A)),
            onTap: () {
              // Navigate to backup & restore page
            },
          ),
          Divider(),
          ListTile(
            title: Text('Feedback & Suggestions'),
            trailing: Icon(Icons.feedback, color: Color(0xFF00416A)),
            onTap: () {
              // Navigate to feedback & suggestions page
            },
          ),
          Divider(),
          ListTile(
            title: Text('Terms & Conditions / Privacy Policy'),
            trailing: Icon(Icons.library_books, color: Color(0xFF00416A)),
            onTap: () {
              // Navigate to terms & conditions / privacy policy page
            },
          ),
          Divider(),
          ListTile(
            title: Text('Logout'),
            trailing: Icon(Icons.exit_to_app, color: Color(0xFF00416A)),
            onTap: () {
              // Implement logout functionality
            },
          ),
        ],
      ),
    );
  }
}
