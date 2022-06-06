import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:up_pro_v2/constants.dart';
import 'package:up_pro_v2/models/resto.dart';
import 'package:up_pro_v2/screens/routage.dart';

class Restaurant extends StatefulWidget {
  final String id;
  final String name;
  SingleRestoRepository _restoStream;
  Restaurant({
    Key key,
    this.id,
    this.name,
  }) : super(key: key) {
    _restoStream = SingleRestoRepository(id: id);
  }

  @override
  _RestaurantState createState() => _RestaurantState();
}

class _RestaurantState extends State<Restaurant> {
  var _myStream;
  var _data;

  var _noteController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    _myStream = widget._restoStream.getStream();
    //myMethod();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  /*myMethod() async {
    var document = await FirebaseFirestore.instance
        .collection('restaurants')
        .doc(widget.id);
    var document2 = await document.get().then((value) => _data = value.data());
    //print(document2.toString());
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: _myStream,
        builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot){
          if(snapshot.hasError){
            return Text('Something wrong');
          }
          if(snapshot.connectionState == ConnectionState.active){
            var resto = snapshot.data.data();
            return buildRestaurantHomeScreen(context, resto);
          }
          return Center(child: CircularProgressIndicator());
        }),
    );
  }

  Column buildRestaurantHomeScreen(BuildContext context, Map<String, dynamic> resto) {
    return Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      Flurorouter.router.pop(context);
                    },
                    tooltip: 'Back',
                    enableFeedback: true,
                  ),
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 328 / 375,
                    height: MediaQuery
                        .of(context)
                        .size
                        .height * 186 / 812,
                    decoration: BoxDecoration(
                      color: myGrey4,
                      borderRadius:
                      BorderRadius.only(bottomLeft: Radius.circular(56)),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: 30,
                          bottom: 56,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                resto['nom'],
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: myGrey1,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w900),
                              ),
                              Text(
                                resto['localisation'],
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    color: myGrey1,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 25,
                          bottom: 46,
                          child: Container(
                            width: MediaQuery
                                .of(context)
                                .size
                                .width * 42 / 375,
                            height: MediaQuery
                                .of(context)
                                .size
                                .width *
                                42 /
                                375 *
                                63 /
                                42,
                            decoration: BoxDecoration(
                              color: myGrey1,
                              borderRadius: BorderRadius.all(
                                  Radius.circular(21)),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  resto['vote']['note'].toString(),
                                  style: TextStyle(
                                      fontFamily: 'Montserrat',
                                      color: myGrey4,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                Icon(Icons.auto_awesome),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              PositionTable(
                numTable: '7',
              ),
              SizedBox(
                height: 42,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryBox(
                      label: 'Menu',
                      colorBox: myGrey4,
                      colorText: myGrey2,
                      onTap: () {
                        Flurorouter.router.navigateTo(
                          context,
                          "/menu",
                          routeSettings: RouteSettings(
                            arguments: RestoPassedInfo(nom: resto['nom'], localisation: resto['localisation'], id: widget.id, note: resto['vote']['note']),
                          ),
                        );
                      },
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        /*Text(
                          'Plat du jour',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              color: myGrey2,
                              fontSize: 15,
                              fontWeight: FontWeight.w400),
                        ),*/
                        SizedBox(
                          height: 7,
                        ),
                        /*Container(
                          width: (MediaQuery
                              .of(context)
                              .size
                              .width -
                              MediaQuery
                                  .of(context)
                                  .size
                                  .width * 200 / 375 -
                              40) *
                              .9,
                          child: Text(
                            resto['plat du jour'],
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 13,
                                fontWeight: FontWeight.w100),
                            maxLines: 3,
                          ),
                        ),*/
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(height: 1,)
                        /*Text(
                          'Pizza royale',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 13,
                              fontWeight: FontWeight.w200),
                        ),
                        Text(
                          'Kedjenou de poulet',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 13,
                              fontWeight: FontWeight.w200),
                        ),
                        Text(
                          'Agouti braisé',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 13,
                              fontWeight: FontWeight.w200),
                        ),
                        Text(
                          'Cotelette d\'agneau',
                          style: TextStyle(
                              fontFamily: 'Montserrat',
                              fontSize: 13,
                              fontWeight: FontWeight.w200),
                        ),*/
                      ],
                    ),
                    CategoryBox(
                      label: 'Ma commande',
                      colorBox: myGrey1,
                      colorText: myGrey4,
                      onTap: () {
                        Flurorouter.router.navigateTo(
                          context,
                          "/commande",
                          routeSettings: RouteSettings(
                            arguments: RestoPassedInfo(nom: resto['nom'], localisation: resto['localisation'], id: widget.id, note: resto['vote']['note']),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CategoryBox(
                      label: 'Facture',
                      colorBox: myGrey4,
                      colorText: myGrey1,
                      onTap: () {
                        Flurorouter.router.navigateTo(
                          context,
                          "/facture",
                          routeSettings: RouteSettings(
                            arguments: RestoPassedInfo(nom: resto['nom'], localisation: resto['localisation'], id: widget.id, note: resto['vote']['note']),
                          ),
                        );
                      },
                    ),
                    /*Container(
                      width: (MediaQuery
                          .of(context)
                          .size
                          .width -
                          MediaQuery
                              .of(context)
                              .size
                              .width * 200 / 375 -
                          40) *
                          .9,
                      child: Text(
                        '28.790 Frs CFA',
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 13,
                            fontWeight: FontWeight.bold),
                      ),
                    ),*/
                  ],
                ),
              ),
              SizedBox(
                height: 76,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: (){},
                    splashColor: Colors.red,
                    borderRadius: BorderRadius.circular(26),
                    child: Container(
                      alignment: Alignment.center,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 100 / 375,
                      height:
                      MediaQuery
                          .of(context)
                          .size
                          .width * 100 / 375 * 40 / 115,
                      decoration: BoxDecoration(
                        color: myGrey1.withOpacity(.5),
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.person_search_rounded,
                            color: myGrey4,
                          ),
                          Container(
                              child: Text(
                                '  Aide',
                                style: TextStyle(
                                    fontFamily: 'Montserrat',
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                                maxLines: 2,
                              )),
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () => myDialog(context, resto['vote']),
                    splashColor: Colors.blue,
                    borderRadius: BorderRadius.circular(26),
                    child: Container(
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 100 / 375,
                      height:
                      MediaQuery
                          .of(context)
                          .size
                          .width * 100 / 375 * 40 / 115,
                      decoration: BoxDecoration(
                        color: myGrey1.withOpacity(.5),
                        borderRadius: BorderRadius.circular(26),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.auto_awesome,
                            color: myGrey4,
                          ),
                          Text(
                            '  Noter',
                            style: TextStyle(
                                fontFamily: 'Montserrat',
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
  }

  void myDialog (BuildContext context, Map vote,)  {
    setState(() {
      _noteController.text = vote['note'].toString();
    });
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: myGrey1.withOpacity(.9),
        title: Text('Note', style: Theme.of(context).textTheme.headline5,),
        content: Container(
          child: Text('Note : ${vote['note']}'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _noteController.text = '';
              });
              Navigator.pop(context, 'Cancel');
            },
            child: const Text('Annuler', style: TextStyle(fontSize: 20),),
          ),

          SizedBox(width: 100,),

          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Cancel');
            },
            child: Text('Modifier', style: TextStyle(fontSize: 20),),
          ),
        ],
      ),
    );
  }
}

class PositionTable extends StatelessWidget {
  final String numTable;
  const PositionTable({Key key, this.numTable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(
            'Vous êtes à la table $numTable',
            style: TextStyle(
                fontFamily: 'Montserrat',
                color: myGrey4,
                fontSize: 15,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 5,
          ),
          Divider(
            color: myGrey4,
            thickness: 1,
            indent: 82.5,
            endIndent: 82.5,
          ),
        ],
      ),
    );
  }
}

class CategoryBox extends StatelessWidget {
  final Color colorBox;
  final Color colorText;
  final String label;
  final onTap;

  const CategoryBox({
    Key key,
    this.colorBox,
    this.colorText,
    this.label,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width * 200 / 375,
        height: MediaQuery.of(context).size.width * 200 / 375 * 90 / 200,
        decoration: BoxDecoration(
          color: colorBox,
          borderRadius: BorderRadius.all(
              Radius.circular(MediaQuery.of(context).size.width * 15 / 375)),
        ),
        child: Text(
          label,
          style: TextStyle(
              fontFamily: 'Montserrat',
              color: colorText,
              fontSize: 15,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
