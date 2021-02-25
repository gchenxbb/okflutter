import 'dart:async';
import 'package:bloc/bloc.dart';
import './bloc.dart';
import 'package:http/http.dart' as http;
import 'package:flutterko/list/model.dart';
import 'dart:convert';

class PostBlocBloc extends Bloc<PostBlocEvent, PostBlocState> {
  @override
  PostBlocState get initialState => InitialPostBlocState();

  final http.Client httpClient;

  PostBlocBloc({this.httpClient});

  @override
  Stream<PostBlocState> mapEventToState(
    PostBlocEvent event,
  ) async* {
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is InitialPostBlocState) {
          final posts = await _fetchPost(0, 20);
          yield PostLoaded(posts: posts, hasReachedMax: false);
          return;
        }
        if (currentState is PostLoaded) {
          final post =
              await _fetchPost((currentState as PostLoaded).posts.length, 20);
          yield post.isEmpty
              ? (currentState as PostLoaded).coypWith(hasReachedMax: true)
              : PostLoaded(
                  posts: (currentState as PostLoaded).posts + post,
                  hasReachedMax: false);
        }
      } catch (_) {
        yield PostError();
      }
    }
  }

  bool _hasReachedMax(PostBlocState state) =>
      state is PostLoaded && state.hasReachedMax;

  Future<List<Post>> _fetchPost(int startIndex, int limit) async {
    final response = await httpClient.get('https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit');
    if (response.statusCode == 200) {
      print(response.body);
      final data = json.decode(response.body) as List;
      return data.map((rawPost) {
        return Post(
          id: rawPost['id'],
          title: rawPost['title'],
          body: rawPost['body'],
        );
      }).toList();
    } else {
      throw Exception('error fetching posts');
    }
  }
}
