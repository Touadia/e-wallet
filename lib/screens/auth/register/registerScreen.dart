import 'package:up_pro_v2/screens/auth/register/registerWidget.dart';
import 'package:flutter/material.dart';

import '../../../constants.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var iphoneWidth = 375;
    var iphoneHeight = 812;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height* 61/iphoneHeight,),
            Center(child: Text('Inscription',style: TextStyle(color: myGrey4,fontSize: size.width*25/iphoneWidth,fontWeight: FontWeight.bold),)),
            SizedBox(height: size.height*44/iphoneHeight,),
            Container(
              width: size.width,
              height: size.width * .7,
              decoration:BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/people_using_qr.jpg'),
                  )
              ) ,
            ),
            SizedBox(height: size.height*50/iphoneHeight,),
            SizedBox(height: 10,),
            RegisterForm()
          ],
        ),
      ),
    );
  }
}

