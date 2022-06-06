import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:password_dart/password_dart.dart';
import 'package:up_pro_v2/constants.dart';
import 'package:up_pro_v2/utils/authentification.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var iphoneWidth = 375;
    var iphoneHeight = 812;
    return Container(
      child:
      Column(
        children: [
          SizedBox(height: size.height* 61/iphoneHeight,),
          Center(child: Text('Inscription',style: TextStyle(color: myGrey4,fontSize: size.width*25/iphoneWidth,fontWeight: FontWeight.bold),)),
          SizedBox(height: size.height*44/iphoneHeight,),
          Container(
            width: size.width,
            height: size.height*200/iphoneHeight,
            decoration:BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/people_using_qr.jpg'),
                )
            ) ,
          ),
          SizedBox(height: size.height*46/iphoneHeight,),
          //SignInForm(),
          SizedBox(height: 10,),
        ],
      ),
    );
  }
}


