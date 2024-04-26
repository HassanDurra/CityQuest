import 'package:cityquest/assets/colors.dart';
import 'package:cityquest/view/Class/Authentication.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "images/background.png",
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Container(
                constraints: BoxConstraints(maxWidth: 400),
                margin: EdgeInsets.all(20),
                padding: EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Profile',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Column(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/avatar.jpg'),
                            radius: 30,
                          ),
                          SizedBox(height: 10),
                          Text(
                            'JANE DOY',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            'email@email.com',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[600],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Divider(color: Colors.grey[300]),
                    SizedBox(height: 20),
                    Text(
                      'Setting',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    buildListItem('Profile Setting', Icons.arrow_forward_ios),
                    buildListItem('Preferences', Icons.arrow_forward_ios),
                    buildListItem('Notifications', Icons.arrow_forward_ios),
                    SizedBox(height: 20),
                    Divider(color: Colors.grey[300]),
                    SizedBox(height: 20),
                    Text(
                      'Support',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 10),
                    buildListItem('Help center', Icons.arrow_forward_ios),
                    buildListItem('App feedback', Icons.arrow_forward_ios),
                    SizedBox(height: 20),
                    Divider(color: Colors.grey[300]),
                    SizedBox(height: 20),
                    Center(
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: GlobalColors.mainColor,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(12),
                        child: IconButton(
                          onPressed: () {
                            Authentication auth = new Authentication();
                            auth.Logout();
                          },
                          icon: Icon(
                            Ionicons.power_outline,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildListItem(String text, IconData icon) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: 14,
              color: Colors.black,
            ),
          ),
          IconButton(
            icon: Icon(icon),
            color: GlobalColors.mainColor,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
