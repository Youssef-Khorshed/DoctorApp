import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Shared/globalvariables/global.dart';
import 'package:flutter_auth/ViewModels/HomeViewModel/cubit.dart';
import 'package:flutter_auth/ViewModels/SignUpViewModel/cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Shared/constants.dart';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => HomeCubit()),
        BlocProvider(create: (_) => RegisterCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        useInheritedMediaQuery: true,
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        //title: 'KWM APP',
        theme: ThemeData(
            primaryColor: kPrimaryColor,
            scaffoldBackgroundColor: Colors.white,
            inputDecorationTheme: InputDecorationTheme(
              filled: true,
              fillColor: kPrimaryLightColor,
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(50)),
            )),
        // home: SettingsUI(),
        home: nextwidget,
      ),
    );
  }
}
