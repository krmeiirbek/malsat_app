import 'package:flutter/material.dart';

class Button1 extends StatelessWidget {
  final String text;
  final VoidCallback press;

  const Button1({
    Key key,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: press,
      child: Text(
        text,
        style: TextStyle(
          color: Color(0xFF4A564A).withOpacity(0.4),
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
      color: Color(0xFFF2F1F1),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
        side: BorderSide(
          color: Color(0xFFF2F1F1),
        ),
      ),
    );
  }
}
