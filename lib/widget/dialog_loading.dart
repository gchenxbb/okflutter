import 'package:flutter/material.dart';

/**
 * 加载框
 */
class LoadingDialog extends Dialog {
  final bool cancelOnTouchOutside;

  LoadingDialog(this.cancelOnTouchOutside) : super();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: new Material(
          color: Colors.transparent,
          child: Stack(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  if (cancelOnTouchOutside) {
                    Navigator.pop(context);
                  }
                },
              ),
              _dialog(),
            ],
          )),
    );
  }

  Widget _dialog() {
    return new Center(
      child: new SizedBox(
        width: 120,
        height: 120,
        child: new Container(
          decoration: ShapeDecoration(
              color: Color(0xffffffff),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(8)))),
          child: _buildAnimContent(),
        ),
      ),
    );
  }

  Widget _buildAnimContent() {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        new CircularProgressIndicator(),
        new Padding(
          padding: const EdgeInsets.only(top: 20),
          child: new Text(
            "加载中...",
            style: new TextStyle(fontSize: 16),
          ),
        )
      ],
    );
  }
}

class DialogRouter extends PageRouteBuilder {
  final Widget page;

  DialogRouter(this.page)
      : super(
          opaque: false,
          barrierColor: Colors.black54,
          pageBuilder: (context, animation, secondaryAnimation) => page,
        );
}
