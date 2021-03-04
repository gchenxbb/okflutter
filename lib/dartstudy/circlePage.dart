import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:isolate';

class CirclePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return CircleWidgetState();
  }
}

class CircleWidgetState extends State<CirclePage> {
  int _count = 0;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Center(
        child: Column(
          children: <Widget>[
            Container(
              width: 100,
              height: 100,
              child: CircularProgressIndicator(),
            ),
            FlatButton(
                onPressed: () async {
                  print("begin onPressed");
//                  _getWaitValue(1000000000).then((value) {
//                    print("value:$value");
//                    _count = value;
//                    setState(() {});
//                  });
                  _getValue(1000000000).then((value) {
                    print("value:$value");
                    _count = value;
                    setState(() {});
                  });
                  print("end onPressed");
                },
                child: Text(
                  _count.toString(),
                )),
          ],
          mainAxisSize: MainAxisSize.min,
        ),
      ),
    );
  }

  //计算，耗时
  Future<int> _getWaitValue(int num) async {
    print('_getWaitValue begin');
    int count = await new Future(() {
      //点击按钮时，这段耗时太长，放在事件队列尾部，不管怎样，还是在主线程中执行。影响ui。
      return countResult(num);
    });
    print('_getWaitValue end');
    return count;
  }

  //使用compute代替新建一个Future。不会阻塞主线程
  Future<int> _getValue(int num) async {
    print('_getValue start');
    int count = await compute(countResult, 1000000000);
    print('_getValue end');
    return count;
  }

  //compute参数必须是顶级函数或者是static函数
  static int countResult(int num) {
    int count = 0;
    while (num > 0) {
      if (num % 2 == 0) {
        count++;
      }
      num--;
    }
    return count;
  }

  static Future<dynamic> isolateGetValue(int num) async {
    final response = ReceivePort();
    await Isolate.spawn(countResult2, response.sendPort);

    final sendPort = await response.first;
  }

  static void countResult2(SendPort port) {
    final port = ReceivePort();
//    port.sen
  }
}
