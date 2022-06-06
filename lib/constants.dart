import 'package:flutter/material.dart';

const myGreen = Color(0xFF0e7660);
const myGrey = Color(0xFFf6f6f6);
const myWhite = Colors.white;
final myShadowColor = Color(0xFFD3D3D3).withOpacity(.8);


const myGrey4 = Color(0xFF323335);
const myGrey3 = Color(0xFF8e9093);
const myGrey2 = Color(0xFFbabbbe);
const myGrey1 = Color(0xFFe8e8e9);
const defaultPadding = 16.0;


final fontFamily = 'Montserrat';

TextStyle myStyle (double size, Color color, int w) {
  switch (w){
    case 0:{
      return TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: color, fontSize: size);
    }
    break;

    case 900:{
      return TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w900, color: color, fontSize: size);
    }
    break;

    case 700:{
      return TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w700, color: color, fontSize: size);
    }
    break;

    case 400:{
      return TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w400, color: color, fontSize: size);
    }
    break;

    case 100:{
      return TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w100, color: color, fontSize: size);
    }

    default:{
      return TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, color: color, fontSize: size);
    }

  }

}