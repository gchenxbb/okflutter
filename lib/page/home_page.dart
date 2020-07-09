import 'package:flutter/material.dart';
import 'package:flutterchannel/app.dart';
import 'package:flutterchannel/page/channel_page.dart';
import 'package:flutterchannel/page/login_page.dart';
import 'package:flutterchannel/widget/bottom_bar.dart';
import 'package:flutterchannel/widget/draw_widget.dart';
import 'package:flutterchannel/widget/viewpager_tab.dart';
import 'package:flutterchannel/widget/mytab_controller.dart';
import 'package:flutterchannel/page/counter_page.dart';

import 'dart:async';
import 'dart:ui';

class HomePage extends StatefulWidget {
  HomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final StreamController<int> _streamController = StreamController<int>();

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize:
            Size.fromHeight(MediaQueryData.fromWindow(window).padding.top),
        child: SafeArea(
          top: true,
          child: Offstage(),
        ),
      ),
      body: new Container(
        color: Colors.grey[200],
        child: _getContent(),
      ),
      bottomNavigationBar: new BottomNavigation((index) {
        _streamController.sink.add(index);
      }),
      drawer: DrawerWidget(),
      endDrawer: DrawerWidget(),
    );
  }

  Widget _getContent() {
    return StreamBuilder<int>(
        stream: _streamController.stream,
        initialData: 0,
        builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
          var position = snapshot.hasData ? snapshot.data : 0;
          switch (position) {
            case 0:
              return new Container(
                child: new Column(
                  children: <Widget>[
                    new RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                            builder: (context) => new CounterPage(),
                          ),
                        );
                      },
                      child: new Text("Stream计数"),
                    ),
                    new RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new TabViewHomeWidget()),
                        );
                      },
                      child: new Text("tabviewhome"),
                    ),
                    new RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new MyTabController()),
                        );
                      },
                      child: new Text("mytabcontroller"),
                    ),
                    new RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new LoginPage()),
                        );
                      },
                      child: new Text("login 页面"),
                    ),
                    new RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new ChannelPage(
                                  title: 'Flutter channel  Page')),
                        );
                      },
                      child: new Text("channel 页面"),
                    ),
                    new RaisedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          new MaterialPageRoute(
                              builder: (context) => new App()),
                        );
                      },
                      child: new Text("bloc 页面"),
                    ),
                  ],
                ),
              );

              break;
            case 1:
              new RaisedButton(
                child: new Text("text$position"),
              );
              break;
            case 2:
              new RaisedButton(
                child: new Text("text$position"),
              );
              break;
            case 3:
              new RaisedButton(
                child: new Text("text$position"),
              );
              break;
          }
          return new RaisedButton(
            child: new Text("text$position"),
          );
        });
  }
}
