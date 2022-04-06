import 'package:flutter/material.dart';
import 'package:flutter_auth/Shared/constants.dart';

class Receive_Message extends StatelessWidget {
  final String message;
  const Receive_Message({Key key, this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: kPrimaryColor,
          ),
          height: 50,
          child: Padding(
            padding:
                const EdgeInsets.only(bottom: 10, right: 18, left: 18, top: 10),
            child: Text(
              '$message',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
