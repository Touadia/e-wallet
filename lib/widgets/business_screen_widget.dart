import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:up_pro_v2/constants.dart';
import '../screens/routage.dart';

class BusinessCard extends StatelessWidget {

  const BusinessCard({
    Key key,
    this.size,
    this.side,
    this.label,
    this.onTap,
  }) : super(key: key);

  final onTap;
  final Size size;
  final String side;
  final String label;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: side == 'left' ? Alignment.topLeft : Alignment.topRight,
        children: [
          Positioned(
            top: 13,
            child: Container(
              height: size.width * .40,
              width: size.width * .34 *3 /2,
              decoration: BoxDecoration(color: side == 'left' ? myGrey1 : myGrey3, borderRadius: BorderRadius.horizontal(left: Radius.circular(side == 'left' ? 0 : 40), right: Radius.circular(side == 'left' ? 40 : 0))),
            ),
          ),
          Positioned(
            top: 7,
            child: Container(
              height: size.width * .40,
              width: size.width * .37 *3 /2,
              decoration: BoxDecoration(
                color: side == 'left' ? myGrey4 : myGrey1,
                borderRadius: BorderRadius.horizontal(left: Radius.circular(side == 'left' ? 0 : 40), right: Radius.circular(side == 'left' ? 40 : 0)),
              ),
            ),
          ),
          Align(
            alignment: side == 'left' ? Alignment.topLeft : Alignment.topRight,
            child: Container(
              height: size.width * .40,
              width: size.width * .40 *3 /2,
              decoration: BoxDecoration(
                color: side == 'left' ? myGrey1 : myGrey4,
                borderRadius: BorderRadius.horizontal(left: Radius.circular(side == 'left' ? 0 : 40), right: Radius.circular(side == 'left' ? 40 : 0),),),
                child: Center(
                  child: Text(label, style: TextStyle(fontFamily: 'Montserrat', fontSize: 20, fontWeight: FontWeight.bold, color: side == 'left' ? myGrey4 : myGrey1,),),
                ),
              ),
            ),
          ],
      ),
    );
  }
}

class BusinessList extends StatelessWidget {
  const BusinessList({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height *.8,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Expanded(child: BusinessCard(size: size, side: 'left', label: 'Money exchange',)),
          Expanded(
            child: BusinessCard(
              size: size,
              side: 'right',
              label: 'Restaurants',
              onTap: () {
                Flurorouter.router.navigateTo(context, "/main/listResto", transition: TransitionType.fadeIn);
              },
            ),
          ),
          Expanded(
            child: BusinessCard(
              size: size,
              side: 'left',
              label: 'Restaurants favoris',
              onTap: () {
                Flurorouter.router.navigateTo(context, "/main/restoFav", transition: TransitionType.fadeIn);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TopBar extends StatefulWidget {
  final String title;

  const TopBar({
    this.title,
    Key key,
  }) : super(key: key);

  @override
  _TopBarState createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  String cameraScanResult;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          SizedBox(height: 70,),
          Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: '',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .apply(fontWeightDelta: 1),
                            children: [
                          TextSpan(
                              text: '${widget.title}.',
                              style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Montserrat'))
                        ])),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Manage your business and transactions',
                      style: TextStyle(color: myGrey2, fontSize: 12),
                    ),
                  ],
                ),
                Spacer(),
                Text('+', style: myStyle(20, myGrey4, 500),),
                IconButton(
                  icon: Icon(Icons.fastfood_sharp),
                  iconSize: 30,
                  onPressed: () => null,
                ),
              ]
          ),
          SizedBox(height: 20,),
        ],
      ),
    );
  }
}

class ListRestoTopBar extends StatelessWidget {
  final String title;

  const ListRestoTopBar({
    this.title,
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: size.height * .18,
        //decoration: BoxDecoration(color: myGrey),
        child: Column(
          children: [
            SizedBox(height: 70,),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: (){
                    Flurorouter.router.pop(context);
                  },
                  tooltip: 'Back',
                  enableFeedback: true,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: '',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .apply(fontWeightDelta: 1),
                            children: [
                              TextSpan(
                                  text: '${title == "Vos restaurants" ? '$title.' : title }',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Montserrat'))
                            ])),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Manage your business and transactions',
                      style: TextStyle(color: myGrey2, fontSize: 12),
                    ),
                  ],
                ),
                SizedBox(width: 24,),
                ],
            ),
            SizedBox(height: 20,),
          ],
        ),
      ),
    );
  }
}
