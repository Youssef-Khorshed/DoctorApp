import 'package:flutter/material.dart';
class SearchBox extends StatelessWidget {
  const SearchBox({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0)),
      child: TextField(
        enabled: false,
        decoration: InputDecoration(
          fillColor:Colors.white.withOpacity(.3) ,
           prefixIcon: Icon(Icons.search, color: Colors.white,),
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.white)
        ),),
    );
  }
}
