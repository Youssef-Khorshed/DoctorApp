import 'package:flutter/material.dart';

class Send_Message extends StatelessWidget {
   final String  message;
  const Send_Message({Key key,this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            color: Colors.deepPurple[100],
          ),
          height: 50,
          child: Padding(
            padding: const EdgeInsets.only(bottom: 10,right: 18,left: 18,top: 10),
            child: Text('$message',style: TextStyle(fontSize: 17,),
            ),
          ),
        ),
      ),
    );
  }
}
