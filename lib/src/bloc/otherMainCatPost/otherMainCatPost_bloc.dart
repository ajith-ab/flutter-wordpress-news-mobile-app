import 'dart:async';
import 'package:http/http.dart' as http;

const baseUrl = "https://keralamirror.news/wp-json/wp/v2/posts";

class API {
  static Future getUsers(int perPage, int page) async {
    var url = 'https://keralamirror.news/wp-json/wp/v2/posts?_embed&per_page=$perPage&page=$page';
    return await http.get(url);
  }
}