import 'package:flutter/material.dart';
import 'package:up_pro_v2/constants.dart';
import 'package:up_pro_v2/models/resto.dart';
import 'package:up_pro_v2/screens/routage.dart';
import 'dart:async';


class Menu extends StatefulWidget {
  final RestoPassedInfo data;
  SingleRestoRepository _restoStream;
  Menu({Key key, this.data,}) : super(key: key){
    _restoStream = SingleRestoRepository(id: data.id);
  }

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  var _myStream;

  @override
  void initState() {
    _myStream = widget._restoStream.getStream();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                Container(
                  width: MediaQuery.of(context).size.width * 328 /375,
                  height: MediaQuery.of(context).size.height * 186 /812,
                  decoration: BoxDecoration(
                    color: myGrey4,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(56)),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: 30,
                        bottom: 56,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(widget.data.nom, style: TextStyle(fontFamily: 'Montserrat', color: myGrey1, fontSize: 25, fontWeight: FontWeight.w900),),
                            Text(widget.data.localisation, style: TextStyle(fontFamily: 'Montserrat', color: myGrey1, fontSize: 15, fontWeight: FontWeight.bold),),
                          ],
                        ),
                      ),
                      Positioned(
                        left: 25,
                        bottom: 46,
                        child: Container(
                          width: MediaQuery.of(context).size.width *42 /375,
                          height: MediaQuery.of(context).size.width *42 /375 *63 /42,
                          decoration: BoxDecoration(
                            color: myGrey1,
                            borderRadius: BorderRadius.all(Radius.circular(21)),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(widget.data.note.toString(), style: TextStyle(fontFamily: 'Montserrat', color: myGrey4, fontSize: 15, fontWeight: FontWeight.bold),),
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
            SizedBox(height: 60,),
            Heading(title: 'Menu',data: widget.data),
            SizedBox(height: 42,),
          ],
        ),
      ),
    );
  }
}


class Heading extends StatelessWidget {
  final String title;
  final RestoPassedInfo data;

