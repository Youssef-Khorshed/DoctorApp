import 'package:flutter/material.dart';
import 'package:flutter_auth/Shared/constants.dart';

class RoundedInputField extends StatelessWidget {
  final Function function;
  final TextEditingController controller;
  final String hintText;
  final TextInputType type;
  final IconData icon;
  final double font;
  final double padding;
  final double iconsize;
  final void Function(String) onSaved;
  const RoundedInputField({
    Key key,
    this.type,
    this.padding,
    this.font,
    this.iconsize,
    this.function,
    this.controller,
    this.hintText,
    this.icon,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 20,
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: type,
        style: TextStyle(fontSize: font),
        validator: function,
        onSaved: onSaved,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
            prefixIcon: Padding(
              padding: EdgeInsets.symmetric(horizontal: padding - 5),
              child: Icon(
                icon,
                size: iconsize,
                color: kPrimaryColor,
              ),
            ),
            hintText: hintText,
            hintStyle: TextStyle(fontSize: font)),
      ),
    );
  }
}
