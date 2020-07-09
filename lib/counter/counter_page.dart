import 'package:flutter/material.dart';
import 'package:flutterchannel/counter/counter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterchannel/counter/counter_widget.dart';

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
//      title: 'Flutter Demo',
      home: BlocProvider<CounterBloc>(
        builder: (context) => CounterBloc(),
        child: Counter(),
      ),
    );
  }
}