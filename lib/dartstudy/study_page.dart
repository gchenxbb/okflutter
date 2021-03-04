import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:flutterko/dartstudy/circlePage.dart';
import 'package:flutterko/dartstudy/factory.dart';
import 'package:flutterko/dartstudy/mixinApi.dart';

class DartStudyHomePage extends StatefulWidget {
  DartStudyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _StudyHomePageState createState() => _StudyHomePageState();
}

class _StudyHomePageState extends State<DartStudyHomePage> {
  static const _platform = const MethodChannel('com.framework.plugins/toast');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: new CustomScrollView(
        shrinkWrap: true,
        slivers: <Widget>[
          new SliverPadding(
            padding: const EdgeInsets.all(20.0),
            sliver: new SliverList(
                delegate: new SliverChildListDelegate(
              <Widget>[
                RaisedButton(
                  child: Text('asset关键字'),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  elevation: 15,
                  onPressed: _onBtnTest1,
                ),
                RaisedButton(
                  child: Text('数据类型'),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  elevation: 15,
                  onPressed: _onBtnTest2,
                ),
                RaisedButton(
                  child: Text('dynamic关键字'),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  elevation: 15,
                  onPressed: _onBtnTest3,
                ),
                RaisedButton(
                  child: Text('同步生成器'),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  elevation: 15,
                  onPressed: _onBtnTest4,
                ),
                RaisedButton(
                  child: Text('异步生成器'),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  elevation: 15,
                  onPressed: _onBtnTest5,
                ),
                RaisedButton(
                  child: Text('await和async和then'),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  elevation: 15,
                  onPressed: () {
                    //onBtnTest6方法是async方法，返回一个Future。在内部wait时会等待，不会影响流程。
                    _onBtnTest6()
                        .then((str) {
                          print("then,$str");
                        })
                        .then((_) => print('callback1'))
                        .then((_) {
                          print('callback2-1');
                          print('callback2-2');
                          new Future(() => print('future #callback1'));
                        })
                        .then(
                            (_) => new Future(() => print('future #callback2')))
                        .then((_) => print(
                            'callback3')) //注意，callback3是跟在最后插入事件队列的Future后面执行的
                        .then((_) => print('callback4'))
                        .catchError((error) => print('error:$error'))
                        .whenComplete(() => ("whenComplete"));
                    print('不影响主流程');
                  },
                ),
                RaisedButton(
                  child: Text('microtask queue'),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  elevation: 15,
                  onPressed: _onBtnTest7,
                ),
                RaisedButton(
                  child: Text('页面跳转'),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  elevation: 15,
                  onPressed: _onBtnTest8,
                ),
                RaisedButton(
                  child: Text('await和async'),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  elevation: 15,
                  onPressed: () {
                    //onBtnTest6方法是async方法，返回一个Future。在内部wait时会等待，不会影响流程。
                    Future fu = _onBtnTest9();
                    print('返回了future:$fu');
                    fu.then((str) {
                      print("then,$str");
                    });
                    print('不影响主流程');
                  },
                ),
                RaisedButton(
                  child: Text('factory关键字'),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  elevation: 15,
                  onPressed: _onBtnTest10,
                ),
                RaisedButton(
                  child: Text('mixin'),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  elevation: 15,
                  onPressed: _onBtnTest11,
                ),
                RaisedButton(
                  child: Text('asset关键字'),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  elevation: 15,
                  onPressed: _onBtnTest1,
                ),
                RaisedButton(
                  child: Text('asset关键字'),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  elevation: 15,
                  onPressed: _onBtnTest1,
                ),
                RaisedButton(
                  child: Text('asset关键字'),
                  color: Colors.blueAccent,
                  textColor: Colors.white,
                  elevation: 15,
                  onPressed: _onBtnTest1,
                ),
              ],
            )),
          )
        ],
      ),
    );
  }

  void _onBtnTest1() {
    print("starting");
    int dem = 10;
    assert(dem < 9);
    print("progressing");
  }

  void _onBtnTest2() {
    print("starting");
    //Numbers
    int dem = 101;
    var dem1 = 101;
    double dou = 10.1;
    var dou1 = 10.1;
    print(dem);
    print(dou);
    print(dem1);
    print(dou1);
    //Strings
    String str = "我是字符串类型";
    String str2 = '单引号字符串';
    print(str);
    print(str2);
    //Booleans
    bool bo = true; //编译时常量
    bool bof = false; //编译时常量
    print(bo);
    print(bof);
    //List
    List lis = new List();
    lis.add("1");
    lis.add("2");
    List lis2 = ["a", 2, "c"];
    List<int> lis3 = [1, 2, 3];
    var lis4 = [1, 2, 3];
    lis4[2] = 4;
    print(lis[0]);
    print(lis2[1]);
    print(lis3[2]);
    print(lis4[2]);
    //Maps
    print("progressing");
  }

  //dynamic动态类型
  void _onBtnTest3() {
    print("starting3");
    var a = 'dart'; //系统会自动判断类型，runtimeType
//    a ;
//    a = 3;会报错
    dynamic b = 20;
    b = 'dart20'; //不会报错
    print(a);
    print(b);

    //dynamic定义的会关闭类型检查
    var list = new List<dynamic>();
    list.add('dart1');
    list.add(2);
    list.add(true);
    print(list);

    print(a.runtimeType); //a是int类型
    print(b.runtimeType); //b是String类型
    print("progressing");
  }

  //同步生成器
  void _onBtnTest4() {
    print("starting4");
    var it = naturalsTo(10).iterator; //不会执行函数主题
    print("starting4-1");
    while (it.moveNext()) {
      print(it.current);
    }
    print("progressing");
  }

  Iterable<int> naturalsTo(n) sync* {
    print('begin');
    int k = 0;
    while (k < n) {
      print('yield返回之前的k：$k');
      yield k;
      k = k + 1;
    }

    print('end');
  }

  //异步生成器
  void _onBtnTest5() {
    print("starting5");

    asyncNaturalsTo(10).listen((v) {
      print("listener的数据是$v"); //最后执行
    });

    print("progressing");
  }

  Stream<int> asyncNaturalsTo(n) async* {
    print('begin');
    int k = 0;
    while (k < n) {
      yield k;
      k++;
    }
    print('end');
  }

