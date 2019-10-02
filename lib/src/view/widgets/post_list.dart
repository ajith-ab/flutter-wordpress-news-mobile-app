import 'package:flutter/material.dart';
import 'package:flutternews/src/models/models.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutternews/src/view/widgets/loader.dart';
import 'package:flutternews/src/view/widgets/post_details.dart';

class PostWidget extends StatelessWidget {
  final Post post;

  const PostWidget({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Padding(
          padding: const EdgeInsets.symmetric(vertical: 5.0),
          child: new GestureDetector(
            onTap: () {
              navigateToSubPage(context, post);
            },
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 4),
                    child: ClipRRect(
                      borderRadius: new BorderRadius.circular(4.0),
                      child:CachedNetworkImage(
                        imageUrl: post.image,
                        placeholder: (context, url) => Image.asset('assets/images/loader.gif'),
                        errorWidget: (context, url, error) =>
                            new Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(5.0, 0.0, 0.0, 0.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          post.title,
                          style: new TextStyle(
                              fontSize: 15.0, fontWeight: FontWeight.bold),
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 2.0)),
                        Text(
                          "10/2/2019",
                          style: const TextStyle(fontSize: 10.0),
                        ),
                        const Padding(
                            padding: EdgeInsets.symmetric(vertical: 1.0)),
                        Text(
                          'Sports',
                          style: const TextStyle(fontSize: 10.0),
                        ),
                      ],
                    ),
                  ),
                ),
                const Icon(
                  Icons.more_vert,
                  size: 20.0,
                ),
              ],
            ),
          )),
      Divider()
    ]);
  }

  Future navigateToSubPage(context, post) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => PostDetails(post: post)));
  }
}
