import 'package:flutter/material.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutternews/widgets/MainBody.dart';
import 'package:flutternews/widgets/Drawer.dart';
import 'package:flutternews/widgets/BottomTabs.dart';
import 'package:flutternews/redux/AppState.dart';
import 'package:flutternews/redux/Store.dart';

void main() => runApp(MyApp(store: store));

class MyApp extends StatelessWidget {
  final Store<AppState> store;

  MyApp({Key key, this.store}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StoreProvider<AppState>(
        store: store,
        child: MaterialApp(
            title: 'Redux Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.blue, primaryColor: Colors.indigo[900]),
            home: Scaffold(
              appBar: AppBar(
                title: Text('Flutter News'),
              ),
              body: MainBody(),
              drawer: MainDrawer(),
              bottomNavigationBar: BottomTabs(),
            )
            )
            );
  }
}
