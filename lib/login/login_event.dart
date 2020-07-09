import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginEvent extends Equatable {
  LoginEvent([List props = const []]) : super(props);
}

class LoginButtonPressed extends LoginEvent {
  final String username;
  final String password;

  LoginButtonPressed({@required this.username, this.password})
      : super([username, password]);

  @override
  String toString() =>
      'LoginButtonPressed {username:$username,password:$password}';
}
