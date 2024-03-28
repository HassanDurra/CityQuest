import 'dart:ui';

import 'package:cityquest/assets/colors.dart';
import 'package:cityquest/view/widgets/button.global.dart';
import 'package:cityquest/view/widgets/social.login.dart';
import 'package:cityquest/view/widgets/text.form.global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

class LoginView extends StatelessWidget {
  LoginView({
    Key? key,
  }) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ColorFiltered(
            colorFilter:
                ColorFilter.mode(Color.fromARGB(88, 0, 0, 0), BlendMode.darken),
            child: Image.asset('images/background.jpg',
                fit: BoxFit.cover,
                width: double.infinity,
                height: double.infinity),
          ),
          SizedBox(height: 30),
          SingleChildScrollView(
            child: SafeArea(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.5),
                margin: EdgeInsets.symmetric(
                    horizontal: 20, vertical: 40), // Margin set kiya gaya hai
                decoration: BoxDecoration(
                  border: Border.all(
                      color: Color.fromARGB(255, 148, 97, 2), width: 1.5),
                  borderRadius: BorderRadius.circular(
                      20), // Border radius set kiya gaya hai
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(50, 192, 104, 3), // Box shadow ka color set kiya gaya hai
                      spreadRadius:
                          5, // Box shadow ka spread radius set kiya gaya hai
                      blurRadius:
                          7, // Box shadow ka blur radius set kiya gaya hai
                      offset: Offset(
                          0, 3), // Box shadow ka offset set kiya gaya hai
                    ),
                  ],
                  color: Colors.black
                      .withOpacity(0.3), // Background color set kiya gaya hai
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                        'images/mainlogo.jpeg',
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                      ),
                    ),
                    SizedBox(height: 50),
                    Text(
                      "Login to your account",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    SizedBox(height: 20),

                    ///email input
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 148, 97, 2), width: 1.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormGlobal(
                        controller: emailController,
                        text: 'Email',
                        obscure: false,
                        textInputType: TextInputType.emailAddress,
                      ),
                    ),
                    SizedBox(height: 10),

                    ///password input
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: Color.fromARGB(255, 148, 97, 2), width: 1.5),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: TextFormGlobal(
                        controller: passwordController,
                        text: 'Password',
                        obscure: true,
                        textInputType: TextInputType.text,
                      ),
                    ),
                    //button
                    SizedBox(height: 10),
                    ButtonGlobal(),
                    //social login

                    SizedBox(height: 25),
                    SociaLogin(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        height: 50,
        color: Colors.white,
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Don\'t have an account?',
            ),
            InkWell(
              child: Text(
                'Sign Up',
                style: TextStyle(
                  color: GlobalColors.mainColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
