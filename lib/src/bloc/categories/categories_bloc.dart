import 'dart:async';
import 'dart:convert';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:bloc/bloc.dart';
import 'package:flutternews/src/bloc/bloc.dart';
import 'package:flutternews/src/models/models.dart';

class CategoriesBloc extends Bloc<CategoriesEvent, CategoriesState> {
  final http.Client httpClient;

  CategoriesBloc({@required this.httpClient});

  @override
  Stream<CategoriesState> transformEvents(
    Stream<CategoriesEvent> events,
    Stream<CategoriesState> Function(CategoriesEvent event) next,
  ) {
    return super.transformEvents(
      (events as Observable<CategoriesEvent>).debounceTime(
        Duration(milliseconds: 500),
      ),
      next,
    );
  }

  @override
  get initialState => CategoriesUninitialized();

  @override
  Stream<CategoriesState> mapEventToState(CategoriesEvent event) async* {
    if (event is CategoriesFetch && !_hasReachedMax(currentState)) {
      try {
        if (currentState is CategoriesUninitialized) {
          final page = 1;
          final perPage = 100;
          final categories = await _fetchPosts(perPage, page);
          yield CategoriesLoaded(categories: categories, hasReachedMax: false,page:page,perPage: perPage);
          return;
        }
        if (currentState is CategoriesLoaded) {
          final page = (currentState as CategoriesLoaded).page + 1;
          final perPage = (currentState as CategoriesLoaded).perPage;
          final categories =
              await _fetchPosts(perPage, page);
          yield categories.isEmpty
              ? (currentState as CategoriesLoaded).copyWith(hasReachedMax: true)
              : CategoriesLoaded(
                  categories: (currentState as CategoriesLoaded).categories + categories,
                  hasReachedMax: false,
                  page: page,
                  perPage: perPage
                );
        }
      } catch (_) {
        yield CategoriesError();
      }
    }
  }

  bool _hasReachedMax(CategoriesState state) =>
      state is CategoriesLoaded && state.hasReachedMax;

  Future<List<Categories>> _fetchPosts(int perPage, int page) async {
    final response = await httpClient.get('https://keralamirror.news/wp-json/wp/v2/categories?per_page=$perPage&page=$page&order=desc&orderby=count');
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as List;
      return data.map((rawPost) {
        return Categories(
          id: rawPost['id'],
          name: rawPost['name'],
          count: rawPost['count'],
          link: rawPost['link']
        );
      }).toList();
    } else {
      throw Exception('error fetching Categories');
    }
  }
}