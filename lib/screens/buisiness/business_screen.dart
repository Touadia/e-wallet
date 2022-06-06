import 'package:flutter/material.dart';
import 'package:up_pro_v2/widgets/business_screen_widget.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //var size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TopBar(title: 'Buisiness',),
            BusinessList(),
          ]
      ),
    );
  }
}