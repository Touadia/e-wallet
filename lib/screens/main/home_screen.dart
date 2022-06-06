import 'package:flutter/material.dart';
import 'package:up_pro_v2/widgets/home_screen_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AccountInfo(),
            TransacHistory(),
          ],
        ),
      ),
    );
  }
}
