import 'package:flutter/material.dart';
import 'package:flutternews/src/models/models.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: new ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: 64,
          minHeight: 200,
          maxWidth: 64,
          maxHeight: 300,
        ),
        child: CachedNetworkImage(
          imageUrl: post.image,
          placeholder: (context, url) => new CircularProgressIndicator(),
          errorWidget: (context, url, error) => new Icon(Icons.error),
        ),
      ),
      title: Text(
        post.title,
        style: new TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
      ),
      // isThreeLine: true,
      // subtitle: Text(post.body),
      dense: true,
    );
  }
}
