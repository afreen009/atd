import 'package:flutter/material.dart';
import 'package:maps_test/login.dart';
import 'home.dart';

void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ATD',
      home: LoginPage(),
    );
  }
}


