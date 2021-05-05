import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malsat_app/bloc/auth_bloc/auth.dart';
import 'package:malsat_app/bloc/login_bloc/login_bloc.dart';
import 'package:malsat_app/components/auth_signin_or_signup_button.dart';
import 'package:malsat_app/components/auth_switch_button.dart';
import 'package:malsat_app/repositories/repositories.dart';

enum WidgetMarker { login, signUp }

class AuthSwitch extends StatefulWidget {
  final AuthRepository authRepository;

  const AuthSwitch({Key key, @required this.authRepository}) : super(key: key);

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
  TextEditingController _registerNameController = TextEditingController();
  TextEditingController _registerPhoneController = TextEditingController();
  TextEditingController _registerRePasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    _loginEmailController.dispose();
    _loginPasswordController.dispose();
    _registerEmailController.dispose();
    _registerPasswordController.dispose();
    _registerNameController.dispose();
    _registerPhoneController.dispose();
    _registerRePasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
          widget.authRepository, BlocProvider.of<AuthenticationBloc>(context)),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Login Failed'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Scaffold(
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(35),
              child: Column(
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
                      Expanded(
                        child: AuthSwitchButton(
                          text: 'Войти',
                          press: () {
                            setState(() {
                              selectedWidgetMarker = WidgetMarker.login;
                            });
                          },
                          isSelected:
                              selectedWidgetMarker == WidgetMarker.login,
                        ),
                      ),
                      Expanded(
                        child: AuthSwitchButton(
                          press: () {
                            setState(() {
                              selectedWidgetMarker = WidgetMarker.signUp;
                            });
                          },
                          text: 'Регистрация',
                          isSelected:
                              selectedWidgetMarker == WidgetMarker.signUp,
                        ),
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
          ),
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
        _registerNameController.clear();
        _registerPhoneController.clear();
        _registerRePasswordController.clear();
        return getSignInContainer();
      case WidgetMarker.signUp:
        _loginEmailController.clear();
        _loginPasswordController.clear();
        return getSignUpContainer();
    }
    return getSignInContainer();
  }

  Widget getSignInContainer() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return FadeTransition(
          opacity: _animation,
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
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
                  obscureText: true,
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
                  child: state is LoginLoading
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 25.0,
                                    width: 25.0,
                                    child: CupertinoActivityIndicator(),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      : AuthSignInOrSignUpButton(
                          text: 'Вход',
                          press: () {
                            BlocProvider.of<LoginBloc>(context).add(
                                LoginButtonPressed(
                                    email: _loginEmailController.text,
                                    password: _loginPasswordController.text));
                          },
                        ),
                ),
                SizedBox(
                  height: 1,
                ),
                TextButton(
                  child: Text(
                    'Забыли пароль?',
                    style: TextStyle(
                      color: Color(0xFF616E77),
                    ),
                  ),
                  onPressed: () {},
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget getSignUpContainer() {
    return BlocBuilder<LoginBloc, LoginState>(
      builder: (context, state) {
        return FadeTransition(
          opacity: _animation,
          child: Container(
            child: Column(
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
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
                  keyboardType: TextInputType.text,
                  style: new TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14.0,
                    fontStyle: FontStyle.normal,
                  ),
                  controller: _registerNameController,
                  decoration: InputDecoration(
                    hintText: "Введите ваш имя",
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
                  keyboardType: TextInputType.phone,
                  style: new TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14.0,
                    fontStyle: FontStyle.normal,
                  ),
                  controller: _registerPhoneController,
                  decoration: InputDecoration(
                    hintText: "Введите ваш номер телефона",
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
                  obscureText: true,
                  style: new TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14.0,
                    fontStyle: FontStyle.normal,
                  ),
                  controller: _registerPasswordController,
                  decoration: InputDecoration(
                    hintText: "Придумайте пароль",
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
                  obscureText: true,
                  style: new TextStyle(
                    fontFamily: 'Montserrat',
                    fontSize: 14.0,
                    fontStyle: FontStyle.normal,
                  ),
                  controller: _registerRePasswordController,
                  decoration: InputDecoration(
                    hintText: "Повторите пароль",
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
                  child: state is LoginLoading
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 25.0,
                                    width: 25.0,
                                    child: CupertinoActivityIndicator(),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      : AuthSignInOrSignUpButton(
                          text: 'Зарегистрироваться',
                          press: () {
                            BlocProvider.of<LoginBloc>(context).add(
                              RegisterButtonPressed(
                                email: _registerEmailController.text,
                                firstName: _registerNameController.text,
                                phone: _registerPhoneController.text,
                                password: _registerPasswordController.text,
                                password2: _registerRePasswordController.text,
                              ),
                            );
                          },
                        ),
                ),
                SizedBox(
                  height: 1,
                ),
                TextButton(
                  child: Text(
                    'Уже есть аккаунт?',
                    style: TextStyle(
                      color: Color(0xFF616E77),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      selectedWidgetMarker = WidgetMarker.login;
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
