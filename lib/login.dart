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
            child: user != null ? Image.asset('assets/Saly.png') : Container(),
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
// import 'package:font_awesome_flutter/font_awesome_flutter.dart';
// import 'package:maps_test/sign_in.dart';

// import 'color.dart';
// import 'fadeAnimation.dart';
// import 'map.dart';

// class LoginPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       backgroundColor: AppColors.brightGreen,
//       // appBar: AppBar(
//       //   elevation: 0,
//       //   brightness: Brightness.light,
//       //   backgroundColor: AppColors.brightGreen,
//       //   leading: IconButton(
//       //     onPressed: () {
//       //       Navigator.pop(context);
//       //     },
//       //     icon: Icon(Icons.arrow_back_ios, size: 20, color: Colors.black,),
//       //   ),
//       // ),
//       body: Container(
//         height: MediaQuery.of(context).size.height,
//         width: double.infinity,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: <Widget>[
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: <Widget>[
//                   Column(
//                     children: <Widget>[
//                       FadeAnimation(
//                           1,
//                           Text(
//                             "Login",
//                             style: TextStyle(
//                                 fontSize: 30,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.bold),
//                           )),
//                       SizedBox(
//                         height: 20,
//                       ),
//                       FadeAnimation(
//                           1.2,
//                           Text(
//                             "Login to your account",
//                             style: TextStyle(
//                                 fontSize: 15, color: Colors.yellowAccent),
//                           )),
//                     ],
//                   ),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: 40),
//                     child: Column(
//                       children: <Widget>[
//                         FadeAnimation(1.2, makeInput(label: "Phone number")),
//                         FadeAnimation(1.3,
//                             makeInput(label: "Password", obscureText: true)),
//                       ],
//                     ),
//                   ),
//                   FadeAnimation(
//                       1.4,
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 40),
//                         child: Container(
//                           padding: EdgeInsets.only(top: 3, left: 3),
//                           decoration: BoxDecoration(
//                               borderRadius: BorderRadius.circular(50),
//                               border: Border(
//                                 bottom: BorderSide(color: Colors.black),
//                                 top: BorderSide(color: Colors.black),
//                                 left: BorderSide(color: Colors.black),
//                                 right: BorderSide(color: Colors.black),
//                               )),
//                           child: MaterialButton(
//                             minWidth: double.infinity,
//                             height: 60,
//                             onPressed: () {
//                               // Navigator.push(context, MaterialPageRoute(builder: (context) => VehicleType()));
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                       builder: (context) => Gmap()));
//                             },
//                             color: Colors.greenAccent,
//                             elevation: 0,
//                             shape: RoundedRectangleBorder(
//                                 borderRadius: BorderRadius.circular(50)),
//                             child: Text(
//                               "Login",
//                               style: TextStyle(
//                                   fontWeight: FontWeight.w600, fontSize: 18),
//                             ),
//                           ),
//                         ),
//                       )),
//                   FadeAnimation(
//                       1.5,
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: <Widget>[
//                           _signInButton(context),
//                         ],
//                       ))
//                 ],
//               ),
//             ),
//             // FadeAnimation(
//             //     1.2,
//             //     Container(
//             //       height: MediaQuery.of(context).size.height / 3,
//             //       decoration: BoxDecoration(
//             //           image: DecorationImage(
//             //               image: AssetImage('assets/background.png'),
//             //               fit: BoxFit.cover)),
//             //     ))
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _signInButton(context) {
//     return OutlineButton(
//       splashColor: Colors.grey,
//       onPressed: () {
//         signInWithGoogle().then((result) {
//           if (result != null) {
//             Navigator.of(context).push(
//               MaterialPageRoute(
//                 builder: (context) {
//                   return Gmap();
//                 },
//               ),
//             );
//           }
//         });
//       },
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
//       highlightElevation: 0,
//       borderSide: BorderSide(color: Colors.grey),
//       child: Padding(
//         padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             FaIcon(FontAwesomeIcons.google, color: Colors.red),
//             // Image(image: AssetImage("assets/google_logo.png"), height: 35.0),
//             Padding(
//               padding: const EdgeInsets.only(left: 10),
//               child: Text(
//                 'Sign in with Google',
//                 style: TextStyle(
//                   fontSize: 20,
//                   color: Colors.grey,
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget makeInput({label, obscureText = false}) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: <Widget>[
//         Text(
//           label,
//           style: TextStyle(
//               fontSize: 15,
//               fontWeight: FontWeight.w400,
//               color: AppColors.lightGreen),
//         ),
//         SizedBox(
//           height: 5,
//         ),
//         TextField(
//           obscureText: obscureText,
//           decoration: InputDecoration(
//             contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
//             enabledBorder: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey[400])),
//             border: OutlineInputBorder(
//                 borderSide: BorderSide(color: Colors.grey[400])),
//           ),
//         ),
//         SizedBox(
//           height: 30,
//         ),
//       ],
//     );
//   }
// }
