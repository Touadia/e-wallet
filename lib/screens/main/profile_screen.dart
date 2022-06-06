import 'package:flutter/material.dart';
import 'package:up_pro_v2/widgets/profile_screen_widget.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ProfileHeader(),
              SizedBox(height: 30,),
              PersonalInfo(),
            ],
          ),
        ),
      ),
    );
  }
}

