import 'package:equatable/equatable.dart';

class Categories extends Equatable {
  final int id;
  final String name;
  final int count;
  final String link;

  Categories({this.id,this.name,this.count,this.link}): super([id,name,count,link]);
}