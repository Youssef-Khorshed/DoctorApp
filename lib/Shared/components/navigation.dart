import 'package:flutter/material.dart';

void navigation({BuildContext context, Widget widget}) {
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => widget));
}
