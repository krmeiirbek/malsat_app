import 'package:flutter/material.dart';

class AuthSwitchButton extends StatelessWidget {
  final VoidCallback press;
  final String text;
  final bool isSelected;

  const AuthSwitchButton({
    Key key,
    @required this.press,
    @required this.text,
    @required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      padding: EdgeInsets.only(top: 0, bottom: 10),
      onPressed: press,
      child: Text(
        text,
        style: TextStyle(
            color: Color(0xFF616E77),
            fontSize: 14,
            fontWeight: FontWeight.w500),
      ),
      shape: Border(
          bottom: BorderSide(
              color: (isSelected)
                  ? Color(0xFF535353)
                  : Color.fromRGBO(0, 0, 0, 0.5),
              width: (isSelected) ? 3 : 0.5)),
    );
  }
}