  const Heading({Key key, this.title, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('$title', style: TextStyle(fontFamily: 'Montserrat', color: myGrey4, fontSize: 15, fontWeight: FontWeight.w800),),
          SizedBox(height: 5,),
          Divider(color: myGrey4, thickness: 1, indent: 82.5, endIndent: 82.5,),
          SizedBox(height: 30,),
          //MyExpansionList(),
          GestureDetector(
            onTap: (){
              Flurorouter.router.navigateTo(
                context,
                '/menu/categoryMenu',
                routeSettings: RouteSettings(
                  arguments: RestoPassedInfo(nom: data.nom, localisation: data.localisation, id: data.id, note: data.note, categorie: ['Les plats du jour', 'plats du jour']),
                ),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width *335 /375,
              height: MediaQuery.of(context).size.width *335 /375 *70 /335,
              decoration: BoxDecoration(
                color: myGrey1,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(child: Text('Les plats du jour', style: myStyle(19, myGrey4, 0),)),
            ),
          ),
          SizedBox(height: 20,),
          GestureDetector(
            onTap: (){
              Flurorouter.router.navigateTo(
                context,
                '/menu/categoryMenu',
                routeSettings: RouteSettings(
                  arguments: RestoPassedInfo(nom: data.nom, localisation: data.localisation, id: data.id, note: data.note, categorie: ['Nos entrées', 'entrees']),
                ),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width *335 /375,
              height: MediaQuery.of(context).size.width *335 /375 *70 /335,
              decoration: BoxDecoration(
                color: myGrey4,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(child: Text('Nos entrées', style: myStyle(19, myGrey1, 0),)),
            ),
          ),
          SizedBox(height: 30,),
          GestureDetector(
            onTap: (){
              Flurorouter.router.navigateTo(
                context,
                '/menu/categoryMenu',
                routeSettings: RouteSettings(
                  arguments: RestoPassedInfo(nom: data.nom, localisation: data.localisation, id: data.id, note: data.note, categorie: ['Nos plats', 'plats']),
                ),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width *335 /375,
              height: MediaQuery.of(context).size.width *335 /375 *70 /335,
              decoration: BoxDecoration(
                color: myGrey1,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(child: Text('Nos plats', style: myStyle(19, myGrey4, 0),)),
            ),
          ),
          SizedBox(height: 30,),
          GestureDetector(
            onTap: (){
              Flurorouter.router.navigateTo(
                context,
                '/menu/categoryMenu',
                routeSettings: RouteSettings(
                  arguments: RestoPassedInfo(nom: data.nom, localisation: data.localisation, id: data.id, note: data.note, categorie: ['Nos desserts', 'desserts']),
                ),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width *335 /375,
              height: MediaQuery.of(context).size.width *335 /375 *70 /335,
              decoration: BoxDecoration(
                color: myGrey4,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(child: Text('Nos desserts', style: myStyle(19, myGrey1, 0),)),
            ),
          ),
          SizedBox(height: 30,),
          GestureDetector(
            onTap: (){
              Flurorouter.router.navigateTo(
                context,
                '/menu/categoryMenu',
                routeSettings: RouteSettings(
                  arguments: RestoPassedInfo(nom: data.nom, localisation: data.localisation, id: data.id, note: data.note, categorie: ['Nos boissons', 'boissons']),
                ),
              );
            },
            child: Container(
              width: MediaQuery.of(context).size.width *335 /375,
              height: MediaQuery.of(context).size.width *335 /375 *70 /335,
              decoration: BoxDecoration(
                color: myGrey1,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(child: Text('Nos boissons', style: myStyle(19, myGrey4, 0),)),
            ),
          ),
        ],
      ),
    );
  }
}

class TodayMenuItem{
  String label;
  String prix;

  TodayMenuItem({this.label, this.prix});

  static List<TodayMenuItem> generate(int i){
    return List<TodayMenuItem>.generate(i, (index) => TodayMenuItem(label: 'Plat ${index+1}', prix: '10000 Frs CFA'));
  }
}

List<TodayMenuItem> myItemList ;

class MyExpansionList extends StatefulWidget {
  const MyExpansionList({Key key}) : super(key: key);

  @override
  _MyExpansionListState createState() => _MyExpansionListState();
}

class _MyExpansionListState extends State<MyExpansionList> {
  var _title = 'Plat(s) du jour';
  double _height = 80;
  bool _isSelected = false;
  bool _canBeShown = false;
  Timer _timer;
  int _numMenuItem = 5;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      width: MediaQuery.of(context).size.width *335 /375,
      height: _height,
      duration: Duration(milliseconds: 700),
      curve: Curves.easeOutCirc,
      decoration: BoxDecoration(
        color: myGrey4,
        borderRadius: BorderRadius.circular(25),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              setState(() {
                _isSelected = !_isSelected;
                _height = _isSelected ? (80 + 72*_numMenuItem).toDouble() : 80;
                if (_isSelected) {
                  _timer = Timer(Duration(milliseconds: 500), () {
                    setState(() {
                      _canBeShown = !_canBeShown;
                    });
                  });
                } else {
                  _timer = Timer(Duration(milliseconds: 10), () {
                    setState(() {
                      _canBeShown = !_canBeShown;
                    });
                  });
                }
                });
            },
            child: Container(
              height: 70,
              width: MediaQuery.of(context).size.width *.8,
              decoration: BoxDecoration(
                color: myGrey4,
                borderRadius: BorderRadius.circular(25),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(_title, style: myStyle(20, myGrey1, 900),),
                      Icon(_isSelected ? Icons.keyboard_arrow_up_rounded : Icons.keyboard_arrow_down_rounded, color: myGrey1,),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Divider(color: myGrey, thickness: 2, indent: 50, endIndent: 50,),
                ],
              ),
            ),
          ),
          for (var element in TodayMenuItem.generate(_numMenuItem)) if (_canBeShown)
            ListTile(
              leading: Icon(Icons.restaurant_menu, color: myGrey1,),
              title: Text(element.label, style: myStyle(15, myGrey1, 500),),
              subtitle: Text(element.prix, style: myStyle(12, myGrey2, 100),),
            ),
        ],
      ),
    );
  }
}
