import 'package:flutter/material.dart';

/// 动画demo
class AnimApp extends StatefulWidget {
  AnimApp({Key key, this.title}) : super(key: key);
  final String title;

  _AnimAppState createState() => _AnimAppState();
}

class _AnimAppState extends State<AnimApp> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 1), vsync: this);

    // animation = Tween<double>(begin: 0, end: 100).animate(controller)
    animation = CurvedAnimation(parent: controller, curve: Curves.easeIn)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) controller.forward();
      })
      ..addStatusListener((status) => print("$status"));
    // ..addListener(() {
    //   setState(() {});
    // });
    controller.forward();
  }

  @override
  // Widget build(BuildContext context) => AnimLogo(animation: animation);
  Widget build(BuildContext context) =>
      GrowTransition(child: LogoWidget(), animation: animation);

  // {
  //   return Center(
  //     child: Container(
  //       margin: EdgeInsets.symmetric(vertical: 10),
  //       height: animation.value,
  //       width: animation.value,
  //       child: FlutterLogo(),
  //     ),
  //   );
  // }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

class LogoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: FlutterLogo(),
      );
}

class GrowTransition extends StatelessWidget {
  GrowTransition({this.child, this.animation});

  final Widget child;
  final Animation<double> animation;

  static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
  static final _sizeTween = Tween<double>(begin: 0, end: 100);

  @override
  Widget build(BuildContext context) => Material(
        child: Center(
          child: AnimatedBuilder(
            animation: animation,
            builder: (context, child) => Opacity(
                opacity: _opacityTween.evaluate(animation),
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  height: _sizeTween.evaluate(animation),
                  width: _sizeTween.evaluate(animation),
                  child: FlutterLogo(),
                )),
            child: child,
          ),
        ),
      );
}

/**
 * AnimatedWidget
 */
class AnimLogo extends AnimatedWidget {
  AnimLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
  static final _sizeTween = Tween<double>(begin: 0, end: 100);

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Opacity(
          opacity: _opacityTween.evaluate(animation),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 10),
            height: _sizeTween.evaluate(animation),
            width: _sizeTween.evaluate(animation),
            child: FlutterLogo(),
          )),
    );
  }
}
