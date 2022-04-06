import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/DoctorProfile/Component/connection.dart';
import 'package:flutter_auth/Screens/DoctorProfileDetails/components/followers.dart';
import 'package:flutter_auth/Screens/DoctorProfileDetails/components/pic_profile.dart';
import 'package:flutter_auth/Screens/DoctorProfileDetails/components/user_preference.dart';
import 'package:flutter_auth/Shared/constants.dart';
import 'package:flutter_auth/models/user.dart';

class DoctorProfileDetail extends StatelessWidget {
  DoctorProfileDetail({Key key}) : super(key: key);
  final user = UserPreferences.myUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepPurple[50],
        appBar: AppBar(
          leading: BackButton(),
          backgroundColor: kPrimaryColor,
          elevation: 0,
        ),
        body: ListView(physics: BouncingScrollPhysics(), children: [
          const SizedBox(height: 48),
          ProfileWidget(
            imagePath: user.imagePath,
            onClicked: () async {},
          ),
          const SizedBox(height: 24),
          buildName(user),
          const SizedBox(height: 24),
          FollowersWidget(),
          const SizedBox(height: 24),
          ConnectionWidget(),
          const SizedBox(height: 24),
          buildAbout(user),
        ]));
  }

  Widget buildName(UserModel user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );
  Widget buildAbout(UserModel user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.about,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
