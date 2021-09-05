import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:sms_maintained/sms.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'color.dart';
import 'package:permission_handler/permission_handler.dart';
import 'drawer.dart';
import 'authentication.dart';
import 'package:provider/provider.dart';

class Gmap extends StatefulWidget {
  @override
  _GmapState createState() => _GmapState();
}

class _GmapState extends State<Gmap> {
  GoogleMapController mapController;
  var lat = 13.0237;
  List<Marker> _markers = <Marker>[];
  var lng = 77.5566;
  Position _currentPosition;
  // var loading;
  var altitude;
  bool sitiosToggle = false;
  // SmsSender sender = SmsSender();
  bool permission = false;
  var _permissionStatus;
  final databaseRef = FirebaseDatabase.instance.reference();
  // final Future<FirebaseApp> _future = Firebase.initializeApp();

  void addData(String data) {
    databaseRef.push().set({'name': data, 'comment': 'A good season'});
  }

  Future<DataSnapshot> printFirebase() async {
    await Firebase.initializeApp();
    databaseRef.once().then((DataSnapshot snapshot) {
      return snapshot;
    });
    return null;
  }

  Future prefs = SharedPreferences.getInstance();
   String uid = "";
  // String address = "+918618210228";
  BitmapDescriptor markerIcon;
  Timer timer;
  var sitios = [];
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Set<Marker> allMarkers = Set();
  LatLng currentPostion;
  @override
  initState() {
    // timer =
    //     Timer.periodic(Duration(seconds: 15000), (Timer t) => _getLocation());
    super.initState();
    _askCameraPermission();
    getUid();
  }
 Future<void> getUid() async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   setState(() {
     print("getting uid");
     uid = prefs.getString('uid');
     print(uid);
   });
 }
  void _askCameraPermission() async {
    
    if (await Permission.contacts.request().isGranted) {
      _permissionStatus = await Permission.contacts.status;
      print("_permissionStatus$_permissionStatus");
      setState(()  {
       
        permission = true;
      });
    }
  }

  Geolocator geolocator = Geolocator();

  Position userLocation;
  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  _getLocation(latitude, lngitude) async {
    print("inside getlocation");
    ImageConfiguration configuration = ImageConfiguration();
    BitmapDescriptor bitmapImage = await BitmapDescriptor.fromAssetImage(
        configuration, 'assets/scooter.png');
    _markers.add(Marker(
        markerId: MarkerId('SomeId'),
        position: LatLng(latitude, lngitude),
        icon: bitmapImage,
        infoWindow: InfoWindow(title: 'You are bike is here')));
  }

  _onMapCreated(GoogleMapController controller) {
    var config = createLocalImageConfiguration(context, size: Size(30, 30));
    BitmapDescriptor.fromAssetImage(config, 'assets/scooter.png')
        .then((onValue) {
      setState(() {
        markerIcon = onValue;
      });
    });
    mapController = controller;
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(lat, lng), zoom: 20.0),
      ),
    );
  }

  // _getCurrentLocation() async {
  //   Geolocator.getCurrentPosition(
  //           desiredAccuracy: LocationAccuracy.best,
  //           forceAndroidLocationManager: true)
  //       .then((Position position) {
  //     setState(() {
  //       _currentPosition = position;
  //     });
  //   }).catchError((e) {
  //     print(e);
  //   });
  //   try {
  //     String strURL = (await prefs).getString('photourl');
  //     final http.Response responseData = await http.get(strURL);
  //     Uint8List uint8list = responseData.bodyBytes;
  //     print("locationLatitude: $uint8list");
  //     print("locationLongitude: ${_currentPosition.longitude}");
  //     BitmapDescriptor bitmapImage = BitmapDescriptor.fromBytes(uint8list);
  //     print("locationLatitude: $bitmapImage");
  //     _markers.add(Marker(
  //         markerId: MarkerId('SomeId'),
  //         position:
  //             LatLng(_currentPosition.latitude, _currentPosition.longitude),
  //         icon: bitmapImage,
  //         infoWindow: InfoWindow(title: 'You are here')));
  //     mapController.animateCamera(
  //       CameraUpdate.newCameraPosition(
  //         CameraPosition(
  //             target:
  //                 LatLng(_currentPosition.latitude, _currentPosition.longitude),
  //             zoom: 20.0),
  //       ),
  //     );
  //     // setState(() {

  //     // }); //rebuild the widget after getting the current location of the user
  //   } on Exception {
  //     _currentPosition = null;
  //   }
  // }

  _getUsersLocations(GoogleMapController controller) async {
    var location = new Location();
    LocationData _currentPosition;
     mapController = controller;
    try {
      _currentPosition = await location.getLocation();
      ImageConfiguration configuration = ImageConfiguration();
      BitmapDescriptor bitmapImage = await BitmapDescriptor.fromAssetImage(
          configuration, 'assets/scooter.png');
          mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: LatLng(_currentPosition.latitude, _currentPosition.longitude), zoom: 20.0),
      ),
    );
          _markers.add(
      Marker(
      markerId: MarkerId('ME'),
      position:
              LatLng(_currentPosition.latitude, _currentPosition.longitude),
      infoWindow: InfoWindow(
      title: 'You are here'
      )
     )
   );
      // _markers.add(Marker(
      //     markerId: MarkerId('SomeId'),
      //     position:
      //         LatLng(_currentPosition.latitude, _currentPosition.longitude),
      //     icon: bitmapImage,
      //     infoWindow: InfoWindow(title: 'You are here')));
      String strURL = (await prefs).getString('photourl');
      print("your photo url is ${_currentPosition.latitude}");
      // _currentPosition = await location.getLocation();

      // final http.Response responseData = await http.get(strURL);
      // Uint8List uint8list = responseData.bodyBytes;
      // BitmapDescriptor bitmapImage = BitmapDescriptor.fromBytes(uint8list);
      // setState(() {
      //   _markers.add(Marker(
      //       markerId: MarkerId('SomeId'),
      //       position:
      //           LatLng(_currentPosition.latitude, _currentPosition.longitude),
      //       icon: bitmapImage,
      //       infoWindow: InfoWindow(title: 'You are here')));
      // });
      // mapController.animateCamera(
      //   CameraUpdate.newCameraPosition(
      //     CameraPosition(
      //         target:
      //             LatLng(_currentPosition.latitude, _currentPosition.longitude),
      //         zoom: 20.0),
      //   ),
      // );
      // // setState(() {

      // }); //rebuild the widget after getting the current location of the user
    } on Exception {
      _currentPosition = null;
    }
  }

  @override
  Widget build(BuildContext context) {
     User user = _firebaseAuth.currentUser;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          // appBar: AppBar(backgroundColor: const Color.fromRGBO(20, 79, 76, 1.0),
          // ),
          appBar: AppBar(title: Text('ATD'),centerTitle: true,),
          
          drawer: Drawer(
        // Add a ListView to the drawer. This ensures the user can scroll
        // through the options in the drawer if there isn't enough vertical
        // space to fit everything.
        child: ListView(
          // Important: Remove any padding from the ListView.
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text('ATD'),
            ),
            ListTile(
              title: const Text('Home'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
               Navigator.pushNamed(context, '/home');
              },
            ),
            ListTile(
              title: const Text('Ticket History'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                // Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('User Info'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pushNamed(context, '/userInfo');
              },
            ),
            ListTile(
              title: const Text('Logout'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                context.read<AuthenticationService>().signOut();
                 Navigator.pushNamed(
                    context,
                    '/',
                  );
                // Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Terms and Conditions'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Help'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
          ),
      body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection(user.uid).snapshots(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                
                print("the data ---------------");
                print(snapshot.data);
              }
              return Container();
            },
      ),
//           body: FutureBuilder(
//               future: FirebaseDatabase.instance
//                   .reference()
//                   .child(uid)
//                   .once(),
//               builder: (context, AsyncSnapshot<DataSnapshot> snapshot) {
//                 //  Map<dynamic, dynamic> map = snapshot.data.snapshot.value;

//                 if (snapshot.hasError) {
//                   return Text(snapshot.error.toString());
//                 } else if (snapshot.hasData) {
//                   List noList = [
//                     '+919972365352',
//                     '+919018121178',
//                     // '+919845752038',
//                     // '+918618210228'
//                   ];
//                   Map data =
//                       snapshot.data.value != null ? snapshot.data.value : null;
//                   print("afreennnnnn${data['Accident']}");
//                   bool accident = data['Accident'] == 1 ? true : false;
//                   print("afreennnnnn $accident");
//                   if (accident) {
//                     print("SMS inside!");
//                     // for (int i = 0; i < noList.length; i++) {
//                     //   String _message = '';
//                     //   SmsMessage message = SmsMessage(
//                     //       noList[i], 'Your friend might have had accident');
//                     //   message.onStateChanged.listen((state) {
//                     //     if (state == SmsMessageState.Sent) {
//                     //       print("SMS is sent!");
//                     //       setState(() {
//                     //         _message = "SMS is sent";
//                     //       });
//                     //     } else if (state == SmsMessageState.Delivered) {
//                     //       print("SMS is delivered!");
//                     //       setState(() {
//                     //         _message = "SMS is delivered!";
//                     //       });
//                     //     }
//                     //   });
//                     //   sender.sendSms(message);
//                     // }
//                   }
//                   // _markers.add(Marker(
//                   //     markerId: MarkerId('SomeId'),
//                   //     position: LatLng(double.parse(data['latitude']),
//                   //         double.parse(data['longitude'])),
//                   //     icon: markerIcon,
//                   //     infoWindow: InfoWindow(title: 'You are vehicle here')));
//                   return Stack(
//                     children: <Widget>[
//                       // loading == false ?
//                       GoogleMap(
//                         // circles: circles,
//                         mapType: MapType.normal,
//                         myLocationEnabled: true,
//                         onMapCreated: _onMapCreated,
//                         zoomGesturesEnabled: true,
//                         compassEnabled: true,
//                         scrollGesturesEnabled: true,
//                         rotateGesturesEnabled: true,
//                         tiltGesturesEnabled: true,
//                         initialCameraPosition: CameraPosition(
//                             // target: LatLng(12.66, 17.444),
//                             target: LatLng(27.2046, 77.4977),
//                             zoom: 10),
//                         markers: Set<Marker>.of(_markers),
//                       ),
//                       // : Center(
//                       //     child: CircularProgressIndicator(),
//                       //   ),
//                       Positioned(
//                           top: MediaQuery.of(context).size.height -
//                               (MediaQuery.of(context).size.height - 70.0),
//                           right: 10.0,
//                           child: FloatingActionButton(
//                             onPressed: () {
//                               _getUsersLocations(mapController);
//                               // _onMapCreated(mapController);
//                             },
//                             mini: true,
//                             backgroundColor: Colors.amber,
//                             child: Icon(Icons.my_location),
//                           )),
//                       Positioned(
//                           top: MediaQuery.of(context).size.height -
//                               (MediaQuery.of(context).size.height - 170.0),
//                           right: 10.0,
//                           child: FloatingActionButton(
//                             onPressed: () {
//                               _getLocation(double.parse(data['latitude']),
//                                   double.parse(data['longitude']));
//                               setState(() {
//                                 lat = double.parse(data['latitude']);
//                                 lng = double.parse(data['longitude']);
//                               });
//                               _onMapCreated(mapController);
//                             },
//                             mini: true,
//                             backgroundColor: AppColors.brightGreen,
//                             child: Icon(Icons.my_location),
//                           )),
// //                       Positioned(
// //                           bottom: MediaQuery.of(context).size.height -
// //                               (MediaQuery.of(context).size.height - 50.0),
// //                           left: 10.0,
// //                           child: Row(
// //                             children: [
// //                               Container(
// //                                 height: 100,
// //                                 width: 100,
// //                                 child: SpeedometerContainer(
// //                                     double.parse(data['GpsSpeed'])),
// //                               ),

// // //                     Container(
// // //   child: Echarts(
// // //   option: '''
// // //     {
// // //       xAxis: {
// // //         type: 'Altitude Value',
// // //         data: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun']
// // //       },
// // //       yAxis: {
// // //         type: ''
// // //       },
// // //       series: [{
// // //         data: [820, 932, 901, 934, 1290, 1330, 1320],
// // //         type: 'line'
// // //       }]
// // //     }
// // //   ''',
// // //   ),
// // //   width: 300,
// // //   height: 250,
// // // )
// //                               //           Container(
// //                               //   padding: EdgeInsets.only(bottom: 10),
// //                               //   alignment: Alignment.bottomCenter,
// //                               //   child: Text(
// //                               //     'Highest speed:\n km/h',
// //                               //     style: TextStyle(
// //                               //         color: Colors.black
// //                               //     ),
// //                               //     textAlign: TextAlign.center,
// //                               //   )
// //                               // ),
// //                             ],
// //                           )),
//                     ],
//                   );
//                 }
//                 return Center(
//                   child: CircularProgressIndicator(),
//                 );
//               }),
              ),
    );
  }
}
