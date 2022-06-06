import 'package:flutter/material.dart';
import 'package:up_pro_v2/screens/auth/signIn.dart';
import 'package:up_pro_v2/utils/authentification.dart';
import 'package:up_pro_v2/variables/resto.dart';

import '../constants.dart';

class ProfileHeader extends StatefulWidget {
  const ProfileHeader({Key key}) : super(key: key);

  @override
  _ProfileHeaderState createState() => _ProfileHeaderState();
}

class _ProfileHeaderState extends State<ProfileHeader> {

  Route _routeToSignInScreen() {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => SignIn(),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset(-1.0, 0.0);
        var end = Offset.zero;
        var curve = Curves.ease;

        var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

        return SlideTransition(
          position: animation.drive(tween),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Align(
          alignment: Alignment.lerp(Alignment.center, Alignment.centerRight, .8),
          child: CircleAvatar(
            foregroundColor: myGrey,
            backgroundColor: Colors.red,
            child: IconButton(
              icon: Icon(Icons.logout),
              onPressed: () async {
                await Authentication.googleSignOut(context: context);
                Navigator.of(context).pushReplacement(_routeToSignInScreen());
              },
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 20),
          width: size.width /3,
          height: size.width /3,
          decoration: BoxDecoration(
            color: myGrey4,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: myGrey4),
            image: DecorationImage(
              image: NetworkImage("${USER.photoURL}",),
              fit: BoxFit.cover
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 30),
          child: Text('${USER.nom}', style: myStyle(20, myGrey3, 500),),
        ),
      ],
    );
  }
}

class PersonalInfo extends StatefulWidget {
  const PersonalInfo({Key key}) : super(key: key);

  @override
  _PersonalInfoState createState() => _PersonalInfoState();
}

class _PersonalInfoState extends State<PersonalInfo> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Information personnelle', style: myStyle(17, myGrey4, 500),),
        columnInfo('Nom','${USER.nom}', Icons.qr_code_rounded, Icons.remove_red_eye_rounded, size),
      ],
    );
  }

  Widget columnInfo(String label, String info, IconData icon1, IconData icon2, Size screenSize){
    return Container(
      margin: EdgeInsets.only(top: 10),
      width: screenSize.width *.90,
      height: 60,
      decoration: BoxDecoration(
        color: myGrey1.withOpacity(.3),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        children: [
          SizedBox(width: 20,),
          Icon(icon1, color: Colors.lightBlue, size: 38,),
          SizedBox(width: 10),
          Text('Mon QR Code', style: myStyle(17, myGrey4, 100),),
          Spacer(),
          Icon(icon2, color: myGrey3,),
          SizedBox(width: 20,),
        ],
      ),
    );
  }
}