import 'dart:async';
import 'dart:convert';

import 'package:cityquest/view/Auth/login.dart';
import 'package:cityquest/webapi/cityquestweb.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;

class ResetPasswordButton extends StatefulWidget {
  final String email;
  final TextEditingController newPassword;
  final TextEditingController confirmPassword;
  const ResetPasswordButton(
      {super.key,
      required this.email,
      required this.newPassword,
      required this.confirmPassword});

  @override
  State<ResetPasswordButton> createState() => _ResetPasswordButtonState();
}

class _ResetPasswordButtonState extends State<ResetPasswordButton> {
  bool is_Loading = false;
  @override
  Widget build(BuildContext context) {
    Future<void> resetPassword() async {
      try {
        final URL = Uri.parse(
            apiCredientals.base_url+"CityQuestWEB/User/reset_password");
        var response = await http.post(URL,
            body: {'email': widget.email, 'password': widget.newPassword.text});
        if (response.statusCode == 200) {
          var jsonResponse = json.decode(response.body);
          if (jsonResponse['message'] == 'invalid email') {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Row(
                children: [
                  Icon(
                    Ionicons.alert_circle_outline,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Invalid Email Address no record found for the \n associated email.',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
            ));
            setState(() {
              is_Loading = false;
            });
          } else if (jsonResponse['message'] == 'success') {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Row(
                children: [
                  Icon(
                    Ionicons.alert_circle_outline,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Your Password has been changed \n Redirecting to Login',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green,
            ));
            setState(() {
              is_Loading = true;
            });
            Timer(const Duration(seconds: 2), () {
              Get.offAll(LoginView());
            });
          } else {
            setState(() {
              is_Loading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Row(
                children: [
                  Icon(
                    Ionicons.alert_circle_outline,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '${jsonResponse['message']}',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red,
            ));
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Row(
              children: [
                Icon(
                  Ionicons.alert_circle_outline,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Error: ${response.statusCode}',
                  style: TextStyle(
                      fontSize: 13, color: Colors.white, fontFamily: 'poppins'),
                )
              ],
            ),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ));
          setState(() {
            is_Loading = false;
          });
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
            children: [
              Icon(
                Ionicons.alert_circle_outline,
                color: Colors.white,
              ),
              SizedBox(
                width: 5,
              ),
              Text(
                'Error: $e',
                style: TextStyle(
                    fontSize: 13, color: Colors.white, fontFamily: 'poppins'),
              )
            ],
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ));
        setState(() {
          is_Loading = false;
        });
      }
    }

    Future<void> checkVerification() async {
      setState(() {
        is_Loading = true;
      });
      if (widget.newPassword.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
            children: [
              Icon(
                Ionicons.alert_circle_outline,
                color: Colors.red,
              ),
              SizedBox(
                width: 5,
              ),
              Text("Please provide a new Password")
            ],
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ));
        setState(() {
          is_Loading = false;
        });
      } else if (widget.newPassword.text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Row(
            children: [
              Icon(
                Ionicons.alert_circle_outline,
                color: Colors.red,
              ),
              SizedBox(
                width: 5,
              ),
              Text("Please confirm the new Password")
            ],
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ));
        setState(() {
          is_Loading = false;
        });
      }
      if (widget.newPassword.text.isNotEmpty &&
          widget.confirmPassword.text.isNotEmpty &&
          widget.confirmPassword.text != widget.newPassword.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              children: [
                Icon(
                  Ionicons.alert_circle_outline,
                  color: Colors.red,
                ),
                SizedBox(
                  width: 5,
                ),
                Text("Password Doesn't matched with Confirm Password")
              ],
            ),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ),
        );
        setState(() {
          is_Loading = false;
        });
      } else {
        resetPassword();
      }
    }

    ;
    return InkWell(
      onTap: is_Loading
          ? null
          : () async {
              resetPassword();
              setState(() {
                is_Loading = true;
              });
            },
      child: Container(
        alignment: Alignment.center,
        height: 50,
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
            ]),
        child: is_Loading
            ? CircularProgressIndicator(color: Colors.white)
            : Text("Reset Password", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
