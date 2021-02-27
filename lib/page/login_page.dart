import 'package:flutter/material.dart';

/**
 * 登陆页面
 */
class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  State createState() {
    return new _LoginState();
  }
}

class _LoginState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Text('login 页面');
  }
}
