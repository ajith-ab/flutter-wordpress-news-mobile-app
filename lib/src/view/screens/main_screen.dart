import 'package:flutter/material.dart';
import 'package:flutternews/src/view/screens/Posts.dart';
import 'package:flutternews/src/view/screens/categories.dart';
import 'package:flutternews/src/view/screens/otherMainCatPost.dart';
import 'package:flutternews/src/view/widgets/Drawer.dart';
import 'package:flutternews/src/view/widgets/BottomTabs.dart';
import 'package:flutternews/src/view/widgets/SearchBar.dart';

const textStyle = TextStyle(
    fontSize: 10.0,
    color: Colors.white,
    fontFamily: 'OpenSans',
    fontWeight: FontWeight.bold);

class MainScreen extends StatefulWidget {
  const MainScreen({Key key}) : super(key: key);
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController = new ScrollController();
  List<String> categories = ["a", "b", "c", "a", "b", "c"];

  TabController _tabController;

  @override
  void initState() {
    super.initState();
    // _scrollController.addListener(_scroll);
    _tabController =
        TabController(length: categories.length, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                child: SliverSafeArea(
                  top: false,
                  sliver: SliverAppBar(
                    title: new Text("Flutter News"),
                    floating: true,
                    pinned: true,
                    snap: false,
                    primary: true,
                    forceElevated: innerBoxIsScrolled,
                    elevation: 0.0,
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
                    bottom: TabBar(
                      controller: _tabController,
                      isScrollable: true,
                      labelColor: Color(0xFF000000),
                      labelStyle: textStyle.copyWith(
                          fontSize: 15.0,
                          color: Color(0xFF000000),
                          fontWeight: FontWeight.w700),
                      indicator: UnderlineTabIndicator(
                        borderSide:
                            BorderSide(color: Color(0xFF000000), width: 2.5),
                      ),
                      unselectedLabelColor: Color(0xFF757575),
                      unselectedLabelStyle: textStyle.copyWith(
                          fontSize: 15.0,
                          color: Color(0xFFc9c9c9),
                          fontWeight: FontWeight.w700),
                      tabs:
                          List<Widget>.generate(categories.length, (int index) {
                        if (index == 0) {
                          return new Icon(Icons.apps);
                        } else if (index == 1) {
                          return new Tab(text: 'All');
                        } else {
                          return new Tab(
                              text: 'Categories ' + index.toString());
                        }
                      }),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            controller: _tabController,
            children: List<Widget>.generate(categories.length, (int index) {
              if (index == 0) {
                return new Categories();
              } else if (index == 1) {
                return new Posts(_scrollController);
              } else {
                return new OtherMainCatPost(_scrollController);
              }
            }),
          ),
        ), 
      drawer: MainDrawer(),
      bottomNavigationBar: BottomTabs(),
  );
  }
}
