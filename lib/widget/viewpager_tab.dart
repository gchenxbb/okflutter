import 'package:flutter/material.dart';
import 'package:flutterchannel/widget/flulist.dart';

//DefaultTabController
class TabViewHomeWidget extends StatefulWidget {
  TabViewHomeWidget({Key key, this.keywords}) : super(key: key);
  final String keywords;

  @override
  State<StatefulWidget> createState() {
    return new _TabViewHomeWidgetState();
  }
}

class _TabViewHomeWidgetState extends State<TabViewHomeWidget> {
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

  String keywords;

  void initState() {
    keywords = widget.keywords;
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
      length: myTabs.length,
      child: new Scaffold(
        appBar: new AppBar(
          backgroundColor: Colors.white,
          title: new TabBar(
              indicatorColor: new Color(0xffff6602),
              labelColor: new Color(0xffff6602),
              isScrollable: false,
              tabs: myTabs),
        ),
        body: new TabBarView(
            children: [new ListHome(), new ListHome(), new ListHome(), new ListHome()]),
      ),
    );
  }
}
