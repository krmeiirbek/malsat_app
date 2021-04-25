import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'home/home_page.dart';


enum WidgetMarker { login, signUp }

class AuthSwitch extends StatefulWidget {
  @override
  _AuthSwitchState createState() => _AuthSwitchState();
}

class _AuthSwitchState extends State<AuthSwitch>
    with SingleTickerProviderStateMixin<AuthSwitch> {
  WidgetMarker selectedWidgetMarker = WidgetMarker.login;

  AnimationController _controller;
  Animation _animation;

  TextEditingController _loginEmailController = TextEditingController();
  TextEditingController _registerEmailController = TextEditingController();
  TextEditingController _loginPasswordController = TextEditingController();
  TextEditingController _registerPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(35),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 173,
            ),
            Padding(
              padding: EdgeInsets.only(left: 10, bottom: 30),
              child: Image.asset(
                'assets/images/logo.png',
                width: 140,
                height: 23.33,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                FlatButton(
                  padding: EdgeInsets.fromLTRB(50, 0, 60, 10),
                  focusColor: Colors.transparent,
                  color: Colors.transparent,
                  disabledColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    setState(() {
                      selectedWidgetMarker = WidgetMarker.login;
                    });
                  },
                  child: Text(
                    "Войти",
                    style: TextStyle(
                        color: Color(0xFF616E77),
                        fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  shape: Border(
                      bottom: BorderSide(
                          color: (selectedWidgetMarker == WidgetMarker.login)
                              ? Color(0xFF535353)
                              : Color.fromRGBO(0, 0, 0, 0.5),
                          width: (selectedWidgetMarker == WidgetMarker.login)
                              ? 3
                              : 0.5)),
                ),
                FlatButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  focusColor: Colors.transparent,
                  color: Colors.transparent,
                  disabledColor: Colors.transparent,
                  padding: EdgeInsets.fromLTRB(30, 0, 45, 10),
                  onPressed: () {
                    setState(() {
                      selectedWidgetMarker = WidgetMarker.signUp;
                    });
                  },
                  child: Text(
                    "Регистрация",
                    style: TextStyle(
                        color: Color(0xFF616E77),
                        // fontSize: 14,
                        fontWeight: FontWeight.w500),
                  ),
                  shape: Border(
                      bottom: BorderSide(
                          color: (selectedWidgetMarker == WidgetMarker.signUp)
                              ? Color(0xFF535353)
                              : Color.fromRGBO(0, 0, 0, 0.5),
                          width: (selectedWidgetMarker == WidgetMarker.signUp)
                              ? 3
                              : 0.5)),
                ),
              ],
            ),
            FutureBuilder(
                future: _playAnimation(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  return getCustomContainer();
                }),
          ],
        ),
      ),
    );
  }

  _playAnimation() {
    _controller.reset();
    _controller.forward();
  }

  Widget getCustomContainer() {
    switch (selectedWidgetMarker) {
      case WidgetMarker.login:
        _registerEmailController.clear();
        _registerPasswordController.clear();
        return getSignInContainer();
      case WidgetMarker.signUp:
        _loginEmailController.clear();
        _loginPasswordController.clear();
        return getSignUpContainer();
    }
    return getSignInContainer();
  }

  Widget getSignInContainer() {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            TextField(
              style: new TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14.0,
                fontStyle: FontStyle.normal,
              ),
              controller: _loginEmailController,
              decoration: InputDecoration(
                hintText: "Введите ваш email",
                hintStyle: TextStyle(
                    color: Color.fromRGBO(74, 86, 74, 0.4), fontSize: 14.0),
                fillColor: Color(0xFFF2F1F1),
                filled: true,
                focusColor: Color(0xFF000000),
                focusedBorder: InputBorder.none,
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              style: new TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14.0,
                fontStyle: FontStyle.normal,
              ),
              controller: _loginPasswordController,
              decoration: InputDecoration(
                hintText: "Введите ваш пароль",
                hintStyle: TextStyle(
                    color: Color.fromRGBO(74, 86, 74, 0.4), fontSize: 14.0),
                fillColor: Color(0xFFF2F1F1),
                filled: true,
                focusColor: Color(0xFF000000),
                focusedBorder: InputBorder.none,
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
                width: double.infinity,
                child: RaisedButton(
                  padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePage()),
                    );
                    // Navigator.of(context).pushReplacement(new MaterialPageRoute(
                    //     builder: (BuildContext context) => MyHomePage()));
                  },
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(7.0),
                  ),
                  color: Color(0xFF00BF97),
                  child: Text(
                    'Вход',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600),
                  ),
                ))
          ],
        ),
      ),
    );
  }

  Widget getSignUpContainer() {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 20,
            ),
            TextField(
              style: new TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14.0,
                fontStyle: FontStyle.normal,
              ),
              controller: _registerEmailController,
              decoration: InputDecoration(
                hintText: "Введите ваш email",
                hintStyle: TextStyle(
                    color: Color.fromRGBO(74, 86, 74, 0.4), fontSize: 14.0),
                fillColor: Color(0xFFF2F1F1),
                filled: true,
                focusColor: Color(0xFF000000),
                focusedBorder: InputBorder.none,
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              style: new TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 14.0,
                fontStyle: FontStyle.normal,
              ),
              controller: _registerPasswordController,
              decoration: InputDecoration(
                hintText: "Введите ваш пароль",
                hintStyle: TextStyle(
                    color: Color.fromRGBO(74, 86, 74, 0.4), fontSize: 14.0),
                fillColor: Color(0xFFF2F1F1),
                filled: true,
                focusColor: Color(0xFF000000),
                focusedBorder: InputBorder.none,
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(10.0),
                  ),
                  borderSide: BorderSide(
                    width: 0,
                    style: BorderStyle.none,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              width: double.infinity,
              child: RaisedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage()));
                  // Navigator
                  //     .of(context)
                  //     .pushReplacement(new MaterialPageRoute(builder: (BuildContext context) => MyHomePage()));
                },
                padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(7.0),
                ),
                color: Color(0xFF00BF97),
                child: Text(
                  'Зарегистрироваться',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
