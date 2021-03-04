import 'package:http/http.dart' as http;


class FutApi {
  ///下面代码验证一下Future和await等
  void _incrementCounter2() {
//    print("_incrementCounter:${new DateTime.now()}");
//    _loadUserInfo();
//    print("_incrementCounter:${new DateTime.now()}");
    print('_incrementCounter——begin');
    //funcD();
    funcA();
//    Future st = funcB();
//    st.then((c) => funC(c));
    print('_incrementCounter——end');
  }

  /// 模拟异步加载用户信息
  Future _getUserInfo() async {
    await new Future.delayed(new Duration(milliseconds: 3000));
    return "我是用户，${new DateTime.now()}";
  }

  Future _loadUserInfo() async {
    print("_loadUserInfo:${new DateTime.now()}");
    print(await _getUserInfo());
    print("_loadUserInfo:${new DateTime.now()}");
  }

  Future funcD() async {
    print('funcD1');
    await http.get(Uri.encodeFull("https://www.baidu.com"),
        headers: {"Accept": "application/json"});
    print('funcD2');
  }

  Future funcA() async {
    print('funcA1');
    await new Future.delayed(new Duration(milliseconds: 5000));
    print('funcA2');
    return 'funcA';
  }

  funcB() async {
    return await funcA();
  }

  void funC(String c) {
    print('funC,$c');
  }
}
