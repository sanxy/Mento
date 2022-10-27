import 'package:flutter/material.dart';
import 'package:mento/pages/first_page.dart';
import 'package:mento/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Mento List",
      debugShowCheckedModeBanner: false,
      home: FirstPage(),
      // home: HomePage(),
    );
  }
}
