// ignore_for_file: missing_return

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_auth/Firebase/firebase.dart';
import 'package:flutter_auth/Screens/LoginScreen/login_screen.dart';
import 'package:flutter_auth/Shared/components/navigation.dart';
import 'package:flutter_auth/Shared/constants.dart';
import 'package:flutter_auth/Shared/globalvariables/global.dart';
import 'package:flutter_auth/ViewModels/SignUpViewModel/states.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterCubit extends Cubit<RegisterState> {
  //variables
  RegisterCubit() : super(SignUpintial());
  static RegisterCubit get(BuildContext context) => BlocProvider.of(context);
  bool isPassword = true, isdoctor = false;
  String errorMessage;
  // editing Controller
  final userNameEditingController = new TextEditingController();
  final emailEditingController = new TextEditingController();
  final passwordEditingController = new TextEditingController();
  final phoneEditingController = new TextEditingController();
  FormFieldValidator<String> validatoremail = (String value) {
    if (value.isEmpty) {
      return ("Please Enter Your Email");
    }
    // reg expression for email validation
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
      return ("Please Enter a valid email");
    }
    return null;
  };
  FormFieldValidator<String> validatorpassword = (String value) {
    RegExp regex = new RegExp(r'^.{6,}$');
    if (value.isEmpty) {
      return ("Password is required for login");
    }
    if (!regex.hasMatch(value)) {
      return ("Enter Valid Password(Min. 6 Character)");
    }
  };
  FormFieldValidator<String> validatorphone = (String value) {
    if (value.isEmpty) {
      return 'please enter your phone';
    }
  };
  FormFieldValidator<String> validatorname = (String value) {
    if (value.isEmpty) {
      RegExp regex = new RegExp(r'^.{3,}$');
      if (value.isEmpty) {
        return ("First Name cannot be Empty");
      }
      if (!regex.hasMatch(value)) {
        return ("Enter Valid name(Min. 3 Character)");
      }
      return null;
    }
  };

//methods
  void changepassword() {
    isPassword = !isPassword;
    emit(ChangeCheckPassword());
  }

  void changedoctorstate() {
    isdoctor = !isdoctor;
    emit(ChangeCheckDoctor());
  }

  Future<void> signUp(String email, String password, bool isdoctor) async {
    try {
      emit(Loading());
      UserCredential userCredential =
          await FirebaseData().signUp(email, password);
      emit(SuccessSignUp());
      await postDetailsToFirestore(
          user: userCredential.user, isdoctor: isdoctor);
    } catch (error) {
      print(error);
      emit(FaildSignUp());
    }
  }

  Future<void> postDetailsToFirestore({User user, bool isdoctor}) async {
    try {
      emit(Loading());
      UserModel userModel = UserModel();
      // writing all the values
      userModel.email = user.email;
      userModel.uId = user.uid;
      userModel.phone = phoneEditingController.text;
      userModel.name = userNameEditingController.text;
      userModel.type = isdoctor ? 'doctor' : 'user';
      userModel.imagePath = isdoctor ? doctorphoto : patinetimage;
      userModel.about =
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';
      await FirebaseData().adduser(userModel);
      Fluttertoast.showToast(msg: "Account created successfully :) ");
      phoneEditingController.clear();
      userNameEditingController.clear();
      passwordEditingController.clear();
      emit(AddUserSuccess());
    } catch (error) {
      emit(FaildAddUser());
    }
  }

  Future<void> googleSignUp({BuildContext context}) async {
    try {
      UserCredential value = await FirebaseData().signInWithGoogle();

      if (value != null) {
        userid = value.user.uid;
        await FirebaseData().adduser(UserModel(
            email: value.user.email,
            name: value.user.displayName,
            imagePath: value.user.photoURL,
            about: '',
            phone: value.user.phoneNumber,
            type: isdoctor ? 'doctor' : 'user',
            uId: value.user.uid));
        emit(SuccessSignUp());
        Fluttertoast.showToast(msg: "Account created successfully :) ");

        navigation(context: context, widget: LoginScreen());
      }
    } catch (error) {
      print(error);
      emit(FaildSignUp());
    }
  }

  Future<void> facebookSignUp({BuildContext context}) async {
    try {
      UserCredential value = await FirebaseData().signInWithFacebook();

      if (value != null) {
        userid = value.user.uid;
        await FirebaseData().adduser(UserModel(
            email: value.user.email,
            name: value.user.displayName,
            imagePath: value.user.photoURL,
            about: '',
            phone: value.user.phoneNumber,
            type: isdoctor ? 'doctor' : 'user',
            uId: value.user.uid));
        emit(SuccessSignUp());
        Fluttertoast.showToast(msg: "Account created successfully :) ");

        navigation(context: context, widget: LoginScreen());
      }
    } catch (error) {
      print(error);
      emit(FaildSignUp());
    }
  }
}
