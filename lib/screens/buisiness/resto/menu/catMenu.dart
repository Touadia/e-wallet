import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:up_pro_v2/constants.dart';
import 'package:up_pro_v2/models/Commande.dart';
import 'package:up_pro_v2/models/MenuInfo.dart';
import 'package:up_pro_v2/models/resto.dart';
import 'package:up_pro_v2/screens/routage.dart';
import 'package:up_pro_v2/variables/resto.dart';


class CategoryMenu extends StatefulWidget {
  final RestoPassedInfo data;
  SingleRestoRepository _restoStream;
  CategoryMenu({Key key, this.data,}) : super(key: key){
    _restoStream = SingleRestoRepository(id: data.id, categorie: data.categorie[1]);
  }

  @override
  _CategoryMenuState createState() => _CategoryMenuState();
}

class _CategoryMenuState extends State<CategoryMenu> {

  Widget _buildListItem(BuildContext context, DocumentSnapshot document){
    var size = MediaQuery.of(context).size;
    var menuOption = PaquetMenu(widget.data.categorie[0]);
    var plat = CommandeNewVersion(nom:document['nom'], cat: widget.data.categorie[0], prix: document['prix']);
    return MenuItemWidget(size: size, item: plat, icon: menuOption.icon,);
  }

  /*Widget _buildList(BuildContext context, DocumentSnapshot document) {
    //var _items = mapListMenu[menuOption.title];
    var size = MediaQuery.of(context).size;
    return ListView.separated(
      itemCount: _items.length+1,
      itemBuilder: (context, index) {
        if (index != _items.length) {
          return MenuItemWidget(size: size, item: _items[index], icon: menuOption.icon);
        }else{
          return SizedBox(height: size.height *40 /812,);
        }
      },
      separatorBuilder: (context, index) {
        if (index != _items.length-1) {
          return Divider(indent: 20, endIndent: 20,);
          // ignore: missing_return
        }else{
          return Icon(Icons.more_horiz_outlined);
        }
      },
    );
  }*/

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Flurorouter.router.navigateTo(
            context,
            '/commande',
            routeSettings: RouteSettings(
              arguments: RestoPassedInfo(nom: widget.data.nom, localisation: widget.data.localisation, id: widget.data.id, note: widget.data.note),
            ),
          );
        },
        child: Icon(Icons.shopping_basket_outlined),
        backgroundColor: myGrey4,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
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
                  width: size.width *328 /375,
                  height: size.height *186 /812,
                  decoration: BoxDecoration(
                    color: myGrey4,
                    borderRadius: BorderRadius.only(bottomLeft: Radius.circular(56)),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: size.width *30 /375,
                        bottom: size.height *56 /812,
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
                          width: size.width *42 /375,
                          height: size.width *42 /375 *63 /42,
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
            SizedBox(height: size.height *60 /812,),
            Heading(title: widget.data.categorie[0],),
            //SizedBox(height: 10,),
            StreamBuilder(
              stream: widget._restoStream.getCategoryStream(),
              builder: (context, snapshot) {
                if (snapshot.hasError){
                  return Center(child: Text('Something wrong'));
                }
                if(!snapshot.hasData){
                  return Center(child: CircularProgressIndicator());
                }
                var catList = snapshot.data.docs;
                return catList.length == 0 ? Container(height: size.height *450 /812, width: size.width *.9, child: Center(child: Text('Pas ${widget.data.categorie[1] == 'entrees' ? 'd\'entrées' : 'de ${widget.data.categorie[1]}'} pour le moment', style: myStyle(20, myGrey2, 800),),),) :
                Container(
                  height: size.height *550 /812,
                  child: /*MenuList(len: 9,menuOption: menuOption,)*/ ListView.separated(
                    itemCount: catList.length+1,
                    itemBuilder: (context, index){
                      if (index != catList.length){
                        return _buildListItem(context, snapshot.data.docs[index]);
                      }
                      else{
                        return SizedBox(height: size.height *40 /812,);
                      }
                    },
                    separatorBuilder: (context, index) {
                      if (index != catList.length-1) {
                        return Divider(indent: 20, endIndent: 20,);
                        // ignore: missing_return
                      }else{
                        return Icon(Icons.more_horiz_outlined);
                      }
                    },
                  ),
                );
              }
            ),
            //SizedBox(height: size.height *30 /812,),
          ],
        ),
      ),
    );
  }
}

