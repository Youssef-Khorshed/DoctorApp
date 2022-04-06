// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/LoginScreen/login_screen.dart';
import 'package:flutter_auth/Screens/Signup/components/background.dart';
import 'package:flutter_auth/Screens/LoginScreen/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/Shared/components/navigation.dart';
import 'package:flutter_auth/Shared/components/rounded_button.dart';
import 'package:flutter_auth/Shared/components/rounded_input_field.dart';
import 'package:flutter_auth/Shared/components/rounded_password_field.dart';
import 'package:flutter_auth/Shared/components/screenutil.dart';
import 'package:flutter_auth/Shared/constants.dart';
import 'package:flutter_auth/ViewModels/SignUpViewModel/cubit.dart';
import 'package:flutter_auth/ViewModels/SignUpViewModel/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class SignUpBody extends StatelessWidget {
  GlobalKey<FormState> registerkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    Util(context);
    RegisterCubit cubit = RegisterCubit.get(context);
    return BlocConsumer<RegisterCubit, RegisterState>(
        builder: (context, state) {
          return Background(
            child: SingleChildScrollView(
              child: Form(
                key: registerkey,
                child: Padding(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(1)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SvgPicture.asset(
                        "assets/icons/signup.svg",
                        height: size.height * 0.2,
                      ),
                      RoundedInputField(
                        padding:
                            size.height >= 800 && size.width >= 800 ? 55 : 10,
                        font: ScreenUtil().setSp(50),
                        iconsize: ScreenUtil().radius(90),
                        controller: cubit.userNameEditingController,
                        icon: Icons.person,
                        type: TextInputType.name,
                        function: cubit.validatorname,
                        hintText: "Username",
                        onSaved: (value) {
                          cubit.userNameEditingController.text = value;
                        },
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(30),
                      ),
                      RoundedInputField(
                        controller: cubit.emailEditingController,
                        font: ScreenUtil().setSp(50),
                        iconsize: ScreenUtil().radius(90),
                        icon: Icons.email,
                        padding:
                            size.height >= 800 && size.width >= 800 ? 55 : 10,
                        type: TextInputType.emailAddress,
                        function: cubit.validatoremail,
                        hintText: "Email",
                        onSaved: (value) {
                          cubit.emailEditingController.text = value;
                        },
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(30),
                      ),
                      RoundedPasswordField(
                        font: ScreenUtil().setSp(50),
                        iconsize: ScreenUtil().radius(70),
                        padding:
                            size.height >= 800 && size.width >= 800 ? 55 : 10,
                        controller: cubit.passwordEditingController,
                        hint: "password",
                        type: TextInputType.visiblePassword,
                        suffix: cubit.isPassword
                            ? Icons.visibility
                            : Icons.visibility_off,
                        suffixPress: () {
                          cubit.changepassword();
                        },
                        isPassword: cubit.isPassword,
                        function: cubit.validatorpassword,
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(30),
                      ),
                      RoundedInputField(
                        padding:
                            size.height >= 800 && size.width >= 800 ? 55 : 10,
                        font: ScreenUtil().setSp(50),
                        iconsize: ScreenUtil().radius(90),
                        controller: cubit.phoneEditingController,
                        icon: Icons.phone,
                        type: TextInputType.phone,
                        function: cubit.validatorphone,
                        hintText: "Phone",
                        onSaved: (value) {
                          cubit.phoneEditingController.text = value;
                        },
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(15),
                      ),
                      //RadioButton(),
                      RoundedButton(
                        text: state is Loading ? 'Please Wait.....' : "SIGNUP",
                        font: ScreenUtil().setSp(50),
                        press: state is Loading
                            ? null
                            : () async {
                                if (registerkey.currentState.validate()) {
                                  await cubit.signUp(
                                      cubit.emailEditingController.text,
                                      cubit.passwordEditingController.text,
                                      cubit.isdoctor);
                                  navigation(
                                      context: context, widget: LoginScreen());
                                }
                              },
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(5),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Row(
                          children: [
                            Transform.scale(
                              scale: ScreenUtil().setSp(3),
                              child: Checkbox(
                                value: cubit.isdoctor,
                                onChanged: (value) {
                                  cubit.changedoctorstate();
                                },
                                splashRadius: ScreenUtil().setSp(50),
                                activeColor: kPrimaryColor,
                                checkColor: kBackgoundColor,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenUtil().setSp(
                                      size.height >= 800 && size.width >= 800
                                          ? 15
                                          : 5)),
                              child: Text(
                                'Is Doctor ?',
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(50),
                                    color: kPrimaryColor),
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(height: size.height * 0.01),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: size.width / 3,
                            height: ScreenUtil().setHeight(3),
                            color: Colors.grey.shade400,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'or',
                              style:
                                  TextStyle(fontSize: ScreenUtil().setSp(50)),
                            ),
                          ),
                          Container(
                            width: size.width / 3,
                            height: ScreenUtil().setHeight(3),
                            color: Colors.grey.shade400,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          GestureDetector(
                            onTap: () async {
                              await cubit.facebookSignUp(context: context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kPrimaryLightColor),
                              child: SvgPicture.asset(
                                'assets/icons/facebook.svg',
                                height: ScreenUtil().setHeight(70),
                                width: ScreenUtil().setWidth(70),
                                color: kPrimaryColor,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              await cubit.googleSignUp(context: context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: kPrimaryLightColor),
                              child: SvgPicture.asset(
                                  'assets/icons/google-plus.svg',
                                  height: ScreenUtil().setHeight(70),
                                  width: ScreenUtil().setWidth(70),
                                  color: kPrimaryColor),
                            ),
                          )
                        ],
                      ),
                      SizedBox(height: size.height * 0.03),

                      AlreadyHaveAnAccountCheck(
                        font: ScreenUtil().setSp(40),
                        login: false,
                        press: () {
                          navigation(context: context, widget: LoginScreen());
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
