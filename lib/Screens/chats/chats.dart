//import 'package:flutter/cupertino.dart';
// ignore_for_file: missing_required_param, unused_local_variable, missing_return
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/HomeScreen/home_screen.dart';
import 'package:flutter_auth/Screens/chats/components_chat.dart';
import 'package:flutter_auth/Shared/components/screenutil.dart';
import 'package:flutter_auth/Shared/globalvariables/global.dart';
import 'package:flutter_auth/Shared/constants.dart';
import 'package:flutter_auth/ViewModels/HomeViewModel/cubit.dart';
import 'package:flutter_auth/ViewModels/HomeViewModel/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Chats extends StatelessWidget {
  const Chats({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Util(context);
    final bloc = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeStates>(
      builder: (context, state) {
        return Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomeScreen()));
                  },
                  icon: Icon(Icons.arrow_back),
                  color: kPrimaryColor,
                  iconSize: ScreenUtil().radius(50)),
              backgroundColor: Color(0xFFFAFAFA),
              title: Text(
                "Chats",
                style: TextStyle(
                    fontSize: ScreenUtil().setSp(70), color: kPrimaryColor),
              ),
            ),
            body: LayoutBuilder(
              builder: (context, constraints) => ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Container(
                  decoration: BoxDecoration(color: Color(0xFFFAFAFA)),
                  child: SingleChildScrollView(
                      physics: BouncingScrollPhysics(),
                      child: ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) => Chat(
                                context: context,
                                bloc: bloc,
                                userModel: user.type == 'user'
                                    ? bloc.alldoctors[index]
                                    : bloc.users[index],
                              ),
                          separatorBuilder: (context, index) =>
                              Line(context: context),
                          itemCount: user.type == 'user'
                              ? bloc.alldoctors.length
                              : bloc.users.length)),
                ),
              ),
            ));
      },
      listenWhen: (context, state) {},
    );
  }
}
