import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malsat_app/bloc/auth_bloc/auth.dart';
import 'package:malsat_app/bloc/login_bloc/login_bloc.dart';
import 'package:malsat_app/data/data.dart';
import 'package:malsat_app/models/user.dart';
import 'package:malsat_app/pages/auth.dart';
import 'package:malsat_app/repositories/auth_repository.dart';
import 'package:malsat_app/repositories/post_repository.dart';
import 'package:malsat_app/screens/change_password_screen.dart';
import 'package:malsat_app/screens/user_details.dart';
import 'package:http/http.dart' as http;

class SettingsScreen extends StatefulWidget {
  final PostRepository postRepository;
  final AuthRepository authRepository;
  final User currentUser;

  const SettingsScreen({
    Key key,
    @required this.authRepository,
    this.currentUser,
    this.postRepository,
  }) : super(key: key);

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return state is AuthenticationLoading
            ? Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        )
            : Scaffold(
          body: SafeArea(
            child: Column(
              children: [
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Container(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: <Widget>[
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                '??????????????????',
                                style: TextStyle(
                                    color: Color(0xFF4A564A),
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Card(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            UserDetailsScreen(
                                                currentUser:
                                                widget.currentUser)));
                              },
                              child: ListTile(
                                title: Text(
                                  '???????????????????? ????????????',
                                  style: TextStyle(
                                      color: Color(0xFF4A564A),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ChangePasswordScreen(
                                          authRepository:
                                          widget.authRepository,
                                          postRepository: widget.postRepository,
                                        ),
                                  ),
                                );
                              },
                              child: ListTile(
                                title: Text(
                                  '???????????????? ????????????',
                                  style: TextStyle(
                                      color: Color(0xFF4A564A),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Card(
                            child: InkWell(
                              onTap: () {
                                showModalBottomSheet(
                                  context: context,
                                  builder: ((builder) => bottomSheet()),
                                );
                              },
                              child: ListTile(
                                title: Text(
                                  '?????????????? ??????????????',
                                  style: TextStyle(
                                      color: Color(0xFF4A564A),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                trailing: Icon(
                                  Icons.arrow_forward_ios_rounded,
                                  size: 15,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget bottomSheet() {
    return BlocProvider(
      create: (context) =>
          LoginBloc(widget.authRepository,
              BlocProvider.of<AuthenticationBloc>(context),
              widget.postRepository),
      child: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state1) {
          return BlocBuilder<LoginBloc, LoginState>(
            builder: (context, state) {
              return state1 is AuthenticationLoading
                  ? Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              )
                  : Container(
                height: 100,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                margin: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      "?????????????? ???????????????",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton.icon(
                          onPressed: () async {
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) =>
                                    AuthSwitch(
                                        authRepository: widget.authRepository,
                                        postRepository: widget.postRepository)));
                            BlocProvider.of<LoginBloc>(context).add(
                              LogOutButtonPressed(),
                            );
                            await http.delete(
                              Uri.parse(
                                  "http://api.malsat.kz/api/users/${widget
                                      .currentUser.id}/"),
                              headers: {
                                'Authorization': 'Bearer $ACCESS_TOKEN',
                              },
                            );
                          },
                          icon: Icon(
                            Icons.done,
                            color: Colors.black,
                          ),
                          label: Text(
                            "????",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(
                            Icons.clear,
                            color: Colors.black,
                          ),
                          label: Text(
                            "??????",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
