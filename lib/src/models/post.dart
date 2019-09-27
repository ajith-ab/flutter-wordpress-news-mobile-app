
import 'package:equatable/equatable.dart';

class Post extends Equatable {
  final int id;
  final String title;
  final String body;
  final String image;

  Post({this.id, this.title, this.body, this.image}) : super([id, title, body, image]);

  @override
  String toString() => 'Post { id: $id }';

 static imageUrl(rawPost)  {
     String image = 'https://picsum.photos/250?image=9';
        try {
          if(rawPost["_embedded"]["wp:featuredmedia"] != null && rawPost["_embedded"]["wp:featuredmedia"][0] != null && rawPost["_embedded"]["wp:featuredmedia"][0]["source_url"] != null && 
          rawPost["_embedded"]["wp:featuredmedia"][0]["media_details"] != null && rawPost["_embedded"]["wp:featuredmedia"][0]["media_details"]["sizes"]["thumbnail"] != null &&
          rawPost["_embedded"]["wp:featuredmedia"][0]["media_details"]["sizes"]["thumbnail"]["source_url"] != null){
            
              image = rawPost["_embedded"]["wp:featuredmedia"][0]["media_details"]["sizes"]["thumbnail"]["source_url"];
          }else{
            image = 'https://picsum.photos/250?image=9';
          }
        } catch (e) {
          image = 'https://picsum.photos/250?image=9';
        }
        return image;
  }



}
