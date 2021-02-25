/*
 * Created by chenguang491 on 2019/8/21
 * Copyright (c) 2019. PING AN HEALTH CLOUD COMPANY LIMITED.
 * ALL rights reserved.
 */
import 'package:flutter/material.dart';
import 'package:flutterko/timer/timer_widget.dart';
import 'package:flutterko/timer/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterko/timer/ticker.dart';

class TimerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: BlocProvider<TimerBloc>(
        builder: (context) => TimerBloc(ticker: Ticker()),
        child: Timer(),
      ),
    );
  }
}
