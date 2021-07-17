import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:maps_test/speedometer_container.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sms_maintained/sms.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'color.dart';
import 'helper.dart';

class Gmap extends StatefulWidget {
  @override
  _GmapState createState() => _GmapState();
}

class _GmapState extends State<Gmap> {
  GoogleMapController mapController;
  var lat=13.0237 ;
  List<Marker> _markers = <Marker>[];
   var lng= 77.5566;
  // var loading;
  var altitude;
  bool sitiosToggle = false;
  SmsSender sender = SmsSender();
  final databaseRef = FirebaseDatabase.instance.reference().child('DTproduction');
  final Future<FirebaseApp> _future = Firebase.initializeApp();
 @override
  initState() {
    // loading = true;
    
      timer = Timer.periodic(Duration(seconds: 5), (Timer t) => _getLocation());
      
super.initState();
  }
  void addData(String data) {
    databaseRef.push().set({'name': data, 'comment': 'A good season'});
  }

  Future<DataSnapshot> printFirebase()async{
    await Firebase.initializeApp();
    databaseRef.once().then((DataSnapshot snapshot) {
      return snapshot;
      
    });
    return null;
  }

    // String address = "+918618210228";
    
Timer timer;
  var sitios = [];
  Set<Marker> allMarkers = Set();
   
  @override
  void dispose() {
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
  final prefs = await SharedPreferences.getInstance();
  var map=Map<String, dynamic>.from(jsonData);
  var response=Data.fromJson(map);
  if (res.statusCode == 200) {
    ImageConfiguration configuration = ImageConfiguration();
    BitmapDescriptor  bitmapImage = await BitmapDescriptor.fromAssetImage(configuration,'assets/scooter.png');
       for(int i=0;i<4;i++){
         if(response.feeds[i].field1 != null){
           setState(() {
             lat = double.parse(response.feeds[i].field1);
      lng = double.parse(response.feeds[i].field2);
      // set value
      prefs.setDouble('lat', lat);
      prefs.setDouble('lng', lng);
      print(double.parse(response.feeds[i].field1));
      print(double.parse(response.feeds[i].field2));
      _markers.add(
      Marker(
      markerId: MarkerId('SomeId'),
      position: LatLng(lat,lng),
      icon: bitmapImage,
      infoWindow: InfoWindow(
      title: 'You are here'
      )
     )
   );
           });
         }
         else if(response.feeds[i].field1==null){
           print('inside');
           print(lat);
             setState(() {
               altitude = response.feeds[i].field4;
               lat=prefs.getDouble('lat');
               lng=prefs.getDouble('lng');
      _markers.add(
      Marker(
      markerId: MarkerId('SomeId'),
      position: LatLng(lat,lng),
      icon: bitmapImage,
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
// LatLng _createCenter() {
//     return _createLatLng(lat , lng);
//   }

  // LatLng _createLatLng(double lat, double lng) {
  //   return LatLng(lat, lng);
  // }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        // appBar: AppBar(backgroundColor: const Color.fromRGBO(20, 79, 76, 1.0),
        // ),
        body: FutureBuilder(
          future: FirebaseDatabase.instance.reference().child('DTproduction').once(),
           builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
             print("snapshot--------$snapshot");
            //  Map<dynamic, dynamic> map = snapshot.data.snapshot.value;
              if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
             else if(snapshot.hasData){
               Map data = snapshot.data.value !=null ?snapshot.data.value:null;
               print("data $data");
               return Stack(
            children: <Widget>[
              // loading == false ?
                   GoogleMap(
                      // circles: circles,
                      mapType: MapType.normal,
                      onMapCreated: _onMapCreated,
                      zoomGesturesEnabled: true,
                      compassEnabled: true,
                      scrollGesturesEnabled: true,
                      rotateGesturesEnabled: true,
                      tiltGesturesEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(double.parse('13.033713'), double.parse('77.614108')),
                        zoom: 10
                      ),
                      markers: Set<Marker>.of(_markers),
                    ),
                  // : Center(
                  //     child: CircularProgressIndicator(),
                  //   ),
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
                    backgroundColor: AppColors.brightGreen,
                    child: Icon(Icons.my_location),
                  )),
                  Positioned(
                  bottom: MediaQuery.of(context).size.height -
                      (MediaQuery.of(context).size.height - 50.0),
                  left: 10.0,
                  child: Row(
                    children: [
                      Container(
                        height:100,
                      width:100,
                      
                        child:SpeedometerContainer(),
                      ),
                      SizedBox(width:10),
                      Container(
                        height:100,
                      width:100,
                      decoration: BoxDecoration(
                      color: AppColors.brightGreen,
		                borderRadius: BorderRadius.all(Radius.circular(8.0))),
                      child: Column(
                        mainAxisAlignment:MainAxisAlignment.center,
                        children:[
                          Image.asset('assets/mountain.png',height:40,width:40),
                          SizedBox(height:10),
                          altitude ==null ? Text('0m',
                          style: TextStyle(
                            color: Colors.white
                      ),
                      ):Text(altitude.toString(),
                      style: TextStyle(
                          color: Colors.white
                      ),
                      ),
                        ]
                      )
                      ),
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
          );}return CircularProgressIndicator();},
        ),
      ),
      
    );
  }
}