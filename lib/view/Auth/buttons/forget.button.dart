import 'dart:async';
import 'dart:convert';

import 'package:cityquest/view/Auth/login.dart';
import 'package:cityquest/view/Auth/verification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;

class ForgetButton extends StatefulWidget {
  final TextEditingController emailController;
  const ForgetButton({super.key, required this.emailController});

  @override
  State<ForgetButton> createState() => _ForgetButtonState();
}

class _ForgetButtonState extends State<ForgetButton> {
  bool is_Loading = false;
  @override
  Widget build(BuildContext context) {
    bool isValidEmail(String email) {
      RegExp emailRegx = RegExp(
        r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
        caseSensitive: false,
        multiLine: false,
      );
      return emailRegx.hasMatch(email);
    }

    Future<void> sendVerification(email) async {
      try {
        final URL = Uri.parse(
            'http://localhost/CityQuestWEB/Verification/verification_code');
        var response = await http.post(URL, body: {'email': email});
        // Validation
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
                  Text('No account associated with the email: \n' + email)
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
                    Ionicons.checkmark_circle_outline,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text('Verification code has been sent to the email')
                ],
              ),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green,
            ));
            setState(() {
              is_Loading = true;
            });
            Timer(Duration(seconds: 2), () {
              Get.offAll(VerificationView(
                email: widget.emailController.text,
              ));
            });
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              'Error: ${response.statusCode}',
              style: TextStyle(
                  fontSize: 13, color: Colors.white, fontFamily: 'poppins'),
            ),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ));
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Error: $e',
            style: TextStyle(
                fontSize: 13, color: Colors.white, fontFamily: 'poppins'),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ));
      }
    }

    Future<void> sendEmail() async {
      setState(() {
        is_Loading = true;
      });
      if (widget.emailController.text.isEmpty) {
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
              Text('Please Provide an email address')
            ],
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ));
        setState(() {
          is_Loading = false;
        });
      } else if (!isValidEmail(widget.emailController.text)) {
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
              Text('Please Provide valid email address')
            ],
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ));
        setState(() {
          is_Loading = false;
        });
      } else {
        sendVerification(widget.emailController.text);
        setState(() {
          is_Loading = true;
        });
      }
    }

    return InkWell(
      onTap: is_Loading
          ? null
          : () async {
              sendEmail();
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
            : Text("Send Verification", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
