import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: SingleChildScrollView(
      child: SafeArea(
          child: Container(
            width: double.infinity,
              padding: EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Text("Logo"),
                ],
              ))),
    ));
  }
}
