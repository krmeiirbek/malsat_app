import 'package:equatable/equatable.dart';
import 'package:malsat_app/models/user.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  final List<dynamic> loadedCities;
  final List<dynamic> loadedPostsApprovedNotHidden;
  final List<dynamic> loadedCategories;
  final List<dynamic> loadedComments;
  final List<dynamic> loadedBookmarks;

  final List<dynamic> listMyActivePosts;
  final List<dynamic> listMyHiddenPosts;
  final List<dynamic> listMyCheckingPosts;

  final List<dynamic> loadedImages;
  final User currentUser;
  final int openScreen;

  AuthenticationAuthenticated({
    this.loadedCities,
    this.loadedPostsApprovedNotHidden,
    this.loadedCategories,
    this.loadedComments,
    this.loadedBookmarks,
    this.listMyActivePosts,
    this.listMyHiddenPosts,
    this.listMyCheckingPosts,
    this.loadedImages,
    this.currentUser,
    this.openScreen = 0,
  });

  @override
  List<Object> get props => [
        loadedCities,
        loadedPostsApprovedNotHidden,
        loadedCategories,
        loadedComments,
        listMyActivePosts,
        listMyHiddenPosts,
        listMyCheckingPosts,
        loadedBookmarks,
        loadedImages,
      ];
}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}
