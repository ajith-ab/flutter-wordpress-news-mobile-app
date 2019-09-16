import 'package:flutter/material.dart';
import 'package:flutternews/src/view/screens/Posts.dart';
import 'package:flutternews/src/view/widgets/Drawer.dart';
import 'package:flutternews/src/view/widgets/BottomTabs.dart';
import 'package:flutternews/src/view/widgets/SearchBar.dart';

class MainScreen extends StatefulWidget {
 const MainScreen({ Key key }) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with SingleTickerProviderStateMixin {
List<String> categories = ["a", "b", "c","a", "b", "c"];

final List<Tab> myTabsf = <Tab>[
    Tab(text: 'LEFT'),
    Tab(text: 'RIGHT'),
  ];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: categories.length, vsync: this);
  }

   @override
 void dispose() {
   _tabController.dispose();
   super.dispose();
 }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () => showSearch(
                context: context,
                delegate: SearchBarz(),
              ),
            ),
            IconButton(
              icon: Icon(Icons.apps),
              onPressed: () => showSearch(
                context: context,
                delegate: SearchBarz(),
              ),
            ),
            IconButton(
              icon: Icon(Icons.notifications),
              onPressed: () => showSearch(
                context: context,
                delegate: SearchBarz(),
              ),
            ),
          ],
          bottom:TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: List<Widget>.generate(categories.length, (int index){
                  return new Tab(text: 'LEFT'+index.toString());

                }),
        ),
          title: Text('Flutter News'),
        ),
        body: TabBarView(
        controller: _tabController,
        children: List<Widget>.generate(categories.length, (int index){
                print(categories[0]);
                return new Post();

             }),
      ),
        drawer: MainDrawer(),
        bottomNavigationBar: BottomTabs(),
      ),
    );
  }
}