import 'dart:async';

import 'package:cityquest/view/Auth/login.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication {
  Future<void> Logout() async {
      var pref = await SharedPreferences.getInstance();
      pref.remove('user');
      Get.to(LoginView());
    
  }
}
