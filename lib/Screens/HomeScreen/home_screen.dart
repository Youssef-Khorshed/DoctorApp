// ignore_for_file: missing_required_param, must_call_super

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/HomeScreen/components/doctors_profile.dart';
import 'package:flutter_auth/Screens/Setting/components/edit_profile.dart';
import 'package:flutter_auth/Screens/chats/chats.dart';
import 'package:flutter_auth/Shared/components/screenutil.dart';
import 'package:flutter_auth/Shared/components/search.dart';
import 'package:flutter_auth/Shared/globalvariables/global.dart';
import 'package:flutter_auth/Shared/constants.dart';
import 'package:flutter_auth/ViewModels/HomeViewModel/cubit.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../ViewModels/HomeViewModel/states.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeCubit bloc;
  String type = '';
  List<UserModel> userdata = [];
  bool clearicon = false;
  Timer debouncer;

  @override
  void initState() {
    bloc = HomeCubit.get(context);
    searchuser(type);
    // getdata();
  }

  // void getdata() async {
  //   await bloc.getusers(id: userid, query: type);
  //   userdata = [];
  //   user.type == 'user' ? userdata = bloc.alldoctors : userdata = bloc.users;
  // }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeStates>(
      // ignore: missing_return
      builder: (context, state) {
        Util(context);

        return Scaffold(
          appBar: AppBar(
            title: Text("Dashboard",
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(50),
                ),
                textAlign: TextAlign.center),
            leading: IconButton(
              icon: Icon(
                Icons.person,
                color: Colors.white,
                size: ScreenUtil().setSp(70),
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => EditProfilePage()));
                //  print('doctors ${doctors.length}');
              },
            ),
            actions: [
              IconButton(
                  icon: Icon(
                    Icons.message,
                    size: ScreenUtil().setSp(60),
                    color: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Chats(),
                        ));
                  }),
            ],
            elevation: 0,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Color(0xFF7148b5),
                Color(0xFF8769e9),
                kPrimaryColor
              ])),
            ),
          ),
          body: LayoutBuilder(
            builder: (context, constraints) => ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color(0xFF7148b5),
                  Color(0xFF8769e9),
                  kPrimaryColor
                ])),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    children: <Widget>[
                      SearchWidget(
                        hintText: 'Search',
                        clearicon: clearicon,
                        onChanged: searchuser,
                        text: type,
                      ),
                      (state is Loading)
                          ? CircularProgressIndicator(
                              color: kSecondaryColor,
                            )
                          : ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index) => DoctorProfile(
                                  index: index, context: context, cubit: bloc),
                              itemCount: userdata.length
                              // user.type == 'user'
                              //     ? bloc.alldoctors.length
                              //     : bloc.users.length,
                              ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      listener: (context, states) {},
    );
  }

  @override
  void dispose() {
    debouncer?.cancel();
    super.dispose();
  }

  void debounce(
    VoidCallback callback, {
    Duration duration = const Duration(milliseconds: 1000),
  }) {
    if (debouncer != null) {
      debouncer.cancel();
    }

    debouncer = Timer(duration, callback);
  }

  Future searchuser(String query) async {
    setState(() {
      query.toString().isEmpty ? clearicon = false : clearicon = true;
    });
    await bloc.getusers(id: userid, query: query);
    setState(() {
      userdata = [];
      user.type == 'user' ? userdata = bloc.alldoctors : userdata = bloc.users;
      type = query;
    });
  }
}
