import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int id;
  final String title;
  final String body;
  final String image;

  Post({this.id, this.title, this.body, this.image}) : super([id, title, body, image]);

  @override
  String toString() => 'Post { id: $id }';
}
