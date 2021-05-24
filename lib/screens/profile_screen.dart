import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malsat_app/bloc/auth_bloc/auth.dart';
import 'package:malsat_app/bloc/login_bloc/login_bloc.dart';
import 'package:malsat_app/models/category.dart';
import 'package:malsat_app/models/city.dart';
import 'package:malsat_app/models/post.dart';
import 'package:malsat_app/models/user.dart';
import 'package:malsat_app/repositories/auth_repository.dart';
import 'package:malsat_app/repositories/comment_repository.dart';
import 'package:malsat_app/repositories/post_repository.dart';
import 'package:malsat_app/screens/my_posts_screen.dart';
import 'package:malsat_app/screens/settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  final AuthRepository authRepository;
  final PostRepository postRepository;
  final List<Post> activePosts;
  final List<Post> hiddenPosts;
  final List<Post> checkingPosts;
  final User currentUser;
  final CommentRepository commentRepository;
  final List<City> listCities;
  final List<Category> listCategories;

  const ProfileScreen({
    Key key,
    @required this.authRepository,
    @required this.postRepository,
    this.activePosts,
    this.hiddenPosts,
    this.checkingPosts,
    this.currentUser,
    this.commentRepository,
    @required this.listCities,
    @required this.listCategories,
  }) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<Post> userPosts;
  bool _loading = false;

  @override
  void initState() {
    getPosts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginBloc(widget.authRepository,
          BlocProvider.of<AuthenticationBloc>(context), widget.postRepository),
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
                                      image: widget.currentUser.image == null
                                          ? AssetImage(
                                              "assets/images/nouser.png",
                                            )
                                          : NetworkImage(
                                              widget.currentUser.image),
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
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MyPostsScreen(
                                              isMyPost: true,
                                              commentRepository:
                                                  widget.commentRepository,
                                              currentUser: widget.currentUser,
                                              listPosts: userPosts,
                                              listCities: widget.listCities,
                                              listCategories:
                                                  widget.listCategories,
                                              postRepository:
                                                  widget.postRepository,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'Автор объявления',
                                        style: TextStyle(
                                            color: Color(0xFF9A9A9A),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                    Text(
                                      widget.currentUser.firstName,
                                      style: TextStyle(
                                        color: Color(0xFF4A564A),
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
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
                                      builder: (context) => MyPostsScreen(
                                        authRepository: widget.authRepository,
                                        commentRepository:
                                            widget.commentRepository,
                                        currentUser: widget.currentUser,
                                        listPosts: widget.activePosts,
                                        listCities: widget.listCities,
                                        listCategories: widget.listCategories,
                                        postRepository: widget.postRepository,
                                      ),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  title: Text(
                                    'Активные',
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
                                      builder: (context) => MyPostsScreen(
                                        authRepository: widget.authRepository,
                                        commentRepository:
                                            widget.commentRepository,
                                        currentUser: widget.currentUser,
                                        listPosts: widget.checkingPosts,
                                        listCities: widget.listCities,
                                        listCategories: widget.listCategories,
                                        postRepository: widget.postRepository,
                                      ),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  title: Text(
                                    'На проверке',
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
                                      builder: (context) => MyPostsScreen(
                                        authRepository: widget.authRepository,
                                        commentRepository:
                                            widget.commentRepository,
                                        currentUser: widget.currentUser,
                                        listPosts: widget.hiddenPosts,
                                        listCities: widget.listCities,
                                        listCategories: widget.listCategories,
                                        postRepository: widget.postRepository,
                                      ),
                                    ),
                                  );
                                },
                                child: ListTile(
                                  title: Text(
                                    'Скрытые',
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
                                      builder: (context) => SettingsScreen(
                                        authRepository: widget.authRepository,
                                        currentUser: widget.currentUser,
                                        postRepository: widget.postRepository,
                                      ),
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

  Future<void> getPosts() async {
    setState(() {
      _loading = true;
    });
    userPosts = await widget.authRepository
        .getPostsByUser(widget.currentUser.id.toString());
    setState(() {
      _loading = false;
    });
  }
}
