import 'package:flutterko/login/authentication_bloc.dart';
import 'package:flutterko/login/authentication_event.dart';
import 'package:flutterko/login/bloc.dart';
import 'package:flutterko/login/home_page.dart';
import 'package:flutterko/login/login_page.dart';
import 'package:flutterko/login/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterko/login/splash_page.dart';
import 'package:flutterko/login/authentication_state.dart';

class LoginMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userRepository = UserRepository();
    return BlocProvider<AuthenticationBloc>(
      builder: (context) {
        return AuthenticationBloc(userRepository: userRepository)
          ..dispatch(AppStarted());
      },
      child: App(userRepository: userRepository),
    );
  }
}

class App extends StatelessWidget {
  final UserRepository userRepository;

  App({Key key, @required this.userRepository}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthenticationBloc authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);
    return MaterialApp(
      home: BlocBuilder<AuthenticationEvent, AuthenticationState>(
        bloc: authenticationBloc,
        builder: (context, state) {
          print(state);
          if (state is InitialAuthenticationState) {
            return SplashPage();
          }
          if (state is AuthenticationAuthenticated) {
            return HomePage();
          }
          if (state is AuthenticationUnauthenticated) {
            return LoginPage(userRepository: userRepository);
          }
          return Container(
            color: Colors.white,
            child: Text('Login'),
          );
        },
      ),
    );
  }
}
