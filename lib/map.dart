import 'dart:async';
import 'package:maps_test/speedometer_container.dart';
import 'package:sms_maintained/sms.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';

import 'helper.dart';

class Gmap extends StatefulWidget {
  @override
  _GmapState createState() => _GmapState();
}

class _GmapState extends State<Gmap> {
  GoogleMapController mapController;
  var lat ;
  List<Marker> _markers = <Marker>[];
   var lng ;
  var loading;
  var altitude;
  bool sitiosToggle = false;
  SmsSender sender = SmsSender();
    // String address = "+918618210228";
    
Timer timer;
  var sitios = [];
  Set<Marker> allMarkers = Set();
    @override
  initState() {
    loading = true;
      timer = Timer.periodic(Duration(seconds: 5), (Timer t) => _getLocation());
      
super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    timer.cancel();
  }
  final String apiUrl = "https://api.thingspeak.com/channels/983649/feeds.json?api_key=0ADMCKQ1UGKBIQIJ&results=4";
   _getLocation() async {
     print(lat);
     print(lng);
    String url=apiUrl;
  http.Response res = await http.get(url);
  final jsonData = json.decode(res.body);
  var map=Map<String, dynamic>.from(jsonData);
  var response=Data.fromJson(map);
  if (res.statusCode == 200) {
    loading= false;
       for(int i=0;i<4;i++){
        //  altitude.add(response.feeds[i].field4);
         print(altitude);
         if(response.channel.lastEntryId==response.feeds[i].entryId){
         print(i);
         if(response.feeds[i].field1 != null){
           setState(() {
             lat = double.parse(response.feeds[i].field1);
      lng = double.parse(response.feeds[i].field2);
      altitude= double.parse(response.feeds[0].field6);
      print(double.parse(response.feeds[i].field1));
      print(double.parse(response.feeds[i].field2));
      _markers.add(
      Marker(
      markerId: MarkerId('SomeId'),
      position: LatLng(lat,lng),
      infoWindow: InfoWindow(
      title: 'The title of the marker'
      )
     )
   );
           });
         }
         }
         else if(response.feeds[i].field1==null){
           print('inside');
           print(lat);
             setState(() {
               lat = double.parse(response.feeds[i-2].field1);
      lng = double.parse(response.feeds[i-2].field2);
      _markers.add(
      Marker(
      markerId: MarkerId('SomeId'),
      position: LatLng(lat,lng),
      infoWindow: InfoWindow(
      title: 'The title of the marker'
      )
     )
   );
             });
     return;      
         }
     
   }
  } else {
    throw Exception('Failed to load post');
  }
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
            target: LatLng(lat, lng), zoom: 20.0),
      ),
    );
  }
LatLng _createCenter() {
    return _createLatLng(lat , lng);
  }

  LatLng _createLatLng(double lat, double lng) {
    return LatLng(lat, lng);
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Stack(
          children: <Widget>[
            loading == false
                ? GoogleMap(
                    // circles: circles,
                    mapType: MapType.normal,
                    onMapCreated: _onMapCreated,
                    zoomGesturesEnabled: true,
                    compassEnabled: true,
                    scrollGesturesEnabled: true,
                    rotateGesturesEnabled: true,
                    tiltGesturesEnabled: true,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(lat, lng),
                      zoom: 13
                    ),
                    markers: Set<Marker>.of(_markers),
                  )
                : Center(
                    child: CircularProgressIndicator(),
                  ),
            Positioned(
                top: MediaQuery.of(context).size.height -
                    (MediaQuery.of(context).size.height - 70.0),
                right: 10.0,
                child: FloatingActionButton(
                  onPressed: () {
                    _getLocation();
                    _onMapCreated(mapController);
                  },
                  mini: true,
                  backgroundColor: Colors.red,
                  child: Icon(Icons.refresh),
                )),
                Positioned(
                bottom: MediaQuery.of(context).size.height -
                    (MediaQuery.of(context).size.height - 50.0),
                left: 10.0,
                child: Row(
                  children: [
                    Container(
                      height:150,
                      width:150,
                      child:SpeedometerContainer(),
                    ),
                    RaisedButton(onPressed: (){
                      SmsMessage message = SmsMessage('+918618210228', 'accident has occured!\n https://www.google.com/maps/search/?api=1&query=$lat,$lng');
                      sender.sendSms(message);
                    },child: Text('send message'),)
//                     Container(
//   child: Echarts(
//   option: '''
//     {
//       xAxis: {
//         type: 'Altitude Value',
//         data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
//       },
//       yAxis: {
//         type: ''
//       },
//       series: [{
//         data: [820, 932, 901, 934, 1290, 1330, 1320],
//         type: 'line'
//       }]
//     }
//   ''',
//   ),
//   width: 300,
//   height: 250,
// )
          //           Container(
          //   padding: EdgeInsets.only(bottom: 10),
          //   alignment: Alignment.bottomCenter,
          //   child: Text(
          //     'Highest speed:\n km/h',
          //     style: TextStyle(
          //         color: Colors.black
          //     ),
          //     textAlign: TextAlign.center,
          //   )
          // ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}