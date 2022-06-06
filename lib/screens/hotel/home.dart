import 'package:flutter/material.dart';


class Hotel extends StatelessWidget {
  final param;
  const Hotel(this.param, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Hotel $param', style: TextStyle(fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.bold),),
      ),
    );
  }
}
