import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:up_pro_v2/constants.dart';
import 'package:up_pro_v2/models/perso.dart';
import 'package:up_pro_v2/screens/main/home_screen.dart';
import 'package:up_pro_v2/screens/main/profile_screen.dart';
import 'package:up_pro_v2/screens/buisiness/business_screen.dart';
import 'package:up_pro_v2/screens/main/statistics_screen.dart';
import 'package:up_pro_v2/variables/resto.dart';
import 'package:up_pro_v2/widgets/nav_bar.dart';


class MainScreen extends StatefulWidget {
  final User user;
  const MainScreen({Key key, this.user}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  Stream<DocumentSnapshot<Map<String, dynamic>>> _userDocument;

  void initState(){
    User fireCurrentUser = FirebaseAuth.instance.currentUser;
    _userDocument = FirebaseFirestore.instance.collection('utilisateurs').doc(widget.user.uid).snapshots();
    USER = Utilisateur.fromGoogleUser(widget.user);
    repository.fillIdList();
    super.initState();
  }

  List<Widget> _myScreenList = <Widget>[
    Text('Error on main screen'),
    HomeScreen(),
    TransactionsScreen(),
    StatScreen(),
    ProfileScreen(),
  ];
  int _currentIndex = 1 ;

  @override
  Widget build(BuildContext context) {
    //print(USER);
    Size size = MediaQuery.of(context).size;

    return
      Scaffold(
        backgroundColor: myWhite,
        body: Container(
          height: size.height,
          child: NotificationListener(
            onNotification: (notification) {
              if (notification is SwitchChanged) {
                print('notification is $notification');
                setState(() {
                  _currentIndex = notification.val;
                });
              }
              //print(notification.val);
              return true;
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                StreamBuilder(
                  stream: _userDocument,
                  builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
                    if (snapshot.hasError) {
                      return Text('Something went wrong');
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Text("Loading");
                    }
                    /*print('Moi : $USER');
                    print(snapshot.hasData);
                    print(widget.user.uid);*/
                    return Align(
                      alignment: Alignment.topCenter,
                      child: _myScreenList[_currentIndex],
                    );
                  }
                ),
                Positioned(
                  bottom: 15,
                  child: NavBar(),
                )
              ],
            ),
          ),
        )
    );
  }

}
