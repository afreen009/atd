// import 'package:flutter/material.dart';
// import 'package:maps_test/color.dart';

// import 'map.dart';

// class VehicleType extends StatelessWidget {
//   const VehicleType({Key key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.brightGreen,
//       body: Column(
//         mainAxisAlignment:MainAxisAlignment.spaceBetween,
//         children:[
//           SizedBox(height:10),
//           Text(
//             'Choose your vehicle',
//             style:TextStyle(
//               color:Colors.white,
//               fontSize: 32
//             ),
//             ),
//           Center(
//             child: Container(
//             height: 150,
//             width: 150,
//             decoration: BoxDecoration(
//               color: Colors.yellow,
//               shape: BoxShape.circle
//             ),
//             child: Center(
//               child: InkWell(
//                 onTap:(){
//               Navigator.push(context, MaterialPageRoute(builder: (context) => Gmap()));
//             },child: Image.asset('assets/motorcycle.png'))),
//             ),
//           ),
//           Container(
//           height: 150,
//           width: 150,
//           decoration: BoxDecoration(
//             color: AppColors.lightGreen,
//             shape: BoxShape.circle
//           ),
//           child: Center(child: InkWell(onTap:(){
//               Navigator.push(context, MaterialPageRoute(builder: (context) => Gmap()));
//             },child: Image.asset('assets/car.png'))),
//           ),
//           Text(
//             'Terms and Condition.',
//             style:TextStyle(
//               color:Colors.grey,
//               fontSize: 12
//             ),
//             ),
//         ]
//       ),
//     );
//   }
// }