import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutterko/widget/flulist.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:async';

//自定义TabController
class MyTabController extends StatefulWidget {
  MyTabController({Key key, this.title}) : super(key: key);
  final String title;

  @override
  State<StatefulWidget> createState() {
    return new _MyTabController();
  }
}

class _MyTabController extends State<MyTabController>
    with SingleTickerProviderStateMixin {
  final List<Tab> myTabs = <Tab>[
    new Tab(
      icon: new Icon(Icons.home),
      text: '1',
    ),
    new Tab(
      icon: new Icon(Icons.message),
      text: '2',
    ),
    new Tab(
      icon: new Icon(Icons.camera),
      text: '3',
    ),
    new Tab(
      icon: new Icon(Icons.access_alarm),
      text: '4',
    )
  ];
  TabController tabController;

  @override
  void initState() {
    super.initState();
    tabController = new TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.white,
        title: new TabBar(
            controller: tabController,
            indicatorColor: new Color(0xffff6602),
            labelColor: new Color(0xffff6602),
            isScrollable: false,
            tabs: myTabs),
      ),
      body: new TabBarView(controller: tabController, children: [
        new ListHome(),
        new ListHome(),
        new ListHome(),
        new ListHome()
      ]),
    );
  }
}
