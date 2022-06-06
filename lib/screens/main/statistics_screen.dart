import 'package:flutter/material.dart';
import 'package:up_pro_v2/widgets/stat_screen_widget.dart';

class StatScreen extends StatelessWidget {
  const StatScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TopBar(),
          TotalBalance(),
          BalanceStatistics(),
        ],
      ),
    );
  }
}
