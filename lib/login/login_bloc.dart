import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutterchannel/login/user_repository.dart';
import 'package:flutter/cupertino.dart';
import './bloc.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({@required this.userRepository, @required this.authenticationBloc})
      : assert(authenticationBloc != null),
        assert(userRepository != null);

  @override
  LoginState get initialState => InitialLoginState();

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();

      try {
        final token = await userRepository.authenticate(
            username: event.username, password: event.password);

        authenticationBloc.dispatch(LoggedIn(token: token));

        yield InitialLoginState();
      } catch (error) {
        yield LoginFailure(error: error.toString());
      }
    }
  }
}
