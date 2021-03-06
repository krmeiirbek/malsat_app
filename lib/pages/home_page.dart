import 'package:flutter/material.dart';
import 'package:malsat_app/models/user.dart';
import 'package:malsat_app/repositories/auth_repository.dart';
import 'package:malsat_app/repositories/comment_repository.dart';
import 'package:malsat_app/repositories/post_repository.dart';
import 'package:malsat_app/repositories/review_repository.dart';
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
  final List<dynamic> listPostsByCity;
  final AuthRepository authRepository;
  final PostRepository postRepository;
  final List<dynamic> listBookmarks;
  final User currentUser;
  final CommentRepository commentRepository;
  final ReviewRepository reviewRepository;

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
    this.currentUser,
    this.postRepository,
    this.listPostsByCity,
    this.commentRepository,
    @required this.reviewRepository,
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
        listCities: widget.listCities,
        postRepository: widget.postRepository,
        listPostsByCity: widget.listPostsByCity,
        commentRepository: widget.commentRepository,
        currentUser: widget.currentUser,
        listCategories: widget.listCategories,
        listCities1: widget.listCities,
        reviewRepository: widget.reviewRepository,
      ),
      SearchScreen(
        listCategories: widget.listCategories,
        postRepository: widget.postRepository,
        commentRepository: widget.commentRepository,
        currentUser: widget.currentUser,
        authRepository: widget.authRepository,
        listCities: widget.listCities,
        listCategories1: widget.listCategories,
        reviewRepository: widget.reviewRepository,
      ),
      CreatePostScreen(
        listCities: widget.listCities,
        listCategories: widget.listCategories,
        postRepository: widget.postRepository,
      ),
      FavoritesScreen(
        listBookmarks: widget.listBookmarks,
        commentRepository: widget.commentRepository,
        currentUser: widget.currentUser,
        authRepository: widget.authRepository,
        listCategories: widget.listCategories,
        listCities: widget.listCities,
        postRepository: widget.postRepository,
        reviewRepository: widget.reviewRepository,
      ),
      ProfileScreen(
        currentUser: widget.currentUser,
        authRepository: widget.authRepository,
        activePosts: widget.listMyActivePosts,
        hiddenPosts: widget.listMyHiddenPosts,
        checkingPosts: widget.listMyCheckingPosts,
        postRepository: widget.postRepository,
        commentRepository: widget.commentRepository,
        listCategories: widget.listCategories,
        listCities: widget.listCities,
        reviewRepository: widget.reviewRepository,
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
                backgroundColor: Colors.white,
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
                type: BottomNavigationBarType.fixed,
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
