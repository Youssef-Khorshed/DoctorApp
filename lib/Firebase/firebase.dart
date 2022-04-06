// ignore_for_file: missing_return

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_auth/Shared/globalvariables/global.dart';
import 'package:flutter_auth/models/user.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../models/message.dart';

class FirebaseData {
  FirebaseFirestore fs = FirebaseFirestore.instance;
  FirebaseAuth _auth = FirebaseAuth.instance;
  Future<QuerySnapshot<Map<String, dynamic>>> getAllUsers() async {
    return await fs.collection("users").get();

    // FirebaseFirestore -> collection ('name') -> get()  -> value (QuerySnapshot) -> docs  List<QueryDocumentSnapshot> -> foreach  ;
    // FirebaseFirestore -> collection('name') -> doc ('id') -> get() -> QueryDocumentSnapshot value;
  }

  Future<UserModel> getUser({String uid}) async {
    final user = await fs.collection("users").doc('$uid').get();
    UserModel userdata = UserModel.fromJson(user.data());
    return userdata;
  }

  Future<String> signin({String email, String password}) async {
    UserCredential user = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    return user.user.uid ?? "null";
  }

  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      UserCredential user = await _auth.signInWithCredential(credential);
      return user;
    } catch (error) {
      print(error.toString());
    }
  }

  Future<UserCredential> signInWithFacebook() async {
    try {
      final LoginResult loginResult = await FacebookAuth.instance.login();
      final OAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(loginResult.accessToken.token);
      UserCredential userCredential =
          await _auth.signInWithCredential(facebookAuthCredential);
      return userCredential;
      //   return userCredential.user.uid ?? "null";
    } catch (error) {
      print(error.toString());
    }
  }

  Future<void> adduser(UserModel userInfo) async {
    await fs.collection('users').doc(userInfo.uId).set(userInfo.toMap());
    Fluttertoast.showToast(msg: "Account created successfully :) ");
  }

  Future<UserCredential> signUp(String email, String password) async {
    String errorMessage;
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
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
      print(error.code);
    }
  }

  Future<void> addfollow({String userids, String doctorid}) async {
    await fs
        .collection('users')
        .doc(userids)
        .collection('follow')
        .doc(doctorid)
        .set({'doctorid': 'doctorid'});
    await fs
        .collection('users')
        .doc(doctorid)
        .collection('followed')
        .doc(userids)
        .set({'doctorid': 'doctorid'});
  }

  Future<void> removefollow({String doctorid}) async {
    await fs
        .collection('users')
        .doc(userid)
        .collection('follow')
        .doc(doctorid)
        .delete();
    await fs
        .collection('users')
        .doc(doctorid)
        .collection('followed')
        .doc(userid)
        .delete();
  }

  Future<void> addmessage(
      {String sender, String reciever, MessageModel message}) async {
    // sender category
    await FirebaseFirestore.instance
        .collection('users')
        .doc(sender)
        .collection('chats')
        .doc(reciever)
        .collection('messages')
        .add(message.toJson())
        .then((value) => null);
    // reciever category
    await FirebaseFirestore.instance
        .collection('users')
        .doc(reciever)
        .collection('chats')
        .doc(sender)
        .collection('messages')
        .add(message.toJson())
        .then((value) => null);
  }

  Future<void> updateuser({UserModel usermodel}) async {
    usermodel != null
        ? await fs.collection('users').doc(user.uId).update({
            'name': usermodel.name.isEmpty ? user.name : usermodel.name,
            'email': user.email,
            'phone': usermodel.phone.isEmpty ? user.phone : usermodel.phone,
            'uId': user.uId,
            'about': usermodel.about.isEmpty ? user.about : usermodel.about,
            'type': usermodel.type ?? user.type,
            'imagePath': usermodel.imagePath != null
                ? usermodel.imagePath
                : user.imagePath
          })
        : print('no data updated');
  }

  Future<String> upload_on_firebase({File file}) async {
    final destination = 'files/${file.path}';
    final ref = FirebaseStorage.instance.ref(destination).putFile(file);
    if (ref != null) {
      final snapshot = await ref.whenComplete(() => null);
      final link = await snapshot.ref.getDownloadURL();
      return link;
    }
  }
}
