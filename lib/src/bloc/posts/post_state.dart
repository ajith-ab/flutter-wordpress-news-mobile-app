import 'package:equatable/equatable.dart';

import 'package:flutternews/src/models/models.dart';

abstract class PostState extends Equatable {
  PostState([List props = const []]) : super(props);
}

class PostUninitialized extends PostState {
  @override
  String toString() => 'PostUninitialized';
}

class PostError extends PostState {
  @override
  String toString() => 'PostError';
}

class PostLoaded extends PostState {
  final List<Post> posts;
  final bool hasReachedMax;
  final int page;
  final int perPage;

  PostLoaded({
    this.posts,
    this.hasReachedMax,
    this.page,
    this.perPage
  }) : super([posts, hasReachedMax,page,perPage]);

  PostLoaded copyWith({
    List<Post> posts,
    bool hasReachedMax,
    int page,
    int perPage,
  }) {
    return PostLoaded(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage
    );
  }

  @override
  String toString() =>
      'PostLoaded { posts: ${posts.length}, hasReachedMax: $hasReachedMax }';
}
