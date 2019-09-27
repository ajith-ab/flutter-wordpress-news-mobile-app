import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutternews/src/bloc/bloc.dart';
import 'package:flutter_tags/tag.dart';

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  CategoriesBloc _categoriesBloc;
  bool _symmetry = false;

  @override
  void initState() {
    super.initState();
    _categoriesBloc = BlocProvider.of<CategoriesBloc>(context);

    _categoriesBloc.dispatch(CategoriesFetch());
  }

 
  double _fontSize = 14;


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CategoriesBloc, CategoriesState>(
        builder: (context, state) {
      if (state is CategoriesError) {
        return Center(
          child: Text('failed to fetch posts'),
        );
      }
      if (state is CategoriesLoaded) {
        if (state.categories.isEmpty) {
          return Center(
            child: Text('no Categories'),
          );
        }
        return SingleChildScrollView(
          child: Column(
            children: <Widget>[
              new Text("Categories"),
              new Tags(
                key: Key("1"),
                symmetry: _symmetry,
                columns: 3,
                verticalDirection: VerticalDirection.down,
                textDirection: TextDirection.ltr,
                heightHorizontalScroll: 60 * (_fontSize / 14),
                itemCount: state.categories.length,
                itemBuilder: (index) {
                  return ItemTags(
                    key: Key(index.toString()),
                    index: index,
                    title: state.categories[index].name,
                    pressEnabled: true,
                    activeColor: Colors.indigo[900],
                    singleItem: false,
                    splashColor: Colors.indigo[100],
                    combine: ItemTagsCombine.withTextBefore,
                    icon: ItemTagsIcon(
                      
                      icon:  Icons.done,
                      
                    ),
                    onRemoved: () {
                    
                    },
                    onPressed: (item) => {},
                  );
                },
              ),
            ],
          ),
        );
      }
      return Center(
        child: CircularProgressIndicator(),
      );
    });
  }
}
