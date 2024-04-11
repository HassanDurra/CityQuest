import 'dart:async';
import 'dart:convert';

import 'package:cityquest/view/Auth/login.dart';
import 'package:cityquest/view/widgets/User/home.dart';
import 'package:cityquest/view/widgets/User/partial/navbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class Authentication {
  //To Store Data of User In Shared Preferences
  Future<void> storeData(data) async {
    var pref = await SharedPreferences.getInstance();
    await pref.setString('user', data);
  }

  Future<void> Register(BuildContext context, email, password, username) async {
    try {
      final url = Uri.parse("http://localhost/CityQuestWEB/User/register");
      var response = await http.post(url, body: {
        'email': email,
        'password': password,
        'username': username,
      });
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['message'] == "success") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Row(
              children: [
                Icon(Ionicons.checkmark_circle_outline, color: Colors.white),
                SizedBox(width: 5),
                Text(
                  'Registration successful. Redirecting to login...',
                  style: TextStyle(
                      fontSize: 13, color: Colors.white, fontFamily: 'poppins'),
                )
              ],
            ),
            duration: Duration(seconds: 2),
            backgroundColor: const Color.fromARGB(255, 5, 182, 97),
          ));
          Timer(const Duration(seconds: 2), () {
            Get.to(LoginView());
          });
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Row(
              children: [
                Icon(
                  Ionicons.alert_circle,
                  color: Colors.white,
                ),
                SizedBox(width: 5),
                Text(
                  jsonResponse['message'] ?? 'Unknown error occurred',
                  style: TextStyle(
                      fontSize: 13, color: Colors.white, fontFamily: 'poppins'),
                )
              ],
            ),
            duration: Duration(seconds: 2),
            backgroundColor: Colors.red,
          ));
        }
      } else {
        // Handle non-200 status code
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Error: ${response.statusCode}',
            style: TextStyle(
                fontSize: 13, color: Colors.white, fontFamily: 'poppins'),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Error: $e',
          style: TextStyle(
              fontSize: 13, color: Colors.white, fontFamily: 'poppins'),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> login(BuildContext context, email, password) async {
    try {
      final URL = Uri.parse("http://localhost/CityQuestWEB/User/login");
      var response = await http.post(URL, body: {
        'email': email,
        'password': password,
      });
      // If response is valid
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        if (jsonResponse['message'] == "success") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Row(
              children: [
                Icon(
                  Ionicons.checkmark_circle_outline,
                  color: Colors.white,
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  'Login successfull redirecting to home..!',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
            backgroundColor: const Color.fromARGB(255, 5, 182, 97),
            duration: Duration(seconds: 2),
          ));
          // Storing The User data to shared Procedure Storage
          storeData(jsonResponse['user']);
          Timer(Duration(seconds: 2), () {
            Get.offAll(() => Navbar());
          });
        } else if (jsonResponse['message'] == 'invalid email') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Row(
                children: [
                  Icon(
                    Ionicons.alert_circle_outline,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Error : Failed to authenticate \n invalid email',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red));
        } // If email is invalid
        else if (jsonResponse['message'] == "invalid password") {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Row(
                children: [
                  Icon(
                    Ionicons.alert_circle_outline,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Error : Failed to authenticate \n incorrect password',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red));
        } // If password is incorrect

        else if (jsonResponse['message'] == 'unverified') {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Row(
                children: [
                  Icon(
                    Ionicons.alert_circle_outline,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Error : Please verify your \n account before login',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red));
        } //  If Account is not verified
        else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Row(
                children: [
                  Icon(
                    Ionicons.alert_circle_outline,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    'Error : An error Occured',
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.red));
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            'Error: ${response.statusCode}',
            style: TextStyle(
                fontSize: 13, color: Colors.white, fontFamily: 'poppins'),
          ),
          duration: Duration(seconds: 2),
          backgroundColor: Colors.red,
        ));
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
          'Error: $e',
          style: TextStyle(
              fontSize: 13, color: Colors.white, fontFamily: 'poppins'),
        ),
        duration: Duration(seconds: 2),
        backgroundColor: Colors.red,
      ));
    }
  }

  Future<void> Logout() async {
    var pref = await SharedPreferences.getInstance();
    pref.remove('user');
    Get.to(LoginView());
  }
  

}
