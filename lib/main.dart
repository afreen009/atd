import 'package:flutter/material.dart';
// Import the provider plugin
import 'package:provider/provider.dart';
// Import the firebase plugins
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'authentication.dart';
import 'signin.dart';
import 'splash.dart';
import 'map.dart';
import 'user_info.dart';

// 1
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // 2
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        // 3
        StreamProvider(
          create: (context) =>
              context.read<AuthenticationService>().authStateChanges,
          initialData: null,
        )
      ],
      child: MaterialApp(
        title: 'Flutter Firebase Auth',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            visualDensity: VisualDensity.adaptivePlatformDensity,
            primaryColor: Colors.indigoAccent),
        initialRoute: '/',
        routes: {
          '/': (context) => Splash(),
          '/auth': (context) => AuthenticationWrapper(),
          '/signin': (context) => SignIn(),
          '/home': (context) => Gmap(),
          '/userInfo':(context) => UsersInfo(),
        },
      ),
    );
  }
}

class AuthenticationWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseuser = context.watch<User>();
    if (firebaseuser != null) {
      return Gmap();
    }
    return SignIn();
  }
}
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:maps_test/login.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'home.dart';
// import 'map.dart';

// // void main() async {
// //   WidgetsFlutterBinding.ensureInitialized();
// //   await Firebase.initializeApp();
// //   runApp(MyApp());
// // }
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   SharedPreferences prefs = await SharedPreferences.getInstance();
//   var status = prefs.getString('uid');
//   print(status);
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: status == null ? LoginPage() : Gmap(),
//   ));
// }

// // class MyApp extends StatefulWidget {
// //   @override
// //   _MyAppState createState() => _MyAppState();
// // }

// // class _MyAppState extends State<MyApp> {
// //   final prefs = SharedPreferences.getInstance();
// //   String uid = '';
// //   String userUid = '';
// //   @override
// //   void initState() {
// //     // TODO: implement initState
// //     super.initState();
// //     getPrefsInstances();
// //   }

// //   getPrefsInstances() async {
// //     print('getPrefsInstances');
// //     uid = (await prefs).getString('uid');
// //     print('getPrefsInstances$uid');
// //     setState(() {
// //       userUid = uid;
// //     });
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(
// //       debugShowCheckedModeBanner: false,
// //       title: 'ATD',
// //       home: userUid == null ? LoginPage() : Gmap(),
// //     );
// //   }
// // }
