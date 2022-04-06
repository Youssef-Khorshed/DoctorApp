import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/HomeScreen/home_screen.dart';
import 'package:flutter_auth/Screens/LoginSCreen/components/background.dart';
import 'package:flutter_auth/Screens/LoginScreen/components/already_have_an_account_acheck.dart';
import 'package:flutter_auth/Screens/Signup/signup_screen.dart';
import 'package:flutter_auth/Shared/components/navigation.dart';
import 'package:flutter_auth/Shared/components/rounded_button.dart';
import 'package:flutter_auth/Shared/components/rounded_input_field.dart';
import 'package:flutter_auth/Shared/components/rounded_password_field.dart';
import 'package:flutter_auth/Shared/components/screenutil.dart';
import 'package:flutter_auth/Shared/constants.dart';
import 'package:flutter_auth/ViewModels/HomeViewModel/cubit.dart';
import 'package:flutter_auth/ViewModels/HomeViewModel/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

class Body extends StatefulWidget {
  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  GlobalKey<FormState> loginkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    HomeCubit cubit = HomeCubit.get(context);

    return BlocConsumer<HomeCubit, HomeStates>(
        builder: (context, state) {
          Util(context);
          return Background(
              child: SingleChildScrollView(
            child: Form(
              key: loginkey,
              child: Padding(
                padding: EdgeInsets.all(ScreenUtil().setWidth(1)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "LOGIN",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: ScreenUtil().setSp(60)),
                    ),
                    SizedBox(
                        height: ScreenUtil().setHeight(size.height * 0.02)),
                    SvgPicture.asset(
                      "assets/icons/login.svg",
                      height: size.height * 0.3,
                    ),
                    SizedBox(
                        height: ScreenUtil().setHeight(size.height * 0.05)),
                    RoundedInputField(
                      padding:
                          size.height >= 800 && size.width >= 800 ? 55 : 10,
                      font: ScreenUtil().setSp(60),
                      iconsize: ScreenUtil().radius(90),
                      controller: cubit.emailController,
                      icon: Icons.person,
                      type: TextInputType.emailAddress,
                      function: cubit.validatoremail,
                      hintText: "Your Email",
                      onSaved: (value) {
                        cubit.emailController.text = value;
                      },
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    RoundedPasswordField(
                      font: ScreenUtil().setSp(60),
                      iconsize: ScreenUtil().radius(70),
                      padding:
                          size.height >= 800 && size.width >= 800 ? 55 : 10,
                      controller: cubit.passwordController,
                      hint: "password",
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
                      height: ScreenUtil().setHeight(15),
                    ),
                    RoundedButton(
                      font: ScreenUtil().setSp(60),
                      text: state is Loading ? 'please Wait....' : "LOGIN",
                      press: state is Loading
                          ? null
                          : () async {
                              if (loginkey.currentState.validate() != null) {
                                await cubit.signIn(
                                  email: cubit.emailController.text,
                                  password: cubit.passwordController.text,
                                  context: context,
                                );

                                cubit.emailController.clear();
                                cubit.passwordController.clear();
                              }
                            },
                    ),
                    SizedBox(height: size.height * 0.01),
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
                            style: TextStyle(fontSize: ScreenUtil().setSp(50)),
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
                            await cubit.facebookSignin(context: context);
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
                            await cubit.googleSignin(context: context);
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
                      font: ScreenUtil().setSp(50),
                      press: () {
                        navigation(context: context, widget: SignUpScreen());
                      },
                    ),
                  ],
                ),
              ),
            ),
          ));
        },
        listener: (context, state) {});
  }
}
