import 'package:flutterko/login/bloc.dart';
import 'package:flutterko/login/login_bloc.dart';
import 'package:flutterko/login/login_event.dart';
import 'package:flutterko/login/user_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  final UserRepository userRepository;

  LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      //BlocProvider是一种StatefulWidget，向child提供bloc，build方法，返回bloc实例
      body: BlocProvider(
        builder: (context) {
          return LoginBloc(
              authenticationBloc: BlocProvider.of(context),
              userRepository: userRepository);
        },
        child: LoginForm(),
      ),
    );
  }
}

class LoginForm extends StatefulWidget {
  @override
  State createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final loginBloc = BlocProvider.of<LoginBloc>(context);

    _onLoginButtonPressed() {
      loginBloc.dispatch(LoginButtonPressed(
          username: _usernameController.text,
          password: _passwordController.text));
    }

    //监听每一个状态改变，不包括初始状态，和BlocBuilder不同，void方法不返回Widget参数。
    return BlocListener<LoginEvent, LoginState>(
      bloc: BlocProvider.of<LoginBloc>(context),
      condition: (previousState, currentState) {
        // return true/false to determine whether or not
        // to call listener with currentState
      },
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text('${state.error}'),
          ));
        }
      },
      //BlocBuilder根据state构造Widget，builder方法根据state 返回Widget。
      child: BlocBuilder<LoginEvent, LoginState>(
        bloc: BlocProvider.of<LoginBloc>(context),
        builder: (context, state) {
          print(state);
          return Form(
            child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(labelText: "username"),
                  controller: _usernameController,
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "passwprd"),
                  controller: _passwordController,
                ),
                RaisedButton(
                  onPressed:
                      state is! LoginLoading ? _onLoginButtonPressed : null,
                  child: Text('login'),
                ),
                Container(
                    color: Colors.red,
                    child: state is LoginLoading
                        ? CircularProgressIndicator()
                        : null)
              ],
            ),
          );
        },
      ),
    );
  }
}
