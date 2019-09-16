import 'package:flutter/material.dart';
import 'package:flutternews/src/models/models.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      // leading: Text(
      //   '${post.id}',
      //   style: TextStyle(fontSize: 10.0),
      // ),
      leading: new Image.network(
        'https://picsum.photos/250?image=9',
      ),
      title: Text(post.title),
      isThreeLine: true,
      subtitle: Text(post.body),
      dense: true,
    );
  }
}
