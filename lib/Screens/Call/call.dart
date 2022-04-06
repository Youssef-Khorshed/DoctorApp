import 'package:flutter/material.dart';
import 'package:flutter_auth/Shared/size_config.dart';
import 'package:flutter_auth/models/user.dart';
import 'components/body_call.dart';

class AudioCallWithImage extends StatelessWidget {
  UserModel userModel;
  AudioCallWithImage({this.userModel});
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Body(userModel: userModel),
    );
  }
}
