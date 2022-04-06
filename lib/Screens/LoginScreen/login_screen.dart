import 'package:flutter/material.dart';
import 'package:flutter_auth/Screens/LoginScreen/components/body.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Body()),
    );
  }
}
