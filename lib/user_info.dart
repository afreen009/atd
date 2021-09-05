import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:maps_test/transaction.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model.dart';


class UsersInfo extends StatefulWidget {    
 @override    
 _UsersInfoState createState() => _UsersInfoState();    
}    
     
class _UsersInfoState extends State<UsersInfo> {    
 var data;    
 bool autoValidate = true;    
 bool readOnly = false;    
 bool showSegmentedControl = true;    
 final GlobalKey<FormBuilderState> _fbKey = GlobalKey<FormBuilderState>();    
 TextEditingController fullName =   TextEditingController();  
 TextEditingController registrationId =   TextEditingController();
 TextEditingController age =   TextEditingController();
 TextEditingController number =   TextEditingController();
 TextEditingController address = TextEditingController();
 bool isSubmitted = false;
      Future prefs = SharedPreferences.getInstance();
   
   final FirebaseAuth auth = FirebaseAuth.instance;
   
   @override
  initState() {
    // timer =
    //     Timer.periodic(Duration(seconds: 15000), (Timer t) => _getLocation());
    super.initState();
  }
//    Future<void> getUid() async {
//    SharedPreferences prefs = await SharedPreferences.getInstance();
//    setState(() {
//      print("getting uid");
//      uid = prefs.getString('uid');
//      print(uid);
//    });
//  }
 @override    
 Widget build(BuildContext context) { 
     final User user = auth.currentUser;
    final uid = user.uid;
   print("uid is here $uid"); 
   return Scaffold(    
     appBar: AppBar(    
       title: Text("Profile"),    
     ),    
     body: StreamBuilder(
      stream: FirebaseFirestore.instance
    .collection('users')
    .doc(uid)
    .snapshots(),
              builder: (context, snapshot){
                if(snapshot.hasData){
                  print(snapshot.data['name']);
                  return SingleChildScrollView(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Container(
                          height: MediaQuery.of(context).size.height/2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children:<Widget> [
                              Row(
                                children: [
                                  Text('Full Name :'),
                                  Text(snapshot.data['name']),
                                ],
                              ),
                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  Text('Age :'),
                                  Text(snapshot.data['age']),
                                ],
                              ),
                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  Text('Address :'),
                                  Text(snapshot.data['address']),
                                ],
                              ),
                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  Text('Sim Number :'),
                                  Text(snapshot.data['simNumber']),
                                ],
                              ),
                              SizedBox(height: 20,),
                              Row(
                                children: [
                                  Text('Registration Id :'),
                                  Text(snapshot.data['registrationId']),
                                ],
                              ),
                            ]
                          ),
                        ),
                      ),
                    ),
                  );
                }
                            return  Padding(    
         padding: EdgeInsets.all(10),    
         child: SingleChildScrollView(    
           child: Column(    
               children: <Widget>[    
                 FormBuilder(    
                   key: _fbKey,    
                   initialValue: {    
                     'date': DateTime.now(),    
                     'accept_terms': false,    
                   },    
                  //  autovalidate: true,    
                   child: Column(    
                     children: <Widget>[    
                       FormBuilderTextField(    
                         attribute: 'text',
                         controller: fullName,
                         validators: [FormBuilderValidators.required()],    
                         decoration: InputDecoration(labelText: "Full Name"),    
                       ),    
                      //  FormBuilderDropdown(    
                      //    attribute: "gender",    
                      //    decoration: InputDecoration(labelText: "Gender"),    
                      //    // initialValue: 'Male',    
                      //    hint: Text('Select Gender'),    
                      //    validators: [FormBuilderValidators.required()],    
                      //    items: ['Male', 'Female', 'Other']    
                      //        .map((gender) => DropdownMenuItem(    
                      //            value: gender, child: Text("$gender")))    
                      //        .toList(),    
                      //  ),    
                       FormBuilderTextField(    
                         attribute: "age",    
                         controller: age,
                         decoration: InputDecoration(labelText: "Age"),    
                         keyboardType: TextInputType.number,    
                         validators: [    
                           FormBuilderValidators.numeric(),  
                         ],    
                       ), 
                       FormBuilderTextField(    
                         attribute: "address",    
                         controller: address,
                         decoration: InputDecoration(labelText: "Address"),    
                        validators: [FormBuilderValidators.required()],     
                       ),    
                       FormBuilderTextField(    
                         attribute: "Sim number",
                         controller: number,    
                         decoration: InputDecoration(labelText: "Sim Number"),    
                         keyboardType: TextInputType.number,    
                         validators: [    
                           FormBuilderValidators.numeric(),       
                         ],    
                       ),
                       FormBuilderTextField(    
                         attribute: "Registration Id",
                         controller: registrationId,    
                         decoration: InputDecoration(labelText: "Registration Id"),    
                         keyboardType: TextInputType.number,    
                         validators: [    
                           FormBuilderValidators.numeric(),       
                         ],    
                       ),
                      //  FormBuilderCheckbox(    
                      //    attribute: 'accept_terms',   

                      //    label: Text(    
                      //        "I have read and agree to the terms and conditions"),    
                      //    validators: [    
                      //      FormBuilderValidators.requiredTrue(    
                      //        errorText:    
                      //            "You must accept terms and conditions to continue",    
                      //      ),    
                      //    ],    
                      //  ),    
                     ],    
                   ),    
                 ),  
                 SizedBox(height: 20,),  
                 Row(   
                   mainAxisAlignment: MainAxisAlignment.end, 
                   children: <Widget>[    
                     MaterialButton(    
                       color: Colors.blue,
                       child: Text("Submit"),    
                       onPressed: () async{    
                         Future prefs = SharedPreferences.getInstance();
                          String uid = (await prefs).getString("uid");
                          print("this is the uid $uid");
                                    final snackBar = SnackBar(
                content: const Text('Yay! A SnackBar!'),
            );
                         _fbKey.currentState.save();    
                         if (_fbKey.currentState.validate()) {    
                           print(_fbKey.currentState.value);  
                             final CollectionReference userCollection = FirebaseFirestore.instance.collection('users');

                           DocumentReference documentReferencer = userCollection.doc(uid);

  // Map user = {"Name": "${fullName.text}", "Age": "${age.text}",
  //  "Number": "${number.text}","address":address.text,"Sim Number":number.text,
  //  "registrationId" : registrationId.text};

  Users user = Users( 
    uid: uid,
    name: fullName.text,
    age: age.text,
    simNumber: number.text,
    registrationId:registrationId.text,
    address:address.text
  );

  var data = user.toJson();

  await documentReferencer.set(data).whenComplete(() {
    print("User data added");
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  setState((){
                    isSubmitted= true;
                  });

  }).catchError((e) => print(e));
//                        FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
//         CollectionReference reference = FirebaseFirestore.instance.collection('profile');
// await reference.doc().set({"Name": "${fullName.text}", "Age": "${age.text}", "Number": "${number.text}"});
//         await reference.add({"Name": "${fullName.text}", "Age": "${age.text}", "Number": "${number.text}"});
//       });  
                         }    
                       },    
                     ),    
                    //  MaterialButton(    
                    //    child: Text("Reset"),    
                    //    onPressed: () {    
                    //      _fbKey.currentState.reset();    
                    //    },    
                    //  ),    
                   ],    
                 )    
               ],    
           ),    
         ),    
       );
 },
     ));    
 }    
}  