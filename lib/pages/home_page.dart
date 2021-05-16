import 'package:flutter/material.dart';
import 'package:malsat_app/models/user.dart';
import 'package:malsat_app/repositories/auth_repository.dart';
import 'package:malsat_app/repositories/post_respository.dart';
import 'package:malsat_app/screens/create_post_screen.dart';
import 'package:malsat_app/constants/custom_icons.dart';
import 'package:malsat_app/screens/favorites_screen.dart';
import 'package:malsat_app/screens/home_screen.dart';
import 'package:malsat_app/screens/profile_screen.dart';
import 'package:malsat_app/screens/search_screen.dart';

class HomePage extends StatefulWidget {
  final int selectedIndex;
  final List<dynamic> listCities;
  final List<dynamic> listCategories;
  final List<dynamic> listPostsApprovedNotHidden;
  final List<dynamic> listMyActivePosts;
  final List<dynamic> listMyHiddenPosts;
  final List<dynamic> listMyCheckingPosts;
  final AuthRepository authRepository;
  final PostRepository postRepository;
  final List<dynamic> listBookmarks;
  final User currentUser;

  const HomePage({
    Key key,
    this.selectedIndex = 0,
    this.listCities,
    this.listCategories,
    this.listPostsApprovedNotHidden,
    this.listMyActivePosts,
    this.listMyHiddenPosts,
    this.listMyCheckingPosts,
    @required this.authRepository,
    this.listBookmarks,
    this.currentUser, this.postRepository,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(selectedIndex);
}

class _HomePageState extends State<HomePage> {
  var selectedIndex;

  List<Widget> _pages;

  _HomePageState(this.selectedIndex);

  @override
  void initState() {
    _pages = [
      HomeScreen(
        authRepository: widget.authRepository,
        loadedPostsApprovedNotHidden: widget.listPostsApprovedNotHidden,
        listBookmarks: widget.listBookmarks,
      ),
      SearchScreen(
        listCategories: widget.listCategories,
      ),
      CreatePostScreen(
        listCities: widget.listCities,
        listCategories: widget.listCategories,
      ),
      FavoritesScreen(
        listBookmarks: widget.listBookmarks,
      ),
      ProfileScreen(
        currentUser: widget.currentUser,
        authRepository: widget.authRepository,
        activePosts: widget.listMyActivePosts,
        hiddenPosts: widget.listMyHiddenPosts,
        checkingPosts:widget.listMyCheckingPosts, postRepository: widget.postRepository,
      ),
    ];
    super.initState();
  }

  List<IconData> icons = [
    Custom.home,
    Custom.heart_empty,
    Icons.add_circle_outline,
    Custom.comment,
    Custom.user,
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Color(0xffF4F4F4),
      body: _pages[selectedIndex],
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(35),
              boxShadow: [
                BoxShadow(
                    color: Colors.black38, spreadRadius: 0, blurRadius: 10),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(35),
              child: BottomNavigationBar(
                backgroundColor: Colors.blueGrey,
                currentIndex: selectedIndex,
                onTap: (value) {
                  setState(() {
                    selectedIndex = value;
                  });
                },
                selectedItemColor: Color(0xFFEA5E3C),
                unselectedItemColor: Color(0xFFBBBBBB),
                selectedFontSize: 12,
                unselectedFontSize: 12,
                showSelectedLabels: false,
                showUnselectedLabels: false,
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                      icon: Icon(
                        Custom.home,
                        size: 18.0,
                      ),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.search_sharp,
                        size: 30.0,
                      ),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Icons.add_circle_outline,
                        size: 45.0,
                        color: Color(0xFFEA5E3C),
                      ),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Custom.heart_empty,
                        size: 20.0,
                      ),
                      label: ''),
                  BottomNavigationBarItem(
                      icon: Icon(
                        Custom.user,
                        size: 18.0,
                      ),
                      label: ''),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
