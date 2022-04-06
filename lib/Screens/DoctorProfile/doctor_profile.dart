// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/DoctorProfile/Component/connection.dart';
import 'package:flutter_auth/Screens/HomeScreen/home_screen.dart';
import 'package:flutter_auth/Shared/components/screenutil.dart';
import 'package:flutter_auth/Shared/constants.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Doctor_profile extends StatelessWidget {
  UserModel userModel;
  Doctor_profile(this.userModel);
  @override
  Widget build(BuildContext context) {
    Util(context);
    return Scaffold(
        backgroundColor: Colors.deepPurple[50],
        appBar: AppBar(
          title: Text(
            'Doctor page',
            style: TextStyle(
              fontSize: ScreenUtil().setSp(50),
            ),
          ),
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(builder: (builder) => HomeScreen()));
              },
              icon: Icon(
                Icons.arrow_back,
                size: ScreenUtil().setSp(50),
              )),
          //title: Text("Dr / "),
          backgroundColor: kPrimaryColor,
          elevation: 0,
        ),
        body: ListView(physics: BouncingScrollPhysics(), children: [
          ConnectionWidget(
            userModel: userModel,
          )
        ]));
  }
}
