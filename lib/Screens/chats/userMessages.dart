// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/chats/chats.dart';
import 'package:flutter_auth/Screens/chats/receive_message.dart';
import 'package:flutter_auth/Screens/chats/send_message.dart';
import 'package:flutter_auth/Shared/components/screenutil.dart';
import 'package:flutter_auth/Shared/globalvariables/global.dart';
import 'package:flutter_auth/Shared/constants.dart';
import 'package:flutter_auth/ViewModels/HomeViewModel/cubit.dart';
import 'package:flutter_auth/ViewModels/HomeViewModel/states.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../models/message.dart';

class Messages extends StatelessWidget {
  UserModel userModel;

  Messages({this.userModel});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Util(context);

    HomeCubit cubit = HomeCubit.get(context);

    if (userModel.uId.toString().isNotEmpty) {
      cubit.getmessages(
        reciever: userModel.uId,
      );
    }
    return BlocConsumer<HomeCubit, HomeStates>(
      builder: (context, state) {
        HomeCubit cubit = HomeCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
                onPressed: () async {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => Chats()));
                },
                icon: Icon(Icons.arrow_back),
                color: Colors.white,
                iconSize: ScreenUtil().radius(50)),
            backgroundColor: Color.fromRGBO(53, 23, 102, 1),
            title: Text(
              user.type == 'user'
                  ? 'Dr.${userModel.name}'
                  : '${userModel.name}',
              style: TextStyle(fontSize: ScreenUtil().setSp(50)),
            ),
            centerTitle: true,
            actions: [
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ClipOval(
                      child: Image.network(
                    '${userModel.imagePath}',
                    height: ScreenUtil().setHeight(
                        size.height >= 800 && size.width >= 800 ? 60 : 50),
                    width: ScreenUtil().setWidth(
                        size.height >= 800 && size.width >= 800 ? 60 : 50),
                    fit: BoxFit.fill,
                  ))),
            ],
          ),
          body: LayoutBuilder(
            builder: ((context, constraints) {
              return ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage('assets/images/chatground.jpg'),
                            fit: BoxFit.cover)),
                    child: Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                              physics: BouncingScrollPhysics(),
                              itemBuilder: (con, ind) =>
                                  cubit.messages[ind].sender == user.uId
                                      ? Send_Message(
                                          message: cubit.messages[ind].text)
                                      : Receive_Message(
                                          message: cubit.messages[ind].text),
                              separatorBuilder: (con, ind) => Container(
                                    height: 5,
                                  ),
                              itemCount: cubit.messages.length),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0),
                                  child: TextFormField(
                                    controller: cubit.text,
                                    cursorColor: Colors.black,
                                    keyboardType: TextInputType.text,
                                    style: TextStyle(
                                        fontSize: 15, color: Colors.black),
                                    decoration: InputDecoration(
                                        fillColor: Colors.grey.shade200,
                                        hintStyle: TextStyle(
                                            fontSize: 15, color: Colors.grey),
                                        hintText: 'Type your message ...',
                                        border: InputBorder.none),
                                  ),
                                ),
                              ),
                            ),
                            IconButton(
                                onPressed: () {
                                  DateTime now = DateTime.now();
                                  String date =
                                      DateFormat('MM/dd/yyy').format(now);
                                  String time =
                                      DateFormat('HH:mm:ss').format(now);
                                  cubit.text.toString().isNotEmpty
                                      ? cubit.set_message(
                                          sender: user.uId,
                                          reciever: userModel.uId,
                                          message: MessageModel.data(
                                              sender: user.uId,
                                              reciever: userModel.uId,
                                              date: date,
                                              time: time,
                                              text: cubit.text.text))
                                      : print('null;');
                                  cubit.text.clear();
                                },
                                icon: CircleAvatar(
                                  backgroundColor: kBackgoundColor,
                                  radius: ScreenUtil().radius(50),
                                  child: Icon(
                                    Icons.arrow_forward_rounded,
                                    color: Colors.white,
                                  ),
                                ))
                          ],
                        ),
                      ],
                    )),
              );
            }),
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
