import 'package:flutter/material.dart';
import 'package:up_pro_v2/screens/routage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(milliseconds: 2000), (){
      Flurorouter.router.pop(context);
      Flurorouter.router..navigateTo(context, '/signUp');
    });
    return Scaffold(
      body: Center(
        child: Text('Splash screen', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20, fontFamily: 'Montserrat'),),
      ),
    );
  }
}
