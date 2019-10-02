import 'package:flutter/material.dart';

class BottomTabs extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Theme(
      data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
          primaryColor: Colors.black,
          textTheme: Theme.of(context)
              .textTheme
              .copyWith(caption: new TextStyle(color: Colors.grey))),
      child: new BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('Home'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.play_arrow),
            title: Text('Video'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark),
            title: Text('Bookmarks'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            title: Text('Settings'),
          ),
        ],
      ),
    );
  }
}
