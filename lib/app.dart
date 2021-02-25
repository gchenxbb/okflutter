import 'package:flutterko/list/post_page.dart';
import 'package:flutterko/login/main_page.dart';
import 'package:flutterko/login/login_page.dart';
import 'package:flutterko/weather/app.dart';
import 'package:flutter/material.dart';
import 'package:flutterko/timer/timer_page.dart';
import 'package:flutterko/counter/counter_page.dart';

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Route'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new FlatButton(
            textColor: Colors.white,
            child: new Text('Timer'),
            color: Colors.blue,
            onPressed: () {
              _goTimerPage(context);
            },
          ),
          new FlatButton(
            textColor: Colors.white,
            child: new Text('Counter'),
            color: Colors.blue,
            onPressed: () {
              _goCounterPage(context);
            },
          ),
          new FlatButton(
              onPressed: () {
                _goInfiniteList(context);
              },
              color: Colors.blue,
              textColor: Colors.white,
              child: new Text('Infinite list')),
          new FlatButton(
              onPressed: () {
                _goLogin(context);
              },
              color: Colors.blue,
              textColor: Colors.white,
              child: new Text('Login')),
          new FlatButton(
              onPressed: () {
                _goWeather(context);
              },
              color: Colors.blue,
              textColor: Colors.white,
              child: new Text('Weather'))
        ],
      ),
    );
  }

  void _goTimerPage(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => TimerPage()));
  }

  void _goCounterPage(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => CounterPage()));
  }

  void _goInfiniteList(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => ListPage()));
  }

  void _goLogin(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => LoginMainPage()));
  }

  void _goWeather(BuildContext context) {
    Navigator.push(
        context, new MaterialPageRoute(builder: (context) => WeatherMainPage()));
  }
}
