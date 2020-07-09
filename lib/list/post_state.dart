import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:flutterchannel/list/model.dart';

@immutable
abstract class PostBlocState extends Equatable {
  PostBlocState([List props = const []]) : super(props);
}

class InitialPostBlocState extends PostBlocState {
  @override
  String toString() => 'InitialPostBlocState';
}

class PostError extends PostBlocState {
  @override
  String toString() => 'PostError';
}

class PostLoaded extends PostBlocState {
  final List<Post> posts;
  final bool hasReachedMax;

  PostLoaded({this.posts, this.hasReachedMax}) : super([posts, hasReachedMax]);

  PostLoaded coypWith({
    List<Post> posts,
    bool hasReachedMax,
  }) {
    return PostLoaded(
        posts: posts ?? this.posts,
        hasReachedMax: hasReachedMax ?? this.hasReachedMax);
  }

  @override
  String toString() =>
      'PostLoaded（posts:${posts.length},hasReachedMax:$hasReachedMax)';
}
