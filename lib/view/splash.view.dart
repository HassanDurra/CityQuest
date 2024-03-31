import 'dart:async';
import 'package:cityquest/view/Auth/login.dart';
import 'package:cityquest/view/Auth/register.dart';
import 'package:cityquest/view/widgets/register.button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 2), () {
      Get.to(RegisterView());
    });
    return Scaffold(
      backgroundColor: Colors.white10,
      body: Center(
        child: Image.asset(
          'assets/images/mainlogo.png',
          width: 180,
          height: 180,
        ),
      ),
    );
  }
}
