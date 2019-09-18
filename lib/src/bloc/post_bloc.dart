import 'dart:async';
import 'dart:convert';

import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:flutternews/src/bloc/bloc.dart';
import 'package:flutternews/src/models/models.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final http.Client httpClient;

  PostBloc({@required this.httpClient});

  @override
  Stream<PostState> transformEvents(
    Stream<PostEvent> events,
    Stream<PostState> Function(PostEvent event) next,
  ) {
    return super.transformEvents(
      (events as Observable<PostEvent>).debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  get initialState => PostUninitialized();

  @override
  Stream<PostState> mapEventToState(PostEvent event) async* {
    if (event is Fetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is PostUninitialized) {
          final page = 4;
          final perPage = 10;
          final posts = await _fetchPosts(perPage, page);
          
          yield PostLoaded(posts: posts, hasReachedMax: false,page:page,perPage: perPage);
          return;
        }
        if (currentState is PostLoaded) {
          final page = (currentState as PostLoaded).page + 1;
          final perPage = (currentState as PostLoaded).perPage;
          final posts =
              await _fetchPosts(perPage, page);
          yield posts.isEmpty
              ? (currentState as PostLoaded).copyWith(hasReachedMax: true)
              : PostLoaded(
                  posts: (currentState as PostLoaded).posts + posts,
                  hasReachedMax: false,
                  page: page,
                  perPage: perPage
                );
        }
      } catch (_) {
        yield PostError();
      }
    }
  }

  bool _hasReachedMax(PostState state) =>
      state is PostLoaded && state.hasReachedMax;

  Future<List<Post>> _fetchPosts(int perPage, int page) async {
    final response = await httpClient.get('https://keralamirror.news/wp-json/wp/v2/posts?_embed&per_page=$perPage&page=$page');
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((rawPost) {
        String image = '';
        try {
          if(rawPost["_embedded"]["wp:featuredmedia"] != null && rawPost["_embedded"]["wp:featuredmedia"][0] != null && rawPost["_embedded"]["wp:featuredmedia"][0]["source_url"] != null){
              image = rawPost["_embedded"]["wp:featuredmedia"][0]["source_url"];
          }else{
            image = 'https://picsum.photos/250?image=9';
          }
        } catch (e) {
          print("exception"+ e.toString());
          image = 'https://picsum.photos/250?image=9';
        }
        print(rawPost["_embedded"]["wp:featuredmedia"][0]["source_url"]);
        return Post(
          id: rawPost['id'],
          title: rawPost['title']['rendered'],
          body: rawPost['content']['rendered'],
          image: image
        );
      }).toList();
    } else {
      throw Exception('error fetching posts');
    }
  }
}
