import 'package:cityquest/assets/colors.dart';
import 'package:cityquest/view/Auth/login.dart';
import 'package:cityquest/view/widgets/button.global.dart';
import 'package:cityquest/view/widgets/forgot_password.dart';
import 'package:cityquest/view/widgets/register.button.dart';
import 'package:cityquest/view/widgets/social.login.dart';
import 'package:cityquest/view/widgets/text.form.global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {
  RegisterView({
    Key? key,
  }) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController =
      TextEditingController();

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
                      "Create Account",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),

                    ///email
                    SizedBox(height: 20),
                    TextFormGlobal(
                      controller: emailController,
                      text: 'Email',
                      obscure: false,
                      textInputType: TextInputType.emailAddress,
                    ),

                    ///password
                    SizedBox(height: 10),
                    TextFormGlobal(
                      controller: passwordController,
                      text: 'Password',
                      obscure: true,
                      textInputType: TextInputType.text,
                    ),

                    ///confirm password
                    SizedBox(height: 10),
                    TextFormGlobal(
                      controller: confirmpasswordController,
                      text: 'Confirm Password',
                      obscure: true,
                      textInputType: TextInputType.text,
                    ),
                    // button
                    SizedBox(height: 15),
                    RegisterButton(
                        emailController: emailController,
                        passwordController: passwordController,
                        confirmController: confirmpasswordController),

                    //Forgot Password
                    SizedBox(height: 10),
                    InkWell(
                      onTap: () {
                        // Navigate to Forgot Password view
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => LoginView(),
                          ),
                        );
                      },
                      child: Text(
                        'Already have an Account ?',
                        style: TextStyle(
                          color: GlobalColors.mainColor,
                        ),
                      ),
                    ),
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
              style: TextStyle(
                fontSize: 10,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              child: Text(
                'Terms , Privacy Policy and Cookies Policy.',
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
