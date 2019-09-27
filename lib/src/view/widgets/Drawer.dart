import 'package:flutter/material.dart';

class MainDrawer extends StatelessWidget {
  @override
  Widget build (BuildContext ctxt) {
    return new Drawer(
        child: new ListView(
          children: <Widget>[
            new DrawerHeader(
              child: new Text("DRAWER HEADER.."),
              decoration: new BoxDecoration(
                  color: Colors.red
              ),
            ),
            new ListTile(
              title: new Text("Item => 1"),
              onTap: () {
               
              },
            ),
            new ListTile(
              title: new Text("Item => 2"),
              onTap: () {
               
              },
            ),
          ],
        )
    );
  }
}