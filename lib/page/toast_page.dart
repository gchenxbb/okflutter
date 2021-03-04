import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ToastPage extends StatefulWidget {
  final String title;

  ToastPage({Key key, this.title}) : super(key: key);

  @override
  _ToastPageState createState() => new _ToastPageState();
}

GlobalKey globalKey = GlobalKey();

class _ToastPageState extends State<ToastPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: globalKey,
      appBar: AppBar(
        title: Text('toast title'),
      ),
      backgroundColor: Colors.greenAccent,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          RaisedButton(
            onPressed: () {
              Fluttertoast.showToast(
                  msg: "你今天真好看",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black45,
                  textColor: Colors.white,
                  fontSize: 16.0);
            },
            child: Text('flutter toast '),
          ),
          SizedBox(
            height: 24,
          ),
          RaisedButton(
            onPressed: () {
              Fluttertoast.showToast(
                  msg: "你今天真好看2",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.black45,
                  textColor: Colors.white,
                  fontSize: 16.0);
            },
            child: Text('flutter toast 2'),
          ),
        ],
      ),
    );
  }
}
