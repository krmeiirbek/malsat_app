import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malsat_app/bloc/auth_bloc/auth_bloc.dart';
import 'package:malsat_app/bloc/login_bloc/login_bloc.dart';
import 'package:malsat_app/components/auth_signin_or_signup_button.dart';
import 'package:malsat_app/repositories/auth_repository.dart';
import 'package:malsat_app/repositories/post_respository.dart';

class ChangePasswordScreen extends StatefulWidget {
  final AuthRepository authRepository;
  final PostRepository postRepository;

  const ChangePasswordScreen({Key key, @required this.authRepository,@required this.postRepository})
      : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _oldPassword = TextEditingController();
  TextEditingController _newPassword = TextEditingController();
  TextEditingController _reNewPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(widget.authRepository, BlocProvider.of<AuthenticationBloc>(context),widget.postRepository),
      child: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is ChangePasswordFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.toString()),
                backgroundColor: Colors.red,
              ),
            );
          }
          if (state is ChangePasswordSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.toString()),
                backgroundColor: Colors.greenAccent,
              ),
            );
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return Scaffold(
              body: SafeArea(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                        // color: Colors.white,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  child: IconButton(
                                    icon: Icon(
                                      Icons.arrow_back_ios,
                                      color: Color(0xFFEA5E3C),
                                      size: 30,
                                    ),
                                    onPressed: () => Navigator.pop(context),
                                  ),
                                ),
                                Spacer(
                                  flex: 2,
                                ),
                                Container(
                                  height: 30,
                                  padding: EdgeInsets.symmetric(vertical: 5),
                                  child: Image(
                                    image:
                                        AssetImage("assets/images/MALSAT.png"),
                                  ),
                                ),
                                Spacer(
                                  flex: 3,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Spacer(flex: 2,),
                      Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              TextField(
                                obscureText: true,
                                style: new TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontSize: 14.0,
                                  fontStyle: FontStyle.normal,
                                ),
                                controller: _oldPassword,
                                decoration: InputDecoration(
                                  hintText: "Введите ваш прежний пароль",
                                  hintStyle: TextStyle(
                                      color: Color.fromRGBO(74, 86, 74, 0.4),
                                      fontSize: 14.0),
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
                                controller: _newPassword,
                                decoration: InputDecoration(
                                  hintText: "Введите ваш новый пароль",
                                  hintStyle: TextStyle(
                                      color: Color.fromRGBO(74, 86, 74, 0.4),
                                      fontSize: 14.0),
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
                                controller: _reNewPassword,
                                decoration: InputDecoration(
                                  hintText: "Повторите ваш новый пароль",
                                  hintStyle: TextStyle(
                                      color: Color.fromRGBO(74, 86, 74, 0.4),
                                      fontSize: 14.0),
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
                                child: AuthSignInOrSignUpButton(
                                  text: 'Обновить',
                                  press: () {
                                    BlocProvider.of<LoginBloc>(context).add(
                                      ChangePasswordButtonPressed(
                                        oldPassword: _oldPassword.text,
                                        password: _newPassword.text,
                                        password2: _reNewPassword.text,
                                      ),
                                    );
                                    _oldPassword.clear();
                                    _newPassword.clear();
                                    _reNewPassword.clear();
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),),
                      Spacer(flex: 3,),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
