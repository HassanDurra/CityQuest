import 'package:cityquest/assets/colors.dart';
import 'package:cityquest/view/Auth/login.dart';
import 'package:cityquest/view/Auth/buttons/login.button.dart';
import 'package:cityquest/view/Auth/forgot_password.dart';
import 'package:cityquest/view/Auth/buttons/register.button.dart';
import 'package:cityquest/view/widgets/social.login.dart';
import 'package:cityquest/view/widgets/text.form.global.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatefulWidget {
  RegisterView({
    Key? key,
  }) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool _isObscure = true;
  bool _isObscurepassword = true;

  final TextEditingController userNameController = TextEditingController();

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
                    SizedBox(height: 20),

                    ///email
                    Container(
                      height: 50,
                      child: TextFormField(
                        controller: userNameController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: 'Enter Username',
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
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

                    ///password
                    SizedBox(height: 10),
                    Container(
                      height: 50,
                      child: TextFormField(
                        controller: passwordController,
                        keyboardType: TextInputType.text,
                        obscureText:
                            _isObscurepassword, // Use the _isObscure variable to toggle visibility
                        decoration: InputDecoration(
                          hintText: 'Enter Password',
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscurepassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: _isObscurepassword
                                  ? Colors.grey
                                  : GlobalColors
                                      .mainColor, // Change icon color based on visibility state
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscurepassword =
                                    !_isObscurepassword; // Toggle visibility state
                              });
                            },
                          ),
                        ),
                      ),
                    ),

                    ///confirm password
                    SizedBox(height: 10),

                    Container(
                      height: 50,
                      child: TextFormField(
                        controller: confirmpasswordController,
                        keyboardType: TextInputType.text,
                        obscureText:
                            _isObscure, // Use the _isObscure variable to toggle visibility
                        decoration: InputDecoration(
                          hintText: 'Confirm Password',
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
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

                    // button
                    SizedBox(height: 15),

                    RegisterButton(
                        usernameController: userNameController,
                        emailController: emailController,
                        passwordController: passwordController,
                        confirmpasswordController: confirmpasswordController),
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
