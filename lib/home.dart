import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'authentication.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
// 1
  User user;

  @override
  void initState() {
    setState(() {
      // 2
      user = context.read<AuthenticationService>().getUser();
      print(user);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.indigoAccent,
        title: const Text(
          'Flutter Firebase Auth',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                // 3
                context.read<AuthenticationService>().signOut();
              })
        ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text("Hurrah!",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w700,
                color: Colors.black,
              )),
          Center(
            child: user != null ? Image.asset('assets/car.png') : Container(),
          ),
          Column(
            children: [
              Text(
                "You logged in as",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade50,
                    borderRadius: BorderRadius.all(
                      Radius.circular(25.0),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      // 4
                      user != null ? user.email : "No User Found",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:maps_test/signup.dart';

// import 'color.dart';
// import 'fadeAnimation.dart';
// import 'login.dart';

// class HomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.brightGreen,
//       body: SafeArea(
//         child: Container(
//           width: double.infinity,
//           height: MediaQuery.of(context).size.height,
//           padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               Column(
//                 children: <Widget>[
//                   FadeAnimation(
//                       1,
//                       Text(
//                         "Welcome",
//                         style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                             color: Colors.white,
//                             fontSize: 32),
//                       )),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   FadeAnimation(
//                       1.2,
//                       Text(
//                         "Automatic identity verification which enables you to verify your identity",
//                         textAlign: TextAlign.center,
//                         style: TextStyle(color: Colors.grey[400], fontSize: 15),
//                       )),
//                 ],
//               ),
//               FadeAnimation(
//                   1.4,
//                   Container(
//                     height: MediaQuery.of(context).size.height / 3,
//                     decoration: BoxDecoration(
//                         image: DecorationImage(
//                             image: AssetImage('assets/illustration.png'))),
//                   )),
//               Column(
//                 children: <Widget>[
//                   FadeAnimation(
//                       1.5,
//                       MaterialButton(
//                         minWidth: double.infinity,
//                         height: 60,
//                         onPressed: () {
//                           // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
//                         },
//                         shape: RoundedRectangleBorder(
//                             side: BorderSide(color: Colors.yellow),
//                             borderRadius: BorderRadius.circular(50)),
//                         child: Text(
//                           "Login",
//                           style: TextStyle(
//                               fontWeight: FontWeight.w600,
//                               color: Colors.white,
//                               fontSize: 18),
//                         ),
//                       )),
//                   SizedBox(
//                     height: 20,
//                   ),
//                   FadeAnimation(
//                       1.6,
//                       Container(
//                         padding: EdgeInsets.only(top: 3, left: 3),
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(50),
//                             border: Border(
//                               bottom: BorderSide(color: Colors.black),
//                               top: BorderSide(color: Colors.black),
//                               left: BorderSide(color: Colors.black),
//                               right: BorderSide(color: Colors.black),
//                             )),
//                         child: MaterialButton(
//                           minWidth: double.infinity,
//                           height: 60,
//                           onPressed: () {
//                             Navigator.push(
//                                 context,
//                                 MaterialPageRoute(
//                                     builder: (context) => SignupPage()));
//                           },
//                           color: AppColors.lightGreen,
//                           elevation: 0,
//                           shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(50)),
//                           child: Text(
//                             "Sign up",
//                             style: TextStyle(
//                                 fontWeight: FontWeight.w600, fontSize: 18),
//                           ),
//                         ),
//                       ))
//                 ],
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