//  await关键字必须在async函数内部使用
//  调用async函数必须使用await关键字
//  await 标记的返回是一个Future对象
  //await和sync
  Future<String> _onBtnTest6() async {
    print("starting6");
    String value = await _getWaitValue(); //等待，执行完成才会走下面的打印
    print(value);
    print("end6");
    return value;
  }

  Future<String> _getWaitValue() {
    return new Future<String>.delayed(new Duration(seconds: 5), () {
      return 'this value';
    });
  }

  _onBtnTest7() {
    print("starting7");
    Future.microtask(() => print('在microtask queue 运行的future')); //微任务队列，先执行
    scheduleMicrotask(() => print('在microtask queue 运行的future2'));

    scheduleMicrotask(() => print('microtask #1 of 2'));

    new Future.delayed(
        new Duration(seconds: 1), () => print('future #1 (delayed)'));
    new Future(() => print('future #2 of 3'));
    new Future(() => print('future #3 of 3'));

    scheduleMicrotask(() => print('microtask #2 of 2'));

    print("end7");
  }

  _onBtnTest8() {
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return CirclePage();
    }));
  }

  Future<String> _onBtnTest9() async {
    print("starting9");
    String value = await _getWaitValue(); //等待，执行完成才会走下面的打印
    print(value);
    print("end9");
    return value;
  }

  _onBtnTest10() {
    var p1 = new Logger("1");
    p1.log("2");

    var p2 = new Logger('22');
    p2.log('3');
    var p3 = new Logger('1'); // 相同对象直接访问缓存
  }

  _onBtnTest11() {
    C c = C();
    c.fun();
  }
}
