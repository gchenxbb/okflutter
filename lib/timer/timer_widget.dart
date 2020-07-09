import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterchannel/timer/bloc.dart';
import 'package:flutterchannel/timer/action_widget.dart';

class Timer extends StatelessWidget {
  static const TextStyle timerTextStyle = TextStyle(
    fontSize: 60,
    fontWeight: FontWeight.bold,
  );

  @override
  Widget build(BuildContext context) {
    final TimerBloc timerBloc = BlocProvider.of<TimerBloc>(context);
    timerBloc.dispatch(Start(duration: timerBloc.currentState.duration));
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Timer'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(vertical: 100.0),
            child: Center(
              child: BlocBuilder<TimerEvent, TimerState>(
                  bloc: timerBloc,
                  builder: (context, state) {
                    final String minuesSter = ((state.duration / 60) % 60)
                        .floor()
                        .toString()
                        .padLeft(2, '0');
                    final String secondsStr = (state.duration % 60)
                        .floor()
                        .toString()
                        .padLeft(2, '0');
                    return Text(
                      '$minuesSter:$secondsStr',
                      style: Timer.timerTextStyle,
                    );
                  }),
            ),
          ),
          BlocBuilder<TimerEvent, TimerState>(
            bloc: timerBloc,
            condition: (previousState, currentState) =>
                currentState.runtimeType != previousState.runtimeType,
            builder: (context, state) => ActionWidget(),
          )
        ],
      ),
    );
  }
}
