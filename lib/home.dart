import 'package:flutter/material.dart';
import 'package:maps_test/signup.dart';

import 'color.dart';
import 'fadeAnimation.dart';
import 'login.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.brightGreen,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Column(
                children: <Widget>[
                  FadeAnimation(1, Text("Welcome", style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 32
                  ),)),
                  SizedBox(height: 20,),
                  FadeAnimation(1.2, Text("Automatic identity verification which enables you to verify your identity", 
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.grey[400],
                    fontSize: 15
                  ),)),
                ],
              ),
              FadeAnimation(1.4, Container(
                height: MediaQuery.of(context).size.height / 3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/illustration.png')
                  )
                ),
              )),
              Column(
                children: <Widget>[
                  FadeAnimation(1.5, MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage()));
                    },
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Colors.yellow
                      ),
                      borderRadius: BorderRadius.circular(50)
                    ),
                    child: Text("Login", style: TextStyle(
                      fontWeight: FontWeight.w600, 
                      color: Colors.white,
                      fontSize: 18
                    ),),
                  )),
                  SizedBox(height: 20,),
                  FadeAnimation(1.6, Container(
                    padding: EdgeInsets.only(top: 3, left: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      border: Border(
                        bottom: BorderSide(color: Colors.black),
                        top: BorderSide(color: Colors.black),
                        left: BorderSide(color: Colors.black),
                        right: BorderSide(color: Colors.black),
                      )
                    ),
                    child: MaterialButton(
                      minWidth: double.infinity,
                      height: 60,
                      onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => SignupPage()));
                      },
                      color: AppColors.lightGreen,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Text("Sign up", style: TextStyle(
                        fontWeight: FontWeight.w600, 
                        fontSize: 18
                      ),),
                    ),
                  ))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

