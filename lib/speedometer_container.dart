import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

import 'helper.dart';
import 'speedometer.dart';

class SpeedometerContainer extends StatefulWidget {
  @override
  _SpeedometerContainerState createState() => _SpeedometerContainerState();
}

class _SpeedometerContainerState extends State<SpeedometerContainer> {
  double speed=0.0;
  double velocity ;
  double highestVelocity = 24.0;

  @override
  void initState() {
    getVelocity();
    super.initState();
  }
  getVelocity() async {
      final String apiUrl = "https://api.thingspeak.com/channels/983649/feeds.json?api_key=0ADMCKQ1UGKBIQIJ&results=4";
      String url=apiUrl;
  http.Response res = await http.get(url);
  final jsonData = json.decode(res.body);
  var map=Map<String, dynamic>.from(jsonData);
  var response=Data.fromJson(map);
  if (res.statusCode == 200) {
    print('inside speedo');
       for(int i=0;i<4;i++){
         if(response.channel.lastEntryId==response.feeds[i].entryId){
         print(i);
         if(response.feeds[i].field1 != null){
           setState(() {
             speed= double.parse(response.feeds[i].field3);
             print(speed);
             print(double.parse(response.feeds[i].field3));
           });
         }
         }
         else if(response.feeds[i].field1==null){
           setState(() {
             speed=0.0;
             print(speed);
             print(double.parse(response.feeds[i-2].field3));
           });
           return;
         }
     
   }
  } else {
    throw Exception('Failed to load post');
  }
  }
  // void _onAccelerate(UserAccelerometerEvent event) {
  //   double newVelocity = sqrt(
  //       event.x * event.x + event.y * event.y + event.z * event.z
  //   );

  //   if ((newVelocity - velocity).abs() < 1) {
  //     return;
  //   }

  //   setState(() {
  //     velocity = newVelocity;

  //     if (velocity > highestVelocity) {
  //       highestVelocity = velocity;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Speedometer(
            speed: speed,
            speedRecord: speed,
          )
        )
    );
  }
}