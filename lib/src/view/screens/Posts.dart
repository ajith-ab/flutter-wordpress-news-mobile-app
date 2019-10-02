import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutternews/src/bloc/bloc.dart';
import 'package:flutternews/src/view/widgets/BottomLoader.dart';
import 'package:flutternews/src/view/widgets/post_image_slide.dart';
import 'package:flutternews/src/view/widgets/post_list.dart';
import 'package:flutternews/src/models/models.dart';

class Posts extends StatefulWidget {
  final ScrollController _scrollController;
  Posts(this._scrollController);
  @override
  _PostState createState() => _PostState(_scrollController);
}

class _PostState extends State<Posts> {
  ScrollController _scrollController;
  _PostState(this._scrollController);
  bool isLoading = true;
  PostBloc _postBloc;
  final List<Post> slidePosts = [];
  String message = '';

  @override
  void initState() {
    super.initState();
    _postBloc = BlocProvider.of<PostBloc>(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostBloc, PostState>(
      builder: (context, state) {
        if (state is PostError) {
          return Center(
            child: Text('failed to fetch posts'),
          );
        }
        if (state is PostLoaded) {
          if (state.posts.isEmpty) {
            return Center(
              child: Text('no posts'),
            );
          }

          return MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: NotificationListener<ScrollNotification>(
              onNotification: (scrollNotification) {
                if (scrollNotification is ScrollEndNotification) {
                  if (_scrollController.position.pixels ==
                          _scrollController.position.maxScrollExtent &&
                      isLoading) {
                    setState(() {
                      isLoading = false;
                    });
                    _onScroll();
                  } else {
                    setState(() {
                      isLoading = true;
                    });
                  }
                }
                return true;
              },
              child: ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  if (index >= state.posts.length) {
                    return BottomLoader();
                  } else if (index <= 4) {
                    if (slidePosts.length <= 4) {
                      slidePosts.add(state.posts[index]);
                    }
                    if (index == 4) {
                      // print(slidePosts[index].image);
                      return PostSlides(slidePosts: slidePosts);
                    }
                    return Row();
                  } else {
                    return PostWidget(post: state.posts[index]);
                  }
                },
                // controller: _scrollController,
                itemCount: state.hasReachedMax
                    ? state.posts.length
                    : state.posts.length + 1,
              ),
            ),
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onScroll() {
    _postBloc.dispatch(Fetch());
  }
}
