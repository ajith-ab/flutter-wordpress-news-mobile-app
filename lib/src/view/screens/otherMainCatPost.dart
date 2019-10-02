import 'dart:convert';
import 'package:flutternews/src/bloc/otherMainCatPost/otherMainCatPost_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutternews/src/models/post.dart';
import 'package:flutternews/src/view/widgets/BottomLoader.dart';
import 'package:flutternews/src/view/widgets/post_list.dart';

class OtherMainCatPost extends StatefulWidget {
  final ScrollController _scrollController;
  OtherMainCatPost(this._scrollController);
  @override
  _OtherMainCatPostState createState() => _OtherMainCatPostState(this._scrollController);
}

class _OtherMainCatPostState extends State<OtherMainCatPost> with AutomaticKeepAliveClientMixin {
     ScrollController _scrollController;
  _OtherMainCatPostState(this._scrollController);


  var posts = new List<Post>();
  bool isLoading = true;
  final bool hasReachedMax = false;
  int page = 1;
  final int perPage = 15;
  bool infiniteLoading = true;
  int loadingCount = 1;

 @override
  initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _getUsers();
  }
  @override
  dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
 Widget build(BuildContext context) {
    if (!isLoading) {
      return MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollEndNotification) {
                  if (_scrollController.position.pixels ==
                          _scrollController.position.maxScrollExtent &&
                      loadingCount == 1) {
                    setState(() {
                      infiniteLoading = false;
                      loadingCount = loadingCount + 1;
                    });
                    _onScroll();
                  }
                }
                return true;
              },
              child: ListView.builder(
           shrinkWrap: true, // todo comment this out and check the result
           physics: ClampingScrollPhysics(), 
            itemBuilder: (BuildContext context, int index) {
              return index >= posts.length
                  ? BottomLoader()
                  : PostWidget(post: posts[index]);
            },
            itemCount: hasReachedMax
                ? posts.length
                : posts.length + 1,
           // controller: _scrollController,
          ),
          ),
      );
    } else {
      return Center(
          child: CircularProgressIndicator()
        );
    }
  }
  
  @override
  bool get wantKeepAlive => true;

  _getUsers()  {
    API.getUsers(perPage , this.page).then((response) async{
      setState(() {
        final data = json.decode(response.body) as List;
        posts = posts + data.map((rawPost){
        String image =  Post.imageUrl(rawPost);   
          return Post(
          id: rawPost['id'],
          title: rawPost['title']['rendered'],
          body: rawPost['content']['rendered'],
          image: image
        );
        }).toList();
        isLoading = false;
        page = page + 1;
        loadingCount = 1;
      });
    });
  }

    void _onScroll(){
      if(loadingCount == 2){
        _getUsers();
      } 
    
  }
}