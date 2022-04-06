// ignore_for_file: missing_return

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/DoctorProfile/doctor_profile.dart';
import 'package:flutter_auth/Shared/globalvariables/global.dart';
import 'package:flutter_auth/ViewModels/HomeViewModel/cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget DoctorProfile({BuildContext context, int index, HomeCubit cubit}) {
  if (cubit.followed.isNotEmpty) {
    if ((cubit.followed[cubit.users[index].uId] == true &&
            user.type == 'doctor') ||
        (user.type == 'user')) {
      return Padding(
        padding: EdgeInsets.only(
            left: ScreenUtil().setWidth(10), right: ScreenUtil().setWidth(15)),
        child: GestureDetector(
          onTap: () {
            user.type == 'user'
                ? Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          Doctor_profile(cubit.alldoctors[index]),
                    ))
                : null;
          },
          child: Container(
            height: ScreenUtil().setHeight(330),
            margin: EdgeInsets.all(ScreenUtil().setSp(15)),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ScreenUtil().setSp(40)),
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.deepPurple,
                    blurRadius: ScreenUtil().setSp(15),
                    offset:
                        Offset(ScreenUtil().setSp(15), ScreenUtil().setSp(15)),
                    spreadRadius: ScreenUtil().setSp(15),
                  )
                ]),
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: ScreenUtil().setWidth(15),
                        right: ScreenUtil().setWidth(20)),
                    child: Container(
                      width: ScreenUtil().setWidth(250),
                      height: ScreenUtil().setHeight(250),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(
                          ScreenUtil().setSp(40),
                        ),
                        color: Colors.deepPurple[200],
                      ),
                      child: (cubit.users.length != 0 ||
                              cubit.alldoctors.length != 0)
                          ? Image(
                              image: user.type == 'user'
                                  ? cubit.alldoctors.length != 0
                                      ? NetworkImage(
                                          '${cubit.alldoctors[index].imagePath}')
                                      : AssetImage(
                                          'assets/images/Kiran_Shakia.png')
                                  : (cubit.users.length != 0 &&
                                          cubit.users[index].imagePath
                                              .isNotEmpty)
                                      ? NetworkImage(
                                          '${cubit.users[index].imagePath}')
                                      : AssetImage(
                                          'assets/images/Kiran_Shakia.png'),
                              width: ScreenUtil().setWidth(180),
                              height: ScreenUtil().setHeight(180),
                              fit: BoxFit.cover,
                            )
                          : Text(''),
                    ),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 0,
                        top: ScreenUtil().setHeight(45),
                        bottom: ScreenUtil().setHeight(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user.type == 'user'
                              ? (cubit.alldoctors.length != 0
                                  ? "Dr.${cubit.alldoctors[index].name}"
                                  : "")
                              : (cubit.users.length != 0
                                  ? "${cubit.users[index].name}"
                                  : ""),
                          // "",
                          style: TextStyle(fontSize: ScreenUtil().setSp(45)),
                        ),
                        SizedBox(height: 5),
                        user.type == 'user'
                            ? Text("Desok hospital",
                                style:
                                    TextStyle(fontSize: ScreenUtil().setSp(38)))
                            : Text(''),
                        SizedBox(height: 5),
                        Row(
                          children: [
                            Expanded(
                                flex: 1,
                                child: Text("Phone: ",
                                    style: TextStyle(
                                        fontSize: ScreenUtil().setSp(38)))),
                            //SizedBox(width: 10),
                            Expanded(
                                flex: 3,
                                child: (cubit.users.length != 0 ||
                                        cubit.alldoctors.length != 0)
                                    ? Text(
                                        '${user.type == 'user' ? "${cubit.alldoctors[index].phone}" : "${cubit.users[index].phone}"}',
                                        style: TextStyle(
                                            fontSize: ScreenUtil().setSp(38)))
                                    : Text('')),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Expanded(
                            child: user.type == 'user'
                                ? (cubit.alldoctors.length != 0
                                    ? Text(
                                        //  cubit.check
                                        cubit.follow[
                                                cubit.alldoctors[index].uId]
                                            ? 'Followed '
                                            : 'Follow')
                                    : Text(''))
                                : cubit.users.length != 0
                                    ? Text(
                                        cubit.followed[cubit.users[index].uId]
                                            ? 'Followed '
                                            : 'Not Followed')
                                    : Text(''))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  } else {
    return Container();
  }
}
