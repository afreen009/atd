import 'package:flutter/material.dart';

class UsersInfo extends StatefulWidget {
  final String image;
  final String textTop;
  final String textBottom;
  final double offset;
  const UsersInfo(
      {Key key, this.image, this.textTop, this.textBottom, this.offset})
      : super(key: key);

  @override
  _UsersInfoState createState() => _UsersInfoState();
}

class _UsersInfoState extends State<UsersInfo> {
  final controller = ScrollController();
  double offset = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(onScroll);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.dispose();
    super.dispose();
  }

  void onScroll() {
    setState(() {
      offset = (controller.hasClients) ? controller.offset : 0;
    });
  }
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: controller,
        child: Column(
          children: <Widget>[
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                padding: EdgeInsets.only(left: 40, top: 50, right: 20),
                height: 370,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color(0xFF3383CD),
                      Color(0xFF11249F),
                    ],
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/onecurve.png"),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    "Enter Driving UserInfo No",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color(0xFF303030),
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 20,),
      Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: SizedBox(
          height: 156,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: <Widget>[
              Container(
                height: 136,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.amber,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 8),
                      blurRadius: 24,
                      color: Color(0xFFB7B7B7).withOpacity(.16),
                    ),
                  ],
                ),
              ),
//              Image.asset("assets/otpp.png"),
              TextFormField(
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                  prefix: Container(
                  padding: EdgeInsets.all(4.0),
              child: Text('',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold
                ),),
              ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              borderSide: BorderSide(color: Colors.grey[200])
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(18)),
              borderSide: BorderSide(color: Colors.grey[300])
            ),
            filled: true,
            fillColor: Colors.grey[100],
        ),
//                      maxLength: 10,
        controller: _controller,
        autovalidate: true,
        autocorrect: false,
        maxLengthEnforced: true,
//                      validator: (value) {
//                        return value != null
//                            ? 'Please provide a valid 10 digit phone number'
//                            : null;
//                      },
      ),


            ],
          ),
        ),
      ),
            RaisedButton(child: Text("submit"),
              textColor: Colors.white,
              onPressed: (){
                final userInfo =  _controller.text.trim();
                print(userInfo);
                Navigator.pop(context);
//                      loginUser(phone, context);
              },
              elevation: 10,
              color: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(25) ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0, size.height - 80);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 80);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}