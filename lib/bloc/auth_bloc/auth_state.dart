import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {
  List<dynamic> loadedCities;
  List<dynamic> loadedPosts;
  List<dynamic> loadedCategories;
  List<dynamic> loadedComments;
  List<dynamic> loadedBookmarks;
  List<dynamic> loadedImages;

  AuthenticationAuthenticated({
    this.loadedCities,
    this.loadedPosts,
    this.loadedCategories,
    this.loadedComments,
    this.loadedBookmarks,
    this.loadedImages,
  });

  @override
  List<Object> get props => [
        loadedCities,
        loadedPosts,
        loadedCategories,
        loadedComments,
        loadedBookmarks,
        loadedImages,
      ];
}

class AuthenticationUnauthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}