import 'package:flutterko/list/bloc.dart';
import 'package:flutterko/list/post_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;

class ListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Infinte Scroll',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Posts'),
        ),
        body: BlocProvider(
          builder: (context) =>
              PostBlocBloc(httpClient: http.Client())..dispatch(Fetch()),
          child: ListWidget(),
        ),
      ),
    );
  }
}
