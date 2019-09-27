import 'package:equatable/equatable.dart';

import 'package:flutternews/src/models/models.dart';

abstract class CategoriesState extends Equatable {
  CategoriesState([List props = const []]) : super(props);
}

class CategoriesUninitialized extends CategoriesState {
  @override
  String toString() => 'CategoryUninitialized';
}

class CategoriesError extends CategoriesState {
  @override
  String toString() => 'CategoryError';
}

class CategoriesLoaded extends CategoriesState {
  final List<Categories> categories;
  final bool hasReachedMax;
  final int page;
  final int perPage;

  CategoriesLoaded({
    this.categories,
    this.hasReachedMax,
    this.page,
    this.perPage
  }) : super([categories, hasReachedMax,page,perPage]);

 CategoriesLoaded copyWith({
    List<Categories> posts,
    bool hasReachedMax,
    int page,
    int perPage,
  }) {
    return CategoriesLoaded(
      categories: posts ?? this.categories,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      page: page ?? this.page,
      perPage: perPage ?? this.perPage
    );
  }

  @override
  String toString() =>
      'PostLoaded { posts: ${categories.length}, hasReachedMax: $hasReachedMax }';
}
