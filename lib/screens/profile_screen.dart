import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malsat_app/bloc/auth_bloc/auth.dart';
import 'package:malsat_app/bloc/login_bloc/login_bloc.dart';
import 'package:malsat_app/constants/selected_item.dart';
import 'package:malsat_app/pages/home_page.dart';
import 'package:malsat_app/repositories/auth_repository.dart';
import 'package:malsat_app/screens/my_posts_screen.dart';
import 'package:malsat_app/screens/settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  final AuthRepository authRepository;

  const ProfileScreen({Key key,@required this.authRepository}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(
          authRepository, BlocProvider.of<AuthenticationBloc>(context)),
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return SafeArea(
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          InkWell(
                            child: IconButton(
                              icon: Icon(
                                Icons.menu,
                                color: Color(0xFFEA5E3C),
                                size: 30,
                              ),
                              onPressed: () {},
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
                      SizedBox(height: 20),
                      Container(
                        child: Column(
                          children: <Widget>[
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: AssetImage(
                                        "assets/images/avatar.png",
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Редактировать',
                                        style: TextStyle(
                                          color: Color(0xFFC6C6C6),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      'Автор объявления',
                                      style: TextStyle(
                                          color: Color(0xFF9A9A9A),
                                          fontSize: 12,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Text(
                                      'Султан',
                                      style: TextStyle(
                                        color: Color(0xFF4A564A),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                                Column(
                                  children: <Widget>[
                                    Text(
                                      'Ваш кошелек: 0,00 ₸',
                                      style: TextStyle(
                                        color: Color(0xFF4A564A),
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    Text(
                                      'Бонусы: 0,00 Бонусы',
                                      style: TextStyle(
                                        color: Color(0xFF4A564A),
                                        fontSize: 11,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
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
                                      builder: (context) => MyPostsScreen(),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  title: Text(
                                    'Мои объявления',
                                    style: TextStyle(
                                      color: Color(0xFF4A564A),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
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
                                          HomePage(
                                            selectedIndex: SelectedItem
                                                .selectedHeart,
                                          ),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  title: Text(
                                    'Избранные',
                                    style: TextStyle(
                                      color: Color(0xFF4A564A),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
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
                                      builder: (context) => SettingsScreen(authRepository: authRepository,),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  title: Text(
                                    'Настройки',
                                    style: TextStyle(
                                      color: Color(0xFF4A564A),
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  trailing: Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 15,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  BlocProvider.of<LoginBloc>(context).add(
                                    LogOutButtonPressed(),
                                  );
                                },
                                child: Text(
                                  'Выход',
                                  style: TextStyle(
                                    color: Color(0xFF6B6B6B),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