class PaquetMenu{
  String title;
  IconData icon;
  PaquetMenu(String title){
    this.title = title;
    switch (title){
      case 'Nos entrées': {icon = Icons.restaurant;}
      break;

      case 'Nos plats': {icon = Icons.room_service;}
      break;

      case 'Nos desserts': {icon = Icons.icecream;}
      break;

      case 'Nos boissons': {icon = Icons.local_bar;}
      break;

      case 'Les plats du jour': {icon = Icons.new_releases_rounded;}
      break;
    }
  }
}


class Heading extends StatelessWidget {
  final String title;
  const Heading({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text('$title', style: TextStyle(fontFamily: 'Montserrat', color: myGrey4, fontSize: 15, fontWeight: FontWeight.w800),),
          SizedBox(height: 5,),
          Divider(color: myGrey4, thickness: 1, indent: 82.5, endIndent: 82.5,),
        ],
      ),
    );
  }
}

/*class MenuList extends StatelessWidget {
  final int len;
  final PaquetMenu menuOption;
  const MenuList({Key key, this.len, this.menuOption}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _items = mapListMenu[menuOption.title];
    var size = MediaQuery.of(context).size;
    return ListView.separated(
      itemCount: _items.length+1,
      itemBuilder: (context, index) {
        if (index != _items.length) {
          return MenuItemWidget(size: size, item: _items[index], icon: menuOption.icon);
        }else{
          return SizedBox(height: size.height *40 /812,);
        }
      },
      separatorBuilder: (context, index) {
        if (index != _items.length-1) {
          return Divider(indent: 20, endIndent: 20,);
        // ignore: missing_return
        }else{
          return Icon(Icons.more_horiz_outlined);
        }
      },
    );
  }
}*/


class MenuItemWidget extends StatefulWidget {

  const MenuItemWidget({
    Key key,
    @required this.size,
    @required CommandeNewVersion item, this.icon,
  }) : _item = item, super(key: key);

  final Size size;
  final CommandeNewVersion _item;
  final IconData icon;

  @override
  _MenuItemWidgetState createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<MenuItemWidget> {
  int _quantite = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      //color: myGrey1,
      height: MediaQuery.of(context).size.height *90 /812,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: widget.size.width *15 /375),
              child: Icon(widget.icon, color: myGrey4,size: 50,),
            ),
          ),
          Positioned(
            //alignment: Alignment.lerp(Alignment.centerLeft, Alignment.centerRight, .3),
            left: 102,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: widget.size.height *15 /812,),
                Container(width: 150,child: Text(widget._item.nomMenu, style: myStyle(15, myGrey4, 500),maxLines: 3,)),
                SizedBox(height: widget.size.height *10 /812,),
                Text('${widget._item.prix.toInt().toString()} Frs', style: myStyle(12, myGrey3, 100),),
              ],
            ),
          ),
          Align(
            alignment: Alignment.lerp(Alignment.center, Alignment.centerRight, .5),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Quantité', style: myStyle(12, myGrey3, 100),),
                SizedBox(height: widget.size.height *5 /812,),
                Text('$_quantite', style: myStyle(17, myGrey4, 100),),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(icon: Icon(Icons.add_box), iconSize: 35, onPressed: increment,splashRadius: 25,),
                IconButton(icon: Icon(Icons.indeterminate_check_box_outlined), onPressed: decrement,splashRadius: 20,),
              ],
            ),
          ),
        ]
      ),
    );
  }

  void increment(){
    setState(() {
      _quantite ++;
      var x = CommandeNewVersion(
        cat: categorieMenu[widget._item.categorie],
        nom: widget._item.nomMenu,
        prix: widget._item.prix,
        quantite: _quantite,
      );
      listeCommande.forEach((element) => print("${element.nomMenu == x.nomMenu} ${element.categorie == x.categorie}"));
      var contain = listeCommande.where((element) => element.nomMenu == x.nomMenu && element.categorie == x.categorie);
      if (contain.isEmpty){
        listeCommande.add(x);
      }else{
        contain.first.quantite++;
      }
    });
  }

  void decrement(){
    setState(() {
      _quantite  = _quantite > 0 ? (_quantite - 1) : _quantite;
    });
  }
}

Map categorieMenu = {
  'Nos entrées':'entrees',
  'Nos plats':'plats',
  'Nos desserts':'desserts',
  'Nos boissons':'boissons',
  'Plat du jour' : 'plats du jour'
};