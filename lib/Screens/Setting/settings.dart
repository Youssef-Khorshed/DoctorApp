import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/LoginScreen/login_screen.dart';
import 'package:flutter_auth/Shared/components/screenutil.dart';
import 'package:flutter_auth/Shared/globalvariables/global.dart';
import 'package:flutter_auth/Shared/constants.dart';
import 'package:flutter_auth/Shared/SharedPreferences/pref.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    Util(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back,
            color: kPrimaryColor,
            size: ScreenUtil().setSp(60),
          ),
        ),
      ),
      body: Center(
          // ignore: deprecated_member_use
          child: RaisedButton(
        onPressed: () {
          userid = null;
          Preference.put(key: 'id', value: 'null');
          nextwidget = LoginScreen();
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LoginScreen()));
        },
        color: kPrimaryColor,
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(50)),
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Text(
          "SIGN OUT",
          style: TextStyle(
              fontSize: ScreenUtil().setSp(50),
              letterSpacing: ScreenUtil().setSp(2.9),
              color: Colors.white),
        ),
      )),
    );
  }
}
