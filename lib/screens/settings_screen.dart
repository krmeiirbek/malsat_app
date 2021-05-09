import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:malsat_app/repositories/auth_repository.dart';
import 'package:malsat_app/screens/change_password_screen.dart';

class SettingsScreen extends StatelessWidget {
  final AuthRepository authRepository;


  const SettingsScreen({Key key, @required this.authRepository,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          image: AssetImage("assets/images/MALSAT.png"),
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
                            'Настройки',
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
                        child: ListTile(
                          title: Text(
                            'Контактные данные',
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
                      SizedBox(
                        height: 10,
                      ),
                      Card(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChangePasswordScreen(
                                  authRepository: authRepository,
                                ),
                              ),
                            );
                          },
                          child: ListTile(
                            title: Text(
                              'Изменить пароль',
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
                        child: ListTile(
                          title: Text(
                            'Удалить аккаунт',
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
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
