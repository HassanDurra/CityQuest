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

          Card(
            elevation: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    'General',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.account_circle, color: Color(0xFF00416A)),
                  title: Text('Account'),
                  onTap: () {
     


                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.notifications, color: Color(0xFF00416A)),
                  title: Text('Notifications'),
                  onTap: () {


                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.local_offer, color: Color(0xFF00416A)),
                  title: Text('Coupons'),
                  onTap: () {
         


                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.exit_to_app, color: Color(0xFF00416A)),
                  title: Text('Logout'),
                  onTap: () {
         
                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.delete, color: Color(0xFF00416A)),
                  title: Text('Delete Account'),
                  onTap: () {
            
            
                  },
                ),
                Divider(),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0, bottom: 8.0),
                  child: ListTile(
                    title: Text(
                      'Feedback',
                      style: TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
       
                ListTile(
                  leading: Icon(Icons.bug_report, color: Color(0xFF00416A)),
                  title: Text('Report a Bug'),
                  onTap: () {
              


                  },
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.feedback, color: Color(0xFF00416A)),
                  title: Text('Send Feedback'),
                  onTap: () {
              

                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
