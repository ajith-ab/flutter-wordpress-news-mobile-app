import 'package:flutter/material.dart';
import 'package:flutternews/src/view/screens/main_screen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutternews/src/bloc/bloc.dart';


class NewsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
         title: 'flutter news',
         debugShowCheckedModeBanner: false,
         theme: ThemeData(
            primarySwatch: Colors.blue, primaryColor: Colors.indigo[900]),
         home:BlocProvider(
          builder: (context) =>
              PostBloc(httpClient: http.Client())..dispatch(Fetch()),
          child: MainScreen(),
        ), 
        );
      

  }
}