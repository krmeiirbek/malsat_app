import 'package:flutter/material.dart';

class AuthSignInOrSignUpButton extends StatelessWidget {
  final String text;
  final VoidCallback press;

  const AuthSignInOrSignUpButton({
    Key key,
    @required this.text,
    @required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: press,
      padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
      shape: new RoundedRectangleBorder(
        borderRadius: new BorderRadius.circular(7.0),
      ),
      color: Color(0xFF00BF97),
      child: Text(
        text,
        style: TextStyle(
            color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}
