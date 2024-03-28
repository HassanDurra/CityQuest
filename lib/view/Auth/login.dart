import 'package:cityquest/assets/colors.dart';
import 'package:cityquest/view/widgets/button.global.dart';
import 'package:cityquest/view/widgets/social.login.dart';
import 'package:cityquest/view/widgets/text.form.global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
      child: SafeArea(
          child: Container(
              width: double.infinity,
              padding: EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                            const SizedBox(height: 20),
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      "Logo",
                      style: TextStyle(
                        color: GlobalColors.mainColor,
                        fontSize: 35,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),
                  Text(
                    "Login to your account",
                    style: TextStyle(
                      color: GlobalColors.textColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 15),
                  ///email input
                  TextFormGlobal(
                    controller: emailController,
                    text: 'Email',
                    obscure: false,
                    textInputType: TextInputType.emailAddress,
                  ),
                         const SizedBox(height: 10),
                         
                    ///password input
                       TextFormGlobal(
                    controller: passwordController,
                    text: 'Password',
                    obscure: true,
                    textInputType: TextInputType.text,
                  ),
                  //button
                      const SizedBox(height: 10),
                      const ButtonGlobal(),
                      //social login

                       const SizedBox(height: 25),
                       SociaLogin(),

                ],
              ),
              ),
              ),
    ),
    bottomNavigationBar: Container(
      height: 50,
      color: Colors.white,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [Text
        ('Don\'t have an account?',
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
