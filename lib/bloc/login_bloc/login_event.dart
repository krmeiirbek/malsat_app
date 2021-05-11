part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  const LoginButtonPressed({
    this.email,
    this.password,
  });

  @override
  List<Object> get props => [email, password];

  @override
  String toString() =>
      'LoginButtonPressed {email: $email, password: $password}';
}

class RegisterButtonPressed extends LoginEvent {
  final String email;
  final String firstName;
  final String phone;
  final String password;
  final String password2;

  const RegisterButtonPressed({
    this.email,
    this.firstName,
    this.phone,
    this.password,
    this.password2,
  });

  @override
  List<Object> get props => [email, firstName, phone, password, password2];

  @override
  String toString() =>
      'RegisterButtonPressed {email: $email, firstName: $firstName, phone: $phone, password: $password}';
}

class LogOutButtonPressed extends LoginEvent {
  @override
  List<Object> get props => [];
}

class ChangePasswordButtonPressed extends LoginEvent {
  final String oldPassword;
  final String password;
  final String password2;

  const ChangePasswordButtonPressed({
    this.oldPassword,
    this.password,
    this.password2,
  });

  @override
  List<Object> get props => [oldPassword, password, password2];

  @override
  String toString() => 'ChangePasswordButtonPressed';
}

class CreatePostButtonPressed extends LoginEvent {
  final String title;
  final String description;
  final int price;
  final bool exchange;
  final bool auction;
  final bool delivery;

  CreatePostButtonPressed(this.title, this.description, this.price,
      this.exchange, this.auction, this.delivery);

  @override
  List<Object> get props =>
      [title, description, price, exchange, auction, delivery];

  @override
  String toString() => 'ChangePasswordButtonPressed';
}
