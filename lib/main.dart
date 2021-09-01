import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:maps_test/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'map.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final prefs = SharedPreferences.getInstance();
  String uid = '';
  String UserUid ='';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPrefsInstances();
  }
  getPrefsInstances()async{
    uid= (await prefs).getString('uid');
   setState(() {
     UserUid = uid;
   });
  }
 
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ATD',
      home:UserUid == '' ?  LoginPage():Gmap(),
    );
  }
}


