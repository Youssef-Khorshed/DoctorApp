// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/Call/call.dart';
import 'package:flutter_auth/Screens/Call/components/Crounded_button.dart';
import 'package:flutter_auth/Screens/DoctorProfile/Component/connection.dart';
import 'package:flutter_auth/Screens/DoctorProfile/doctor_profile.dart';
import 'package:flutter_auth/Screens/HomeScreen/components/doctors_profile.dart';
import 'package:flutter_auth/Shared/constants.dart';
import 'package:flutter_auth/Shared/size_config.dart';
import 'package:flutter_auth/models/user.dart';

class Body extends StatelessWidget {
  UserModel userModel;
  Body({this.userModel});
  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // Image
        Image.network(
          '${userModel.imagePath}',
          fit: BoxFit.cover,
        ),
        // Black Layer
        DecoratedBox(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.3)),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Dr.${userModel.name}',
                  style: Theme.of(context)
                      .textTheme
                      .headline3
                      .copyWith(color: Colors.white),
                ),
                VerticalSpacing(of: 10),
                Text(
                  "Incoming 00:01".toUpperCase(),
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RoundedButton(
                      press: () {},
                      iconSrc: "assets/icons/Icon Mic.svg",
                    ),
                    RoundedButton(
                      press: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Doctor_profile(userModel)));
                      },
                      color: kRedColor,
                      iconColor: Colors.white,
                      iconSrc: "assets/icons/call_end.svg",
                    ),
                    RoundedButton(
                      press: () {},
                      iconSrc: "assets/icons/Icon Volume.svg",
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
