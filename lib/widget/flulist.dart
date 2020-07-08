import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart';
import 'dart:async';

//列表page
class ListHome extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new ListState();
  }
}

class ListState extends State<ListHome> {
  static const platform_http =
      const MethodChannel('com.pac.framework.plugins/http');
  String dataStr = "";
  var _items = [];

  @override
  Widget build(BuildContext context) {
    print("build!!!$this.hashCode");
    return layout(context);
  }

  @override
  void initState() {
    super.initState();
    print("initState,$this.hashCode");
    getData();
//    _getHttpData();
  }

  static const stream =
      const EventChannel('com.yourcompany.eventchannelsample/stream');

  StreamSubscription _timerSubscription = null;

  void _enableTimer() {
    if (_timerSubscription == null) {
      _timerSubscription =
          stream.receiveBroadcastStream().listen(_updateTimer); // 添加监听
    }
  }

  void _disableTimer() {
    if (_timerSubscription != null) {
      _timerSubscription.cancel();
      _timerSubscription = null;
    }
  }

  var _timer = 0;

  void _updateTimer(timer) {
    debugPrint("Timer $timer");
    setState(() => _timer = timer);
  }

  Future _getHttpData() async {
    final String result =
        await platform_http.invokeMethod('getHttpData', {'message': 'values'});
    if (result != null) {
      print('result:$result');
      var items = parseData(result);
      setState(() {
        dataStr = result.toString();
        _items = items;
      });
    }
  }

  void getData() {
    Map<String, String> map = new Map();
    map["v"] = "1.0";
    map["month"] = "7";
    map["day"] = "25";
    map["key"] = "bd6e35a2691ae5bb8425c8631e475c2a";
    post("http://api.juheapi.com/japi/toh", (data) {
      if (data != null) {
        var items = parseData(data);
        setState(() {
          dataStr = data.toString();
          _items = items;
        });
      }
    }, params: map);
    print('getData end');
  }

  List parseData(String data) {
    if (data != null) {
      final body = json.decode(data.toString());
      final feeds = body["result"];
      print(feeds);
      var items = [];
      feeds.forEach((item) {
        items.add(Model(item["_id"], item["title"], item["pic"], item["year"],
            item["month"], item["day"], item["des"], item["lunar"]));
      });
      return items;
//      setState(() {
//        dataStr = data.toString();
//        _items = items;
//      });
    }
  }

  Widget layout(BuildContext context) {
    return new Scaffold(
      body:
          new ListView.builder(itemCount: _items.length, itemBuilder: itemView),
    );
  }

  Widget itemView(BuildContext context, int index) {
    Model model = this._items[index];
    //设置分割线
    if (index.isOdd) return new Divider(height: 2.0);
    return new Container(
        child: new Padding(
            padding: const EdgeInsets.all(8.0),
            child: new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new Column(
                  children: <Widget>[
                    new Row(
                      children: <Widget>[
                        new Text('${model.year}年${model.month}月${model.day}日',
                            style: new TextStyle(fontSize: 15.0)),
                        new Text('(${model.lunar})',
                            style: new TextStyle(fontSize: 15.0)),
                      ],
                    ),
                    new Center(
                      heightFactor: 6.0,
                      child: new Text("${model.title}",
                          style: new TextStyle(fontSize: 17.0)),
                    )
                  ],
                ))));
  }

  void post(String url, Function callback,
      {Map<String, String> params, Function errorCallback}) async {
    try {
      http.Response res = await http.post(url, body: params);
      // await new Future.delayed(new Duration(milliseconds: 5000));
      if (callback != null) {
        callback(res.body);
      }
    } catch (e) {
      if (errorCallback != null) {
        errorCallback(e);
      }
    }
  }
}

class Model {
  String _id;
  String title;
  String pic;
  int year;
  int month;
  int day;
  String des;
  String lunar;

  Model(this._id, this.title, this.pic, this.year, this.month, this.day,
      this.des, this.lunar);
}
