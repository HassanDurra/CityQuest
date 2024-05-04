import 'dart:async';
import 'dart:convert';

import 'package:cityquest/view/Auth/reset_password.dart';
import 'package:cityquest/webapi/cityquestweb.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;

class VerificationButton extends StatefulWidget {
  final String email;
  final TextEditingController verification;
  const VerificationButton(
      {super.key, required this.email, required this.verification});

  @override
  State<VerificationButton> createState() => _VerificationButtonState();
}

class _VerificationButtonState extends State<VerificationButton> {
  bool is_Loading = false;
  @override
  Widget build(BuildContext context) {
    Future<void> verification() async {
      try {
        final URL = Uri.parse(
            apiCredientals.base_url+"CityQuestWEB/Verification/verify_code");
        var response = await http.post(URL,
            body: {'email': widget.email, 'code': widget.verification.text});
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
                    'Verification Successfull Redirecting \n to Reset password form',
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
              Get.offAll(ResetPasswordView(email: widget.email));
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
      if (widget.verification.text.isEmpty) {
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
      } else {
        verification();
        setState(() {
          is_Loading = true;
        });
      }
    }

    ;
    return InkWell(
      onTap: is_Loading
          ? null
          : () async {
              checkVerification();
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
            : Text("Verify Code", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
