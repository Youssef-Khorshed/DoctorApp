// ignore_for_file: missing_return, sdk_version_constructor_tearoffs

import 'dart:async';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/HomeScreen/home_screen.dart';
import 'package:flutter_auth/Shared/SharedPreferences/pref.dart';
import 'package:flutter_auth/Shared/components/navigation.dart';
import 'package:flutter_auth/Shared/globalvariables/global.dart';
import 'package:flutter_auth/ViewModels/HomeViewModel/states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

import '../../../Firebase/firebase.dart';
import '../../../models/message.dart';
import '../../../models/user.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(Homeintial());
  String placehoderimage =
      'https://imgs.search.brave.com/SZ4auzS3PX0Ny2mzeWOfWcHoYDF-b7AOpqhocaWhocY/rs:fit:417:626:1/g:ce/aHR0cHM6Ly9pbWFn/ZS5mcmVlcGlrLmNv/bS9mcmVlLXBob3Rv/L3BvcnRyYWl0LXNt/aWxpbmctZG9jdG9y/LXN0YW5kaW5nLXdp/dGgtYXJtcy1jcm9z/c2VkXzEwNzQyMC03/NTIxMS5qcGc';
  List<UserModel> alldoctors = [];
  List<UserModel> users = [];
  Map<String, bool> follow = {};
  Map<String, bool> followed = {};
  List<MessageModel> messages = [];
  final text = new TextEditingController();
  final editname = new TextEditingController();
  final editphone = new TextEditingController();
  final editemail = new TextEditingController();
  final editabout = new TextEditingController();
  File imageFile = null;
  static HomeCubit get(BuildContext context) => BlocProvider.of(context);

  void checkfollow({UserModel userModel}) async {
    if (user.type == 'user') {
      //  check = !check;
      if (!follow[userModel.uId]) {
        await FirebaseData()
            .addfollow(userids: user.uId, doctorid: userModel.uId);
        follow[userModel.uId] = true;
      } else {
        await FirebaseData().removefollow(doctorid: userModel.uId);
        follow[userModel.uId] = false;
      }
      // print(check);
      emit(ChangeCheck());
    }
  }

  void getusers({
    String id,
    String query = '',
  }) async {
    alldoctors.clear();
    users.clear();
    follow.clear();
    followed.clear();
    emit(Loading());
    user = await FirebaseData().getUser(uid: id ?? userid);
    QuerySnapshot<Map<String, dynamic>> valuer =
        await FirebaseData().getAllUsers();

    valuer.docs.forEach((element) {
      UserModel user = UserModel.fromJson(element.data());
      if (user.type == 'doctor') {
        alldoctors.add(user);
        follow.addAll({user.uId: false});
      } else {
        users.add(user);
        followed.addAll({user.uId.toString(): false});
      }
    });

    user.type == 'user'
        ? await FirebaseFirestore.instance
            .collection("users")
            .doc('${userid}')
            .collection('follow')
            .get()
            .then((value) => value.docs.forEach((element) {
                  for (int i = 0; i < alldoctors.length; i++) {
                    if (element.id.compareTo(alldoctors[i].uId) == 0) {
                      follow[element.id] = true;
                    }
                  }
                }))
        : await FirebaseFirestore.instance
            .collection("users")
            .doc('${userid}')
            .collection('followed')
            .get()
            .then((value) => value.docs.forEach((element) {
                  for (int i = 0; i < users.length; i++) {
                    if (element.id.compareTo(users[i].uId) == 0) {
                      followed[element.id] = true;
                    }
                  }
                }));

    user.type == 'doctor'
        ? users = users.where((user) {
            final data = query.toLowerCase();
            final userdata = user.name.toLowerCase();
            return userdata.contains(data);
          }).toList()
        : alldoctors = alldoctors.where((item) {
            final data = query.toLowerCase();
            final element = item.name.toLowerCase();
            return element.contains(data);
          }).toList();

    emit(GetUsersData());
  }

  void getmessages({
    String reciever,
  }) {
    emit(Loading());
    messages.clear();
    if (reciever.isNotEmpty) {
      final value = FirebaseFirestore.instance
          .collection('users')
          .doc(user.uId)
          .collection('chats')
          .doc(reciever)
          .collection('messages')
          .orderBy('date')
          .orderBy('time')
          .snapshots();
      if (value != null) {
        value.listen((event) {
          messages.clear();
          if (event != null) {
            event.docs.forEach((element) {
              if (element != null) {
                messages.add(MessageModel.get_data(element.data()));
              }
            });
          }
        });
      }

      Timer(Duration(seconds: 1), () {
        print(messages.length);
        emit(GetMessages());
      });
    }
  }

  void set_message(
      {String sender, String reciever, MessageModel message}) async {
    await FirebaseData()
        .addmessage(sender: sender, reciever: reciever, message: message);
    emit(AddMessage());
    getmessages(reciever: reciever);
  }

  Future<void> updateUser({UserModel userModel}) async {
    await FirebaseData().updateuser(usermodel: userModel);
    user = await FirebaseData().getUser(uid: user.uId);
    emit(UpdateUser());
  }

  Future<void> takePhoto(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(
      source: source,
    );
    pickedFile == null ? imageFile = null : imageFile = File(pickedFile.path);
    emit(PickImage());
    print(imageFile);
  }

  Future<String> uploadphoto({File imageFile}) async {
    if (imageFile != null) {
      String ref = await FirebaseData().upload_on_firebase(file: imageFile);
      emit(UploadImage());
      return ref;
    } else {
      print('no data uploaded');
    }
  }

  Widget bottomSheet(BuildContext context, ScreenUtil screenutil) {
    return Container(
      height: screenutil.setHeight(300),
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: screenutil.setWidth(30),
        vertical: screenutil.setHeight(30),
      ),
      child: Column(
        children: <Widget>[
          Text(
            "Choose Profile photo",
            style: TextStyle(
              fontSize: screenutil.setSp(50),
            ),
          ),
          SizedBox(
            height: screenutil.setHeight(40),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
            // ignore: deprecated_member_use
            FlatButton.icon(
              icon: Icon(
                Icons.camera,
                size: screenutil.setSp(60),
              ),
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              label: Text(
                "Camera",
                style: TextStyle(
                  fontSize: screenutil.setSp(40),
                ),
              ),
            ),
            // ignore: deprecated_member_use
            FlatButton.icon(
              icon: Icon(Icons.image, size: screenutil.setSp(60)),
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              label: Text(
                "Gallery",
                style: TextStyle(
                  fontSize: screenutil.setSp(40),
                ),
              ),
            ),
          ])
        ],
      ),
    );
  }

  void clearEditProfile() {
    imageFile = null;
    editname.clear();
    editphone.clear();
    editemail.clear();
    editabout.clear();
  }

  bool isPassword = true, isdoctor = false;
  final TextEditingController emailController = new TextEditingController();
  final TextEditingController passwordController = new TextEditingController();
  // ignore: missing_return
  FormFieldValidator<String> validatorpassword = (String value) {
    RegExp regex = new RegExp(r'^.{6,}$');
    if (value.isEmpty) {
      return ("Password is required for login");
    }
    if (!regex.hasMatch(value)) {
      return ("Enter Valid Password(Min. 6 Character)");
    }
  };
  FormFieldValidator<String> validatoremail = (String value) {
    if (value.isEmpty) {
      return ("Please Enter Your Email");
    }
    if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value)) {
      return ("Please Enter a valid email");
    }
    return null;
  };

  //methods
  Future<void> signIn({
    String email,
    String password,
    BuildContext context,
  }) async {
    String errorMessage;

    try {
      emit(Loading());
      String uid =
          await FirebaseData().signin(email: email, password: password);
      userid = uid;
      Preference.put(key: 'id', value: uid);
      emit(SuccessLogin());
      navigation(context: context, widget: HomeScreen());
    } on FirebaseAuthException catch (error) {
      switch (error.code) {
        case "invalid-email":
          errorMessage = "Your email address appears to be malformed.";

          break;
        case "wrong-password":
          errorMessage = "Your password is wrong.";
          break;
        case "user-not-found":
          errorMessage = "User with this email doesn't exist.";
          break;
        case "user-disabled":
          errorMessage = "User with this email has been disabled.";
          break;
        case "too-many-requests":
          errorMessage = "Too many requests";
          break;
        case "operation-not-allowed":
          errorMessage = "Signing in with Email and Password is not enabled.";
          break;
        default:
          errorMessage = "An undefined Error happened.";
      }
      Fluttertoast.showToast(msg: errorMessage);
      emit(FaildLogin());
      print(error.code);
      return null;
    }
  }

  void changepassword() {
    isPassword = !isPassword;
    emit(ChangeCheckPassword());
  }

  Future<void> facebookSignin({BuildContext context}) async {
    UserCredential value = await FirebaseData().signInWithFacebook();
    if (value != null) {
      userid = value.user.uid;
      final getuser = await FirebaseFirestore.instance
          .collection('users')
          .where('uId', isEqualTo: '${userid}')
          .limit(1)
          .get();
      if (getuser.docs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('User not Registered'),
          duration: Duration(seconds: 1),
        ));
        emit(FaildLogin());
      } else {
        Preference.put(key: 'id', value: userid);
        emit(SuccessLogin());
        navigation(context: context, widget: HomeScreen());
      }
    } else {
      emit(FaildLogin());
    }
  }

  Future<void> googleSignin({BuildContext context}) async {
    UserCredential value = await FirebaseData().signInWithGoogle();
    if (value != null) {
      userid = value.user.uid;
      final getuser = await FirebaseFirestore.instance
          .collection('users')
          .where('uId', isEqualTo: '${userid}')
          .limit(1)
          .get();
      if (getuser.docs.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('User not Registered'),
          duration: Duration(seconds: 1),
        ));
        emit(FaildLogin());
      } else {
        Preference.put(key: 'id', value: userid);
        emit(SuccessLogin());
        navigation(context: context, widget: HomeScreen());
      }
    } else {
      emit(FaildLogin());
    }
  }
}
