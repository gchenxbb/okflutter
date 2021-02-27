import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/**
 * 记录 counter 到本地
 */
class SharedPreferencesDemo extends StatefulWidget {
  final String title;

  SharedPreferencesDemo({Key key, this.title}) : super(key: key);

  @override
  SharedPreferencesDemoState createState() => SharedPreferencesDemoState();
}

class SharedPreferencesDemoState extends State<SharedPreferencesDemo> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<int> _counter;

  Future<void> _incrementCounter() async {
    final SharedPreferences prefs = await _prefs;
    final int counter = (prefs.getInt('counter') ?? 0) + 1;
    setState(() {
      _counter = prefs.setInt("counter", counter).then((bool success) {
        return counter;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("SharedPreferences Demo"),
      ),
      body: Center(
        child: FutureBuilder<int>(
          future: _counter,
          builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.waiting:
                return const CircularProgressIndicator();
              default:
                if (snapshot.hasError) {
                  return Text('Error:${snapshot.error}');
                } else {
                  return Text(
                      'Button tapped ${snapshot.data} time${snapshot.data == 1 ? '' : 's'}.\n'
                      'this should persist across restart.');
                }
            }
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _counter = _prefs.then((SharedPreferences prefs) {
      int counter = prefs.getInt('counter') ?? 0;
      print('counter:$counter');
      return counter;
    });
  }
}
