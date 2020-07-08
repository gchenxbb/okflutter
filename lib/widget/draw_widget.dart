import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              'chenx',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            accountEmail: Text('email'),
            //定义用户头像，CircleAvatar 指定成圆形
            currentAccountPicture: CircleAvatar(backgroundImage: null),
            decoration: BoxDecoration(
                color: Colors.deepOrangeAccent, //区域背景颜色
                image: DecorationImage(
                    image: NetworkImage('https://dwz.cn/N00Lpoj0'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                        Colors.blue[300].withOpacity(0.2), BlendMode.srcOver))),
          ),
          ListTile(
              leading: Icon(Icons.access_alarm,
                  color: Colors.redAccent, size: 16.0), //
              title: Text('第一列', textAlign: TextAlign.left),
              onTap: () => Navigator.pop(context)),
          ListTile(
              leading: Icon(Icons.access_alarm,
                  color: Colors.blueAccent, size: 16.0),
              title: Text('第二列', textAlign: TextAlign.left),
              onTap: () => Navigator.pop(context)),
          ListTile(
              leading: Icon(Icons.access_alarm,
                  color: Colors.blueAccent, size: 16.0),
              title: Text('第三列', textAlign: TextAlign.left),
              onTap: () => Navigator.pop(context))
        ],
      ),
    );
  }
}
