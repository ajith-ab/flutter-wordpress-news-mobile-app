import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutternews/src/models/models.dart';

List<Post>  imgList = [];

final Widget placeholder = Container(color: Colors.grey);
List<T> map<T>(List list, Function handler) {
  List<T> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(handler(i, list[i]));
  }

  return result;
}
class PostSlides extends StatefulWidget {
   List<Post> slidePosts;
   PostSlides({this.slidePosts}){
    imgList = this.slidePosts;
   }
  

  @override
  _PostSlidesState createState() => _PostSlidesState();
}

class _PostSlidesState extends State<PostSlides> {
  
List child = map<Widget>(
 imgList,
  (index, i) {
    return Container(
      margin: EdgeInsets.all(5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
        child: Stack(children: <Widget>[
          Image.network(imgList[index].image, fit: BoxFit.cover, width: 1000.0),
          Positioned(
            bottom: 0.0,
            left: 0.0,
            right: 0.0,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color.fromARGB(200, 0, 0, 0), Color.fromARGB(0, 0, 0, 0)],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
              padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Text(
                imgList[index].title,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  },
).toList();









  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CarouselSlider(
        items: child,
        autoPlay: true,
        enlargeCenterPage: true,
        aspectRatio: 2.0,
        onPageChanged: (index) {
          setState(() {
            _current = index;
          });
        },
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: map<Widget>(
          imgList,
          (index, url) {
            return Container(
              width: 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? Color.fromRGBO(0, 0, 0, 0.9)
                      : Color.fromRGBO(0, 0, 0, 0.4)),
            );
          },
        ),
      ),
    ]);
  }
}

