import 'package:flutter/material.dart';

//底部导航栏
class BottomNavigation extends StatefulWidget {
  final callback;

  BottomNavigation(this.callback);

  @override
  _BottomNavigationState createState() => new _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _currentIndex = 0;
  BottomNavigationBarType _type = BottomNavigationBarType.fixed;

  @override
  Widget build(BuildContext context) {
    return new BottomNavigationBar(
      items: [
        new BottomNavigationBarItem(
            icon: const Icon(Icons.add),
            title: Text("Tab1"),
            backgroundColor: Colors.blue),
        new BottomNavigationBarItem(
            icon: const Icon(Icons.map),
            title: Text("Tab2"),
            backgroundColor: Colors.blue[300]),
        new BottomNavigationBarItem(
            icon: const Icon(Icons.my_location),
            title: Text("Tab3"),
            backgroundColor: Colors.blue[600]),
        new BottomNavigationBarItem(
            icon: const Icon(Icons.message),
            title: Text("Tab4"),
            backgroundColor: Colors.blue[800]),
      ],
      currentIndex: _currentIndex,
      type: _type,
      onTap: (int index) {
        setState(() {
          _currentIndex = index;
          widget.callback(index);
        });
      },
    );
  }
}
