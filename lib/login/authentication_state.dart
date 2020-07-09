import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class AuthenticationState extends Equatable{}

class InitialAuthenticationState extends AuthenticationState {
  @override
  String toString() {
    return "InitialAuthenticationState";
  }
}

class AuthenticationAuthenticated extends AuthenticationState {
  @override
  String toString() {
    return "AuthenticationAuthenticated";
  }
}

class AuthenticationUnauthenticated extends AuthenticationState {
  @override
  String toString() {
    return "AuthenticationUnauthenticated";
  }
}

class AuthenticationLoading extends AuthenticationState {
  @override
  String toString() {
    return "AuthenticationLoading";
  }
}
