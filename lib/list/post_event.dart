import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
abstract class PostBlocEvent extends Equatable {
  PostBlocEvent([List props = const []]) : super(props);
}

class Fetch extends PostBlocEvent {
  @override
  String toString() => 'Fetch';
}
