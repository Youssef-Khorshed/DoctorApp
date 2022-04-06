import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_auth/Screens/HomeScreen/home_screen.dart';
import 'package:flutter_auth/Screens/LoginScreen/login_screen.dart';
import 'package:flutter_auth/Shared/Blocobserver/observer.dart';
import 'package:flutter_auth/Shared/globalvariables/global.dart';
import 'package:flutter_auth/Shared/SharedPreferences/pref.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Data {
  static void data() async {
    await Firebase.initializeApp();
    await Preference.intial();
    Bloc.observer = MyBlocObserver();
    userid = await Preference.get(key: 'id');
    print('user id................................');
    print(userid);
    //   FirebaseMessaging messaging = FirebaseMessaging.instance;
    //   String token = await messaging.getToken();
    // print('token is $token');
    if (userid == null || userid == 'null') {
      nextwidget = LoginScreen();
    } else {
      nextwidget = HomeScreen();
    }
  }
}
