import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/HomeScreen/home_screen.dart';
import 'package:flutter_auth/Screens/Setting/settings.dart';
import 'package:flutter_auth/Shared/components/screenutil.dart';
import 'package:flutter_auth/Shared/globalvariables/global.dart';
import 'package:flutter_auth/Shared/constants.dart';
import 'package:flutter_auth/ViewModels/HomeViewModel/cubit.dart';
import 'package:flutter_auth/ViewModels/HomeViewModel/states.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final cubit = HomeCubit.get(context);
    return BlocConsumer<HomeCubit, HomeStates>(
      builder: (context, state) {
        Util(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              "Edit Profile",
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(50),
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w500),
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            elevation: 0,
            leading: IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: kPrimaryColor,
                size: ScreenUtil().setSp(60),
              ),
              onPressed: () {
                cubit.clearEditProfile();
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              },
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.settings,
                  color: kPrimaryColor,
                  size: ScreenUtil().setSp(60),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => SettingsPage()));
                },
              ),
            ],
          ),
          body: Container(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(16),
                top: ScreenUtil().setHeight(25),
                right: ScreenUtil().setWidth(16)),
            child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).unfocus();
                },
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        children: [
                          SizedBox(
                            height: ScreenUtil().setHeight(15),
                          ),
                          Center(
                            child: Stack(
                              children: [
                                Container(
                                  width: ScreenUtil().setWidth(350),
                                  height: ScreenUtil().setHeight(350),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          width: ScreenUtil().setWidth(4),
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor),
                                      boxShadow: [
                                        BoxShadow(
                                            spreadRadius: ScreenUtil().setSp(2),
                                            blurRadius: ScreenUtil().setSp(10),
                                            color:
                                                Colors.black.withOpacity(0.1),
                                            offset: Offset(0, 10))
                                      ],
                                      shape: BoxShape.circle,
                                      image: DecorationImage(
                                        fit: BoxFit.fitHeight,
                                        image: cubit.imageFile != null
                                            ? FileImage(cubit.imageFile)
                                            : NetworkImage(
                                                '${user.imagePath != null ? user.imagePath : cubit.placehoderimage}'),
                                      )),
                                ),
                                Positioned(
                                    bottom: ScreenUtil().setHeight(5),
                                    right: ScreenUtil().setWidth(55),
                                    child: Container(
                                      height: ScreenUtil().setHeight(120),
                                      width: ScreenUtil().setWidth(120),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: ScreenUtil().setWidth(5),
                                          color: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                        ),
                                        color: kPrimaryColor,
                                      ),
                                      child: IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.white,
                                          size: ScreenUtil().setSp(60),
                                        ),
                                        onPressed: () {
                                          showModalBottomSheet(
                                            context: context,
                                            builder: ((builder) =>
                                                cubit.bottomSheet(
                                                    context, ScreenUtil())),
                                          );
                                        },
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(40),
                          ),
                          TextFormField(
                            controller: cubit.editname,
                            minLines: 1,
                            decoration: InputDecoration(
                              label: Text(
                                '${user.name}',
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(40),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(40),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(40),
                          ),
                          TextFormField(
                            controller: cubit.editphone,
                            minLines: 1,
                            decoration: InputDecoration(
                              label: Text(
                                '${user.phone}',
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(40),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(40),
                          ),
                          TextFormField(
                            controller: cubit.editabout,
                            maxLines: 2,
                            decoration: InputDecoration(
                              label: user.about == null
                                  ? Text('About')
                                  : Text(
                                      '${user.about}',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 3,
                                      style: TextStyle(
                                        fontSize: ScreenUtil().setSp(40),
                                      ),
                                    ),
                            ),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(40),
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(40),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // ignore: deprecated_member_use
                        OutlineButton(
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setHeight(90)),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          onPressed: () {
                            cubit.clearEditProfile();
                          },
                          child: Text("CANCEL",
                              style: TextStyle(
                                  fontSize: ScreenUtil().setSp(50),
                                  letterSpacing: ScreenUtil().setSp(2.9),
                                  color: Colors.black)),
                        ),
                        // ignore: deprecated_member_use
                        RaisedButton(
                          onPressed: () async {
                            String image;
                            print(cubit.imageFile);
                            if (cubit.imageFile != null) {
                              image = await cubit.uploadphoto(
                                  imageFile: cubit.imageFile);
                              //  print(image);
                            }
                            UserModel data = UserModel(
                                name: cubit.editname.text,
                                about: cubit.editabout.text,
                                phone: cubit.editphone.text,
                                imagePath: image);
                            // print('edittt');
                            // print('name is ${data.name.isEmpty}');
                            // print('phone is ${data.phone.isEmpty}');
                            // print('about is ${data.about.isEmpty}');
                            await cubit.updateUser(userModel: data);
                            cubit.clearEditProfile();
                          },
                          color: kPrimaryColor,
                          padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setHeight(90)),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            "SAVE",
                            style: TextStyle(
                                fontSize: ScreenUtil().setSp(50),
                                letterSpacing: ScreenUtil().setSp(2.9),
                                color: Colors.white),
                          ),
                        )
                      ],
                    )
                  ],
                )),
          ),
        );
      },
      listener: (context, state) {},
    );
  }

  Widget buildTextField(String labelText, bool isPasswordTextField) {
    return Padding(
      padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(35)),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(bottom: ScreenUtil().setHeight(3)),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
        ),
      ),
    );
  }
}
