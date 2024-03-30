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
      Get.to( RegisterView());
    });
    return const Scaffold(
        backgroundColor: Colors.white10,
        body: Center(
          child:  Text(
            'Logo',
            style: TextStyle(
                color: Colors.black, fontSize: 35, fontWeight: FontWeight.bold),
          ),
        ));
  }
}
