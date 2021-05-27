import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:malsat_app/bloc/auth_bloc/auth.dart';
import 'package:malsat_app/data/data.dart';
import 'package:malsat_app/pages/auth.dart';
import 'package:malsat_app/pages/home_page.dart';
import 'package:malsat_app/repositories/bookmark_repository.dart';
import 'package:malsat_app/repositories/comment_repository.dart';
import 'package:malsat_app/repositories/post_repository.dart';
import 'package:malsat_app/repositories/repositories.dart';
import 'package:malsat_app/repositories/review_repository.dart';

void main() {
  final authRepository = authRepositoryGlobal;
  final CityRepository cityRepository = CityRepository();
  final CategoryRepository categoryRepository = CategoryRepository();
  final PostRepository postRepository = PostRepository();
  final BookmarkRepository bookmarkRepository = BookmarkRepository();
  final CommentRepository commentRepository = CommentRepository();
  final ReviewRepository reviewRepository = ReviewRepository();

  runApp(
    BlocProvider(
      create: (context) {
        return AuthenticationBloc(
          authRepository,
          cityRepository,
          categoryRepository,
          postRepository,
          bookmarkRepository,
        )..add(AppStarted());
      },
      child: MyApp(
        authRepository: authRepository,
        cityRepository: cityRepository,
        categoryRepository: categoryRepository,
        postRepository: postRepository,
        bookmarkRepository: bookmarkRepository,
        commentRepository: commentRepository,
        reviewRepository: reviewRepository,
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final CityRepository cityRepository;
  final CategoryRepository categoryRepository;
  final PostRepository postRepository;
  final BookmarkRepository bookmarkRepository;
  final CommentRepository commentRepository;
  final ReviewRepository reviewRepository;

  MyApp({
    Key key,
    @required this.authRepository,
    this.cityRepository,
    this.categoryRepository,
    this.postRepository,
    this.bookmarkRepository,
    this.commentRepository,
    this.reviewRepository,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            return HomePage(
              listCities: state.loadedCities,
              listCategories: state.loadedCategories,
              listPostsApprovedNotHidden: state.loadedPostsApprovedNotHidden,
              authRepository: authRepository,
              listMyActivePosts: state.listMyActivePosts,
              listMyHiddenPosts: state.listMyHiddenPosts,
              listMyCheckingPosts: state.listMyCheckingPosts,
              postRepository: postRepository,
              listBookmarks: state.loadedBookmarks,
              selectedIndex: state.openScreen,
              currentUser: state.currentUser,
              listPostsByCity: state.listPostsByCity,
              commentRepository: commentRepository,
              reviewRepository: reviewRepository,
            );
          }
          if (state is AuthenticationUnauthenticated) {
            return AuthSwitch(
              authRepository: authRepository,
              postRepository: postRepository,
            );
          }
          if (state is AuthenticationLoading) {
            return Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          return Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        },
      ),
    );
  }
}
