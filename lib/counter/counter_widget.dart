import 'package:flutter/material.dart';
import 'package:flutterchannel/counter/counter_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final CounterBloc counterBloc = BlocProvider.of<CounterBloc>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Counter')),
      body: BlocBuilder<CounterEvent, int>(
        bloc: counterBloc,
        builder: (context, count) {
          return Center(
              child: Column(
            children: <Widget>[
              Text(
                '$count',
                style: TextStyle(fontSize: 24.0, color: Colors.blue),
              ),
            ],
          ));
        },
      ),
      floatingActionButton: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FlatButton(
                onPressed: () {
                  counterBloc.dispatch(CounterEvent.increment);
                },
                child: Icon(Icons.add)),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 5.0),
            child: FlatButton(
                onPressed: () {
                  counterBloc.dispatch(CounterEvent.decrement);
                },
                child: Icon(Icons.remove)),
          )
        ],
      ),
    );
  }
}
