import 'package:cityquest/assets/colors.dart';
import 'package:cityquest/view/Auth/buttons/verification.button.dart';
import 'package:cityquest/view/Auth/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationView extends StatefulWidget {
  final String email;
  const VerificationView({
    required this.email,
    super.key,
  });

  @override
  State<VerificationView> createState() => _VerificationViewState();
}

class _VerificationViewState extends State<VerificationView> {
  final TextEditingController verificationController = TextEditingController();

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
                      "Verification Code",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'Poppins',
                      ),
                    ),

                    SizedBox(height: 20),
                    Text(
                      "Enter the verification that we have sent to the email:\t " +
                          widget.email +
                          "\t Use it to reset your password.",
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
                        controller: verificationController,
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          hintText: 'Enter Verification',
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    // button
                    //  SizedBox(height: 15),
                    // RegisterView(),

                    SizedBox(height: 10),
                      VerificationButton(email: widget.email, verification: verificationController),
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
