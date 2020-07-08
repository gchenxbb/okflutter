import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SecondPageState createState() => _SecondPageState();
}

class _SecondPageState extends State<MyHomePage> {
  static const platform_battery =
      const MethodChannel('com.pac.framework.plugins/battery'); //电量
  static const platform_toast =
      const MethodChannel('com.pac.framework.plugins/toast'); //Toast弹窗
  static const platform_battery_event =
      const EventChannel('com.pac.framework.plugins/battery_event'); //电量事件
  static const _platform_string = const MethodChannel(
      "com.pac.framework.plugins/dart_string"); //Dart层接收原生string

  String _batteryLevel = 'Unknown battery level.';
  String _receivedMsg = "Received message ";

  _SecondPageState() {
    _platform_string.setMethodCallHandler((handler) {
      switch (handler.method) {
        case "getDartString":
          var argument = handler.arguments;
          print("arguments:$argument");
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RaisedButton(
              child: Text("从原生获取电量"),
              onPressed: _getBatteryLevel,
            ),
            RaisedButton(
              child: Text("调用原生弹出Toast"),
              onPressed: showToast,
            ),
            Text(
              '$_batteryLevel',
              style: new TextStyle(
                fontSize: 15,
              ),
            ),
            Text(
              '$_receivedMsg',
              style: new TextStyle(
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future _getBatteryLevel() async {
    String batteryLevel;
    try {
      final int result = await platform_battery.invokeMethod('getBatteryLevel');
      batteryLevel = 'Battery level at $result % .';
    } on PlatformException catch (e) {
      batteryLevel = "Failed to get battery level: '${e.message}'.";
    }

    setState(() {
      _batteryLevel = batteryLevel;
    });
  }

  showToast() {
    var sendMap = <String, dynamic>{
      'message': 'show message one!',
    };

    platform_toast.invokeMethod('showToast', sendMap);
//    platform_toast.invokeMethod('showToast', {'message': 'show message two！'});
  }

  @override
  void initState() {
    super.initState();
    platform_battery_event
        .receiveBroadcastStream()
        .listen(_onEvent, onError: _onError);
  }

  void _onEvent(Object event) {
    setState(() {
      _receivedMsg = "Received message : $event";
    });
  }

  void _onError(Object error) {
    setState(() {
      PlatformException exception = error;
      _receivedMsg = exception?.message ?? 'Received message error!';
    });
  }
}
