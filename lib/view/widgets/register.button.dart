import 'dart:async';
import 'dart:convert';

import 'package:cityquest/view/Auth/login.dart';
import 'package:cityquest/view/Class/Authentication.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:http/http.dart' as http;

class RegisterButton extends StatefulWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmpasswordController;

  const RegisterButton(
      {super.key,
      required this.emailController,
      required this.passwordController,
      required this.confirmpasswordController});

  @override
  State<RegisterButton> createState() => _RegisterButtonState();
}

class _RegisterButtonState extends State<RegisterButton> {
  bool is_loading = false;
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

    return InkWell(
      onTap: is_loading
          ? null
          : () async {
              setState(() {
                is_loading = true;
              });
              if (is_loading) {
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
                        Text(
                          'Email for Registeration is required',
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontFamily: 'poppins'),
                        )
                      ],
                    ),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.red,
                  ));
                  setState(() {
                    is_loading = false;
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
                        Text(
                          'Please enter a valid email',
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontFamily: 'poppins'),
                        )
                      ],
                    ),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.red,
                  ));
                  setState(() {
                    is_loading = false;
                  });
                }
                // Email Validation Ends here
                // Password Validations
                else if (widget.passwordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Row(
                        children: [
                          Icon(
                            Ionicons.alert_circle,
                            color: Colors.white,
                          ),
                          SizedBox(width: 5),
                          Text(
                            'Password is required',
                            style: TextStyle(
                                fontSize: 13,
                                color: Colors.white,
                                fontFamily: 'poppins'),
                          )
                        ],
                      ),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.red,
                    ),
                  );
                  setState(() {
                    is_loading = false;
                  });
                } else if (widget.passwordController.text.length < 8) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Row(
                      children: [
                        Icon(
                          Ionicons.alert_circle,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Password must be greater then or equal to 8 digits',
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontFamily: 'poppins'),
                        )
                      ],
                    ),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.red,
                  ));
                  setState(() {
                    is_loading = false;
                  });
                } else if (widget.confirmpasswordController.text.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Row(
                      children: [
                        Icon(
                          Ionicons.alert_circle,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          'Confirm Password is required',
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontFamily: 'poppins'),
                        )
                      ],
                    ),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.red,
                  ));
                  setState(() {
                    is_loading = false;
                  });
                } else if (widget.confirmpasswordController.text !=
                    widget.passwordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Row(
                      children: [
                        Icon(
                          Ionicons.alert_circle,
                          color: Colors.white,
                        ),
                        SizedBox(width: 5),
                        Text(
                          "Password and confirm password doesn't matched",
                          style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                              fontFamily: 'poppins'),
                        )
                      ],
                    ),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.red,
                  ));
                  setState(() {
                    is_loading = false;
                  });
                }
                // Password Validation Ends here
                // From here we will send the data to our db
                else {
                  Authentication auth = new Authentication();
                  auth.Register(context, widget.emailController.text,
                      widget.passwordController.text);
                  setState(() {
                    is_loading = true;
                  });
                }
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
            )
          ],
        ),
        child: is_loading
            ? CircularProgressIndicator(color: Colors.white)
            : Text(
                'Sign Up',
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
