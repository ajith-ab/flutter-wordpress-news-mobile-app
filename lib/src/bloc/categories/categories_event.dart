import 'package:equatable/equatable.dart';

abstract class CategoriesEvent extends Equatable {}

class CategoriesFetch extends CategoriesEvent {
  @override
  String toString() => 'Fetch';
}
