import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class LoginState extends Equatable {
  LoginState([List props = const []]) : super(props);
}

class InitialLoginState extends LoginState {
  @override
  String toString() {
    return 'InitialLoginState';
  }
}

class LoginLoading extends LoginState {
  @override
  String toString() {
    return 'LoginLoading';
  }
}

class LoginFailure extends LoginState {
  final String error;

  LoginFailure({@required this.error}) : super([error]);

  @override
  String toString() {
    return 'LoginFailure {error:$error} ';
  }
}
