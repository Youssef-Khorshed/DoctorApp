import 'package:flutter/material.dart';
import 'package:flutter_auth/Shared/components/screenutil.dart';
import 'package:flutter_auth/Shared/constants.dart';

class SearchWidget extends StatefulWidget {
  final String text;
  final ValueChanged<String> onChanged;
  final String hintText;
  final clearicon;
  const SearchWidget({
    Key key,
    @required this.text,
    @required this.onChanged,
    @required this.hintText,
    @required this.clearicon,
  }) : super(key: key);

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final controller = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Util(context);

    final styleActive = TextStyle(color: Colors.black);
    final styleHint = TextStyle(color: Colors.black54);
    final style = widget.text.isEmpty ? styleHint : styleActive;

    return Container(
      height: 42,
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.white,
        border: Border.all(color: Colors.black26),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: TextField(
        controller: controller,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          icon: Icon(Icons.search, color: style.color),
          suffixIcon: widget.clearicon
              ? GestureDetector(
                  child: Icon(Icons.close, color: style.color),
                  onTap: () {
                    setState(() {
                      controller.clear();
                      widget.onChanged('');
                      FocusScope.of(context).requestFocus(FocusNode());
                    });
                  },
                )
              : null,
          hintText: widget.hintText,
          hintStyle: style,
          border: InputBorder.none,
        ),
        style: style,
        onChanged: widget.onChanged,
      ),
    );
  }
}
