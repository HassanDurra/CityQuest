import 'dart:convert';

import 'package:cityquest/assets/colors.dart';
import 'package:cityquest/view/Auth/logout.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Map<String, dynamic> userData = {};

  Future<void> getData() async {
    var pref = await SharedPreferences.getInstance();
    String? user = pref.getString('user');

    if (user != null) {
      setState(() {
        userData = jsonDecode(user);
      });
    }
  }

  // logout Function
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home View"),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          Text("Welcome back : ${userData['email']}"),
          SizedBox(
            height: 20,
          ),
          Container(
              width: double.infinity,
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.all(20),
              color: GlobalColors.mainColor,
              child: TextButton(
                onPressed: () {
                  Authentication auth = new Authentication();
                  auth.Logout();
                },
                child: Text("Logout",
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'poppins',
                        fontSize: 13)),
              ))
        ]),
      ),
    );
  }
}
