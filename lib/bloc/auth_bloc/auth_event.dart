import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  List<Object> get props => [];
}

class AppStarted extends AuthenticationEvent {}

class LoggedIn extends AuthenticationEvent {
  final String token;

  const LoggedIn({@required this.token});

  @override
  List<Object> get props => [token];

  @override
  String toString() => 'LoggedIn {$token}';
}

class LoggedOut extends AuthenticationEvent {}

class OpenScreen extends AuthenticationEvent {
  final int openScreen;

  OpenScreen({@required this.openScreen});
}

class UpdateBookMarks extends AuthenticationEvent {
  final int postId;
  final bool inBookmarks;
  final int openScreen;

  const UpdateBookMarks({@required this.postId,this.inBookmarks = true,this.openScreen = 0, });

  @override
  List<Object> get props => [postId,inBookmarks];

  @override
  String toString() => 'UpdateBookMarks {$postId}';
}

