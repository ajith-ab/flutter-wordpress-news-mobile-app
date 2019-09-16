import 'package:flutter/material.dart';

class SearchBarz extends SearchDelegate {
  final cities = [
    "asdsadad",
    "asdsd",
    "asdad",
    "ad23243",
    "asdsadad",
    "asdsd",
    "asdad",
    "ad23243",
    "asdsadad",
    "asdsd",
    "asdad",
    "ad23243",
  ];

  final recentCities = [
    "asdsadad",
    "asdsd",
    "asdad",
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return null;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggetionList = query.isEmpty ? recentCities : cities;
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        leading: Icon(Icons.local_airport),
        title: Text(suggetionList[index]),
      ),
      itemCount: suggetionList.length,
    );
  }
}