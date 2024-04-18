// import 'package:flutter/material.dart';

// class Profile extends StatefulWidget {
//   const Profile({super.key});

//   @override
//   State<Profile> createState() => _ProfileState();
// }

// class _ProfileState extends State<Profile> {
//   @override
//   Widget build(BuildContext context) {
//        return Scaffold(
//       body: Container(alignment: Alignment.center, child: Text("profile")),
//     );
//   }
// }
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          textAlign: TextAlign.center,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
             

            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/london.jpeg'),
            ),


            SizedBox(height: 20),
            Text(
              'User Name',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),


            Text(
              'user@example.com',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),



            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.phone, color: Color(0xFF00416A)),
              title: Text('Phone Number: +1234567890'),
            ),



            ListTile(
              leading: Icon(Icons.location_on, color: Color(0xFF00416A)),
              title: Text('Address: 123 Street, City, Country'),
            ),



            SizedBox(height: 20),
            ListTile(
              leading: Icon(Icons.settings, color: Color(0xFF00416A)),
              title: Text('Settings'),
              onTap: () {
               



              },
            ),


            ListTile(
              leading: Icon(Icons.notifications, color: Color(0xFF00416A)),
              title: Text('Notifications'),
              onTap: () {
            



              },
            ),
            ListTile(
              leading: Icon(Icons.support, color: Color(0xFF00416A)),
              title: Text('Support'),
              onTap: () {
              
              },
            ),




            ListTile(
              leading: Icon(Icons.help, color: Color(0xFF00416A)),
              title: Text('Help Center'),
              onTap: () {
              
              },
            ),



            ListTile(
              leading: Icon(Icons.feedback, color: Color(0xFF00416A)),
              title: Text('App Feedback'),
              onTap: () {
       

              },
            ),



            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
              
              
              },
              child: Text(
                'Sign Out',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
