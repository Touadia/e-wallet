import 'package:flutter/material.dart';
import '../constants.dart';

class NavBar extends StatefulWidget {
  const NavBar({Key key}) : super(key: key);

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  int _currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    double iconSize = size.height *.030;
    double textSize = iconSize /25;
    double iconBoxSize = size.height * .13 *6 /11;
    return Container(
      height: size.height * .07,
      width: size.width * .9,
      decoration: BoxDecoration(
          color: myWhite,
          borderRadius: BorderRadius.all(Radius.circular(15)),
          boxShadow: [
            BoxShadow(offset: Offset(3,5),blurRadius: 33, color: myShadowColor)
          ]
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          GestureDetector(
            onTap: () {
              _toggleColor(1);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home_rounded, color: _currentIndex==1 ? myGrey4 : myGrey1, size: iconSize,),
                if(_currentIndex==1) Icon(Icons.circle, color: myGrey4, size: iconSize *.2,),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              _toggleColor(2);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.account_balance_wallet_rounded, color: _currentIndex==2 ? myGrey4 : myGrey1, size: iconSize,),
                if(_currentIndex==2) Icon(Icons.circle, color: myGrey4, size: iconSize *.2,),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              _toggleColor(3);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.bar_chart, color: _currentIndex==3 ? myGrey4 : myGrey1, size: iconSize,),
                if(_currentIndex==3) Icon(Icons.circle, color: myGrey4, size: iconSize *.2,),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              _toggleColor(4);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_rounded, color: _currentIndex==4 ? myGrey4 : myGrey1, size: iconSize,),
                if(_currentIndex==4) Icon(Icons.circle, color: myGrey4, size: iconSize *.2,),
              ],
            ),
          ),
        ],
      ),
    );
  }
  int _toggleColor (int next){
    setState(() {
      _currentIndex = next;
      SwitchChanged(_currentIndex).dispatch(context);
      //print(_currentIndex);
    });
    return _currentIndex;
  }

  int getCurrentIndex(){
    return _currentIndex;
  }

}

class SwitchChanged extends Notification {
  final val;
  SwitchChanged(this.val);
}
