import 'dart:async';
import 'dart:convert';
import 'package:cityquest/assets/colors.dart';
import 'package:cityquest/view/Auth/login.dart';
import 'package:cityquest/view/Class/Authentication.dart';
import 'package:cityquest/view/widgets/User/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginButton extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const LoginButton({
    Key? key,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  State<LoginButton> createState() => _LoginButtonState();
}

class _LoginButtonState extends State<LoginButton> {
  @override
  Widget build(BuildContext context) {
    // Login Function ends
    bool isValidEmail(String email) {
      RegExp emailRegx = RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
        caseSensitive: false,
        multiLine: false,
      );
      return emailRegx.hasMatch(email);
    }

    return InkWell(
      onTap: () {
        // Check if email or password is empty
        if (widget.emailController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(
                    Ionicons.alert_circle_outline,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Please Enter Email",
                    style: TextStyle(fontFamily: 'poppins'),
                  )
                ],
              ),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
            ),
          );
        } else if (!isValidEmail(widget.emailController.text)) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(
                    Ionicons.alert_circle_outline,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Please Enter Valid Email Address",
                    style: TextStyle(fontFamily: 'poppins'),
                  )
                ],
              ),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
            ),
          );
        } else if (widget.passwordController.text.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(
                    Ionicons.alert_circle_outline,
                    color: Colors.white,
                  ),
                  SizedBox(width: 5),
                  Text(
                    "Please Enter Password",
                    style: TextStyle(fontFamily: 'poppins'),
                  )
                ],
              ),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
            ),
          );
        } else {
          // Authentication Procedure
          Authentication auth = new Authentication();
          auth.login(context, widget.emailController.text,
              widget.passwordController.text);
          // Function available at line number : 25
        }
      },
      child: Container(
        alignment: Alignment.center,
        height: 55,
        decoration: BoxDecoration(
          color: Color.fromARGB(255, 8, 111, 145),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: Color.fromARGB(255, 8, 111, 145),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(82, 4, 5, 5),
              blurRadius: 5,
            ),
          ],
        ),
        child: const Text(
          'Sign In',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w300,
            fontFamily: 'poppins',
          ),
        ),
      ),
    );
  }
}
