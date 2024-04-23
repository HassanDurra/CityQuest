// // import 'package:cityquest/view/widgets/User/pages/setting_page.dart';
// // import 'package:flutter/material.dart';

// // class Profile extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text(
// //           'Profile',
// //           textAlign: TextAlign.center,
// //         ),
// //       ),
// //       body: SingleChildScrollView(
// //         child: Column(
// //           crossAxisAlignment: CrossAxisAlignment.center,
// //           children: [
// //             SizedBox(height: 20),
// //             Container(
// //               margin: EdgeInsets.symmetric(horizontal: 16),
// //               decoration: BoxDecoration(
// //                 color: Colors.white,
// //                 borderRadius: BorderRadius.circular(16),
// //                 boxShadow: [
// //                   BoxShadow(
// //                     color: Colors.grey.withOpacity(0.5),
// //                     spreadRadius: 5,
// //                     blurRadius: 7,
// //                     offset: Offset(0, 3),
// //                   ),
// //                 ],
// //               ),
// //               child: Column(
// //                 crossAxisAlignment: CrossAxisAlignment.center,
// //                 children: [
// //                   SizedBox(height: 20),
// //                   CircleAvatar(
// //                     radius: 50,
// //                     backgroundImage: AssetImage('assets/images/london.jpeg'),
// //                   ),
// //                   SizedBox(height: 20),
// //                   Text(
// //                     'User Name',
// //                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
// //                   ),
// //                   Text(
// //                     'user@example.com',
// //                     style: TextStyle(fontSize: 16, color: Colors.grey),
// //                   ),
// //                   SizedBox(height: 20),
// //                   ListTile(
// //                     leading: Icon(Icons.settings, color: Color(0xFF00416A)),
// //                     title: Text('Profile Settings'),
// //                     onTap: () {
// //                       Navigator.push(
// //                         context,
// //                         MaterialPageRoute(builder: (context) => SettingsPage()),
// //                       );
// //                     },
// //                   ),
// //                   ListTile(
// //                     leading: Icon(Icons.person, color: Color(0xFF00416A)),
// //                     title: Text('Profile Information'),
// //                     onTap: () {},
// //                   ),
// //                   ListTile(
// //                     leading: Icon(Icons.book, color: Color(0xFF00416A)),
// //                     title: Text('Term & Condition'),
// //                     onTap: () {},
// //                   ),
// //                   ListTile(
// //                     leading: Icon(Icons.headset, color: Color(0xFF00416A)),
// //                     title: Text('Support'),
// //                     onTap: () {},
// //                   ),
// //                   ListTile(
// //                     leading: Icon(Icons.exit_to_app, color: Color(0xFF00416A)),
// //                     title: Text('Logout'),
// //                     onTap: () {},
// //                   ),
// //                 ],
// //               ),
// //             ),
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:cityquest/view/widgets/User/pages/setting_page.dart';
// import 'package:flutter/material.dart';

// class Profile extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'Profile',
//           textAlign: TextAlign.center,
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(height: 20),
//             Padding(
//               padding: EdgeInsets.symmetric(horizontal: 16), // Add padding here
//               child: Center(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     borderRadius: BorderRadius.circular(16),
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.5),
//                         spreadRadius: 5,
//                         blurRadius: 7,
//                         offset: Offset(0, 3),
//                       ),
//                     ],
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       SizedBox(height: 20),
//                       CircleAvatar(
//                         radius: 50,
//                         backgroundImage: AssetImage('assets/images/london.jpeg'),
//                       ),
//                       SizedBox(height: 20),
//                       Text(
//                         'User Name',
//                         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                       ),
//                       Text(
//                         'user@example.com',
//                         style: TextStyle(fontSize: 16, color: Colors.grey),
//                       ),
//                       SizedBox(height: 20),
//                       ListTile(
//                         leading: Icon(Icons.settings, color: Color(0xFF00416A)),
//                         title: Text('Profile Settings'),
//                         onTap: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(builder: (context) => SettingsPage()),
//                           );
//                         },
//                       ),
//                       ListTile(
//                         leading: Icon(Icons.person, color: Color(0xFF00416A)),
//                         title: Text('Profile Information'),
//                         onTap: () {},
//                       ),
//                       ListTile(
//                         leading: Icon(Icons.book, color: Color(0xFF00416A)),
//                         title: Text('Term & Condition'),
//                         onTap: () {},
//                       ),
//                       ListTile(
//                         leading: Icon(Icons.headset, color: Color(0xFF00416A)),
//                         title: Text('Support'),
//                         onTap: () {},
//                       ),
//                       ListTile(
//                         leading: Icon(Icons.exit_to_app, color: Color(0xFF00416A)),
//                         title: Text('Logout'),
//                         onTap: () {},
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:cityquest/view/widgets/User/pages/setting_page.dart';
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
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
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
                      leading: Icon(Icons.settings, color: Color(0xFF00416A)),
                      title: Text('Profile Settings'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SettingsPage()),
                        );
                      },
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.person, color: Color(0xFF00416A)),
                      title: Text('Profile Information'),
                      onTap: () {},
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.book, color: Color(0xFF00416A)),
                      title: Text('Term & Condition'),
                      onTap: () {},
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.headset, color: Color(0xFF00416A)),
                      title: Text('Support'),
                      onTap: () {},
                    ),
                    Divider(),
                    ListTile(
                      leading: Icon(Icons.exit_to_app, color: Color(0xFF00416A)),
                      title: Text('Logout'),
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
