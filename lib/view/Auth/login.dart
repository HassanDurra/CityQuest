import 'package:cityquest/assets/colors.dart';
import 'package:cityquest/view/Auth/register.dart';
import 'package:cityquest/view/Auth/buttons/login.button.dart';
import 'package:cityquest/view/Auth/forgot_password.dart';
import 'package:cityquest/view/widgets/social.login.dart';
import 'package:cityquest/view/widgets/text.form.global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class LoginView extends StatefulWidget {
  LoginView({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _isObscure = true;
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

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
                      "Login to your account",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),

                    /////email
                    SizedBox(height: 20),
                    Container(
                      height: 50,
                      child: TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Enter Email',
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color:
                                    const Color.fromARGB(210, 158, 158, 158)),
                          ),
                        ),
                      ),
                    ),

                    ///password
                    SizedBox(height: 15),
                    Container(
                      height: 50,
                      child: TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        obscureText:
                            _isObscure, // Use the _isObscure variable to toggle visibility
                        decoration: InputDecoration(
                          hintText: 'Enter Password',
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Color.fromARGB(210, 158, 158, 158)),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: _isObscure
                                  ? Colors.grey
                                  : GlobalColors
                                      .mainColor, // Change icon color based on visibility state
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure =
                                    !_isObscure; // Toggle visibility state
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                    /////button
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () => {Get.to(ForgotPasswordView())},
                      child: Container(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          "Forget Password ? ",
                          style: TextStyle(
                              color: GlobalColors.mainColor,
                              fontSize: 13,
                              fontFamily: 'poppins'),
                        ),
                      ),
                    ),

                    SizedBox(height: 15),
                    LoginButton(
                        emailController: emailController,
                        passwordController: passwordController),

                    //social img
                    SizedBox(height: 15),
                    SociaLogin(),
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
              'Don\'t have an account?',
            ),
            SizedBox(
              width: 5,
            ),
            InkWell(
              onTap: () => {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => RegisterView()))
              },
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
