import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/chats/userMessages.dart';
import 'package:flutter_auth/Shared/components/screenutil.dart';
import 'package:flutter_auth/Shared/globalvariables/global.dart';
import 'package:flutter_auth/ViewModels/HomeViewModel/cubit.dart';
import 'package:flutter_auth/ViewModels/HomeViewModel/states.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget Chat(
    {@required UserModel userModel,
    @required BuildContext context,
    @required HomeCubit bloc}) {
  Size size = MediaQuery.of(context).size;
  Util(context);
  if (bloc.followed.isNotEmpty) {
    if ((bloc.followed[userModel.uId] == true && user.type == 'doctor') ||
        (user.type == 'user')) {
      print('yes');
      return Padding(
        padding: EdgeInsets.all(ScreenUtil().setSp(20)),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Messages(userModel: userModel),
                ));
          },
          child: Container(
            height: ScreenUtil().setHeight(150),
            width: double.infinity,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
            child: ListTile(
              leading: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  '${userModel.imagePath}',
                  height: ScreenUtil().setHeight(
                      size.height >= 800 && size.width >= 800 ? 700 : 400),
                  width: ScreenUtil().setWidth(
                      size.height >= 800 && size.width >= 800 ? 90 : 70),
                  fit: BoxFit.fill,
                ),
              ),
              title: Text(
                user.type == 'user'
                    ? 'Dr.${userModel.name}'
                    : '${userModel.name}',
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(
                        size.height >= 800 && size.width >= 800 ? 70 : 40),
                    color: Colors.black),
              ),
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

Widget Line({BuildContext context}) {
  Util(context);
  return Padding(
    padding: EdgeInsets.only(left: ScreenUtil().setSp(150)),
    child: Container(
      width: double.infinity,
      height: 1,
      color: Colors.grey[400],
    ),
  );
}
