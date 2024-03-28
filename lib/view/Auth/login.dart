import 'dart:math';
import 'dart:ui';

import 'package:cityquest/assets/colors.dart';
import 'package:cityquest/view/widgets/button.global.dart';
import 'package:cityquest/view/widgets/social.login.dart';
import 'package:cityquest/view/widgets/text.form.global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
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
      body: SingleChildScrollView(
        physics: ClampingScrollPhysics(),
        child: Stack(
          children: [
            SizedBox(height: 5),
            Container(
              child: SafeArea(
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(20.5),
                  margin: EdgeInsets.symmetric(
                      horizontal: 20, vertical: 40), // Margin set kiya gaya hai
                  decoration: BoxDecoration(
                    color: Colors.white, // Border radius set kiya gaya hai
                    // Background color set kiya gaya hai
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.center,
                        child: Image.asset(
                          'images/mainlogo.png',
                          width: 70,
                          height: 50,
                          fit: BoxFit.cover,
                          alignment: Alignment.center,
                        ),
                      ),

                      SizedBox(height: 15),
                      Padding(padding: EdgeInsets.all(10)),
                      Text(
                        "Login to your account",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'Poppins',
                        ),
                      ),
                      SizedBox(height: 15),

                      ///email input
                      Container(
                        decoration: BoxDecoration(
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
                          border: Border.all(color: Colors.grey, width: 1),
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
                      SizedBox(height: 20),
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
