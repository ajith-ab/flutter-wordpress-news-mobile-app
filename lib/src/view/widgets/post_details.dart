import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutternews/src/models/models.dart';
import 'package:flutternews/src/view/widgets/loader.dart';

class PostDetails extends StatelessWidget {
  final Post post;

  const PostDetails({Key key, @required this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              expandedHeight: 280.0,
              pinned: false,
              elevation: 0.0,
              flexibleSpace: new FlexibleSpaceBar(
                background: new CachedNetworkImage(
                        imageUrl: post.image,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Skeleton(height: 200,width: 200,),
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.error),
                      ),
              ),
            ),
            new SliverPadding(
              padding: new EdgeInsets.all(16.0),
              sliver: new SliverList(
                delegate: new SliverChildListDelegate([]),
              ),
            ),
          ];
        },
        body: Center(
          child: Text("Sample text"),
        ),
      ),
    );
  }

  void backToMainPage(context) {
    Navigator.pop(context);
  }
}
