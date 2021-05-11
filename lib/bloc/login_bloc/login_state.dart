part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginFailure extends LoginState {
  final String error;

  const LoginFailure({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'LoginFailure {$error}';
}

class RegisterFailure extends LoginState {
  final String error;

  const RegisterFailure({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'RegisterFailure {$error}';
}

class ChangePasswordFailure extends LoginState {
  final String error;

  const ChangePasswordFailure({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'ChangePasswordFailure {$error}';
}

class ChangePasswordSuccess extends LoginState {
  final String success;

  const ChangePasswordSuccess({this.success});

  @override
  List<Object> get props => [success];

  @override
  String toString() => 'ChangePasswordSuccess {$success}';
}

class CreatePostButtonSuccess extends LoginState {
  final String success;

  const CreatePostButtonSuccess({this.success});

  @override
  List<Object> get props => [success];

  @override
  String toString() => 'CreatePostButtonSuccess {$success}';
}


class CreatePostFailure extends LoginState {
  final String error;

  const CreatePostFailure({this.error});

  @override
  List<Object> get props => [error];

  @override
  String toString() => 'CreatePostFailure {$error}';
}