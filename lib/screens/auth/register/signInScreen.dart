import 'package:flutter/material.dart';
import 'package:up_pro_v2/screens/auth/register/signInWidget.dart';
import '../../../constants.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

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
            Center(child: Text('Connexion',style: TextStyle(color: myGrey4,fontSize: size.width*25/iphoneWidth,fontWeight: FontWeight.bold),)),
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
            SignInForm()
          ],
        ),
      ),
    );
  }
}

