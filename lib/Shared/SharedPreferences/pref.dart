import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/LoginScreen/login_screen.dart';
import 'package:flutter_auth/Shared/globalvariables/global.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preference {
  static SharedPreferences preferences;
  static intial() async {
    preferences = await SharedPreferences.getInstance();
  }

  static Future<bool> put({String key, String value}) async {
    return await preferences.setString(key, value);
  }

  static String get({String key}) {
    return preferences.getString(key);
  }

  static void clearprefrences({BuildContext context}) {
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
    userid = null;
  }
}
