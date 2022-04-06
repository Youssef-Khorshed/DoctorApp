import 'package:flutter/material.dart';
import '../../../Shared/constants.dart';

class RadioButton extends StatefulWidget {
  const RadioButton({Key key}) : super(key: key);

  @override
  State<RadioButton> createState() => _RadioButtonState();
}

class _RadioButtonState extends State<RadioButton> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50.0),
      child: Row(
        children: [
          Text(
            "SIGNUP AS",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          GestureDetector(
            //onTap: UserRegisterCubit.get(context).changeUserRole,
            child: Row(
              children: [
                Radio(
                  value: 'doctor',
                  groupValue: 2,
                  //groupValue: UserRegisterCubit.get(context).currentUser,
                  activeColor: kPrimaryColor,
                  onChanged: (_) {
                    // UserRegisterCubit.get(context).changeUserRole();
                  },
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text('Doctor'),
              ],
            ),
          ),
          SizedBox(
            width: 10.0,
          ),
          GestureDetector(
            // onTap: UserRegisterCubit.get(context).changeUserRole,
            child: Row(
              children: [
                Radio(
                  value: 'patient',
                  groupValue: 1,
                  //  groupValue: UserRegisterCubit.get(context).currentUser,
                  activeColor: kPrimaryColor,
                  onChanged: (_) {
                    //  UserRegisterCubit.get(context).changeUserRole();
                  },
                ),
                SizedBox(
                  width: 5.0,
                ),
                Text('Patient'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
