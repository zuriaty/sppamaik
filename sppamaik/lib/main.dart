import 'package:flutter/material.dart';
import 'package:sppamaik/page/home.dart';
import 'package:sppamaik/page/mainpage.dart';
import 'package:sppamaik/util/strings.dart';
import 'package:sppamaik/util/router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: Strings.appBarTitle,
      theme: ThemeData(
        primaryColor: Colors.red[900],
      ),
      //home: Home(),
      onGenerateRoute: RouteGenerator.generateRoute,
      initialRoute: '/',
    );
  }
}
