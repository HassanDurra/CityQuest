import 'dart:html';

import 'package:cityquest/view/Auth/login.dart';
import 'package:cityquest/view/Auth/register.dart';
import 'package:flutter/material.dart';


class SendLoginLink extends StatelessWidget {
  const SendLoginLink({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
     
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => RegisterView()),
        );
      }
    );
  }}