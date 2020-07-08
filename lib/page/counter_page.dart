import 'package:flutter/material.dart';
import 'dart:async';

class CounterPage extends StatefulWidget {
  @override
  _CounterPageState createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  //步骤1:初始化一个StreamController<任何数据>
  //简单的可以扔一个int,string,开发中经常扔一个网络请求的model进去，具体看你使用场景了。
  final StreamController<int> _streamController = StreamController<int>();

  @override
  void dispose() {
    _streamController.close();
    super.dispose();
  }

  void _incrementCounter() {
    // 每次点击按钮，更加_counter的值，同时通过Sink将它发送给Stream；
    // 每注入一个值，都会引起StreamBuilder的监听，StreamBuilder重建并刷新counter
    //步骤4.往StreamBuilder里添加流，数据变了，就用通知小部件
    _streamController.sink.add(++_counter);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Stream Counter App'),
      ),
      body: Center(
        //步骤3.使用StreamBuilder构造器
        child: StreamBuilder<int>(
            // 监听Stream，每次值改变的时候，更新Text中的内容
            stream: _streamController.stream,
            initialData: _counter,
            builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
              return Text('You click me: ${snapshot.data} times');
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

}
