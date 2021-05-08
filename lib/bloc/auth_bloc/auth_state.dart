import 'package:equatable/equatable.dart';

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
  final List<dynamic> loadedImages;
  final int openScreen;

  AuthenticationAuthenticated({
    this.loadedCities,
    this.loadedPostsApprovedNotHidden,
    this.loadedCategories,
    this.loadedComments,
    this.loadedBookmarks,
    this.loadedImages,
    this.openScreen,
  });

  @override
  List<Object> get props => [
        loadedCities,
        loadedPostsApprovedNotHidden,
        loadedCategories,
        loadedComments,
        loadedBookmarks,
        loadedImages,
      ];
}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}
