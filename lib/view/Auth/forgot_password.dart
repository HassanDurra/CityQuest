import 'package:cityquest/assets/colors.dart';
import 'package:cityquest/view/Auth/login.dart';
import 'package:cityquest/view/Auth/register.dart';
import 'package:cityquest/view/Auth/buttons/login.button.dart';
import 'package:cityquest/view/Auth/forgot_password.dart';
import 'package:cityquest/view/Auth/buttons/register.button.dart';
import 'package:cityquest/view/widgets/send.link.dart';
import 'package:cityquest/view/widgets/social.login.dart';
import 'package:cityquest/view/widgets/text.form.global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class ForgotPasswordView extends StatelessWidget {
  ForgotPasswordView({
    Key? key,
  }) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController newpasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
              child: Image.asset(
            "images/background.png",
            fit: BoxFit.cover,
          )),
          Center(
            child: SingleChildScrollView(
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(color: Color.fromARGB(41, 0, 0, 0), blurRadius: 7)
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    Image.asset(
                      'images/mainlogo.png',
                      width: 70,
                      height: 70,
                      fit: BoxFit.contain,
                    ),

                    SizedBox(height: 20),
                    Text(
                      "Trouble logging in?",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),

                    SizedBox(height: 20),
                    Text(
                      "Enter your email, phone, or username and we'll  send you a link to get back into your account.",
                      style: TextStyle(
                        color: Color.fromARGB(255, 107, 104, 104),
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins',
                      ),
                    ),

                    ///email
                    SizedBox(height: 20),
                    Container(
                      height: 50,
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Enter Email',
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    // button
                    //  SizedBox(height: 15),
                    // RegisterView(),

                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {},
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
                        child: Text("Send Verification",
                            style: TextStyle(color: Colors.white)),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        Get.offAll(() => LoginView());
                      },
                      child: Text(
                        "Back to Login ?",
                        style: TextStyle(color: GlobalColors.mainColor),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
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
              'By signing up, you agree to our',
              style: TextStyle(fontSize: 10),
            ),
            SizedBox(
              width: 5,
            ),
            InkWell(
              child: Text(
                'Terms , Privacy Policy and Cookies Policy .',
                style: TextStyle(
                  fontSize: 10,
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
