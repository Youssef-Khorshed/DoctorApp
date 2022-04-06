import 'package:flutter/material.dart';
import 'package:flutter_auth/Shared/components/screenutil.dart';
import 'package:flutter_auth/Shared/constants.dart';

class RoundedPasswordField extends StatelessWidget {
  final void Function(String) onSaved;
  final Function suffixPress;
  final String hint;
  final IconData suffix;
  final bool isPassword;
  final Function function;
  final TextEditingController controller;
  final double font;
  final double padding;
  final double iconsize;
  final TextInputType type;
  const RoundedPasswordField({
    Key key,
    this.hint,
    this.font,
    this.padding,
    this.iconsize,
    this.suffix,
    this.suffixPress,
    this.isPassword,
    this.type,
    this.function,
    this.controller,
    this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Util(context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        validator: function,
        controller: controller,
        keyboardType: type,
        style: TextStyle(fontSize: font),
        obscureText: isPassword,
        onChanged: onSaved,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(fontSize: font),
          prefixIcon: Padding(
            padding: EdgeInsets.symmetric(horizontal: padding - 5),
            child: Icon(
              Icons.lock,
              size: iconsize,
              color: kPrimaryColor,
            ),
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.only(right: padding),
            child: IconButton(
              onPressed: suffixPress,
              icon: Icon(
                suffix,
                size: iconsize,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
