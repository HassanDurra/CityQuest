import 'dart:async';
import 'package:cityquest/view/Auth/forgot_password.dart';
import 'package:cityquest/view/Auth/login.dart';
import 'package:cityquest/view/Auth/profile_edit.dart';
import 'package:cityquest/view/Auth/register.dart';
import 'package:cityquest/view/widgets/User/home.dart';
import 'package:cityquest/view/Auth/buttons/register.button.dart';
import 'package:cityquest/view/widgets/User/pages/Cities.dart';
import 'package:cityquest/view/widgets/User/pages/Map.dart';
import 'package:cityquest/view/widgets/User/partial/navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  String userData = '';

  Future<void> getData() async {
    var pref = await SharedPreferences.getInstance();
    String? user = pref.getString('user');

    if (user != null) {
      setState(() {
        userData = user;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getData();
    Timer(const Duration(seconds: 2), () {
      if (userData.isNotEmpty) {
        Get.offAll(() => Navbar());
      } else {
        Get.offAll(() => LoginView());

        // Get.offAll(() => HomeView());

        // Get.offAll(() => MapView());
        // Get.offAll(() => Navbar());



      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "images/loader.png",
              fit: BoxFit.cover,
            ),
          ),
         
        ],
      ),
    );
  }
}
