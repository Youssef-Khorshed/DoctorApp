// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/chats/userMessages.dart';
import 'package:flutter_auth/Shared/components/screenutil.dart';
import 'package:flutter_auth/ViewModels/HomeViewModel/cubit.dart';
import 'package:flutter_auth/ViewModels/HomeViewModel/states.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ConnectionWidget extends StatelessWidget {
  UserModel userModel;

  ConnectionWidget({Key key, this.userModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    Util(context);
    HomeCubit cubit = HomeCubit.get(context);

    return BlocConsumer<HomeCubit, HomeStates>(
        builder: (context, state) {
          return Column(children: [
            build_profile_picture_name(
              context,
              Image.network(
                '${userModel.imagePath}',
                width: ScreenUtil().setWidth(size.width * 0.5),
                height: ScreenUtil().setHeight(size.height * 0.5),
                fit: BoxFit.cover,
              ),
              'Dr.${userModel.name}',
              size,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  buildButton(context,
                      value: Icons.add_to_photos_rounded,
                      text: cubit.follow[userModel.uId] == true
                          ? 'followed'
                          : 'follow', function: () async {
                    await cubit.checkfollow(userModel: userModel);
                  }),
                  SizedBox(
                    width: ScreenUtil().setWidth(10),
                  ),
                  buildButton(context, value: Icons.message, text: 'message',
                      function: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Messages(
                                  userModel: userModel,
                                )));
                  }),
                ],
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(50),
            ),
            buildAbout(userModel, size),
            SizedBox(
              height: ScreenUtil().setHeight(size.height * 0.18),
            ),
          ]);
        },
        listener: (context, state) {});
  }

  Widget buildButton(BuildContext context,
          {IconData value, String text, Function function}) =>
      Expanded(
        child: MaterialButton(
          color: Colors.deepPurple[100],
          padding: EdgeInsets.symmetric(vertical: 4),
          onPressed: function,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          child: Column(
            children: [
              Icon(
                value,
                color: Colors.deepPurple,
                size: ScreenUtil().setSp(90),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(10),
              ),
              Text(
                text,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(50),
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple),
              )
            ],
          ),
        ),
      );

  Widget build_profile_picture_name(BuildContext context, Image picture_profile,
          String doctor_name, size) =>
      Column(children: [
        SizedBox(
          height: ScreenUtil().setHeight(10),
        ),
        CircleAvatar(
            radius: (ScreenUtil().radius(120)),
            backgroundColor: Colors.deepPurple,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(80),
              child: picture_profile,
            )),
        SizedBox(
          height: ScreenUtil().setHeight(50),
        ),
        Text("${doctor_name}",
            style: TextStyle(
                color: Colors.deepPurple,
                fontSize: ScreenUtil().setSp(size.height > 800 ? 70 : 55))),
        SizedBox(
          height: 30,
        ),
      ]);
  Widget buildAbout(UserModel user, size) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(size.height > 800 ? 80 : 60),
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(height: ScreenUtil().setHeight(10)),
            Text(
              user.about,
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(size.height > 800 ? 70 : 50),
                  height: 1.4),
            ),
          ],
        ),
      );
}
