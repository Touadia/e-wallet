import 'package:flutter/material.dart';
import 'package:up_pro_v2/models/Commande.dart';
import 'package:up_pro_v2/models/resto.dart';
import '../../../../constants.dart';

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

class MenuList extends StatelessWidget {
  final int len;
  final PaquetMenu menuOption;
  final ListView list;
  final List list2;
  const MenuList({Key key, this.len, this.menuOption, this.list, this.list2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return list != null ? list : buildList2(context);
  }

  Widget buildList2(BuildContext context){
    return Column(
      children: [
        ...list2
      ],
    );
  }
}

// ignore: must_be_immutable
class MenuItemWidget extends StatefulWidget {

  MenuItemWidget({
    Key key,
    @required CommandeNewVersion item, this.icon, this.index, int quantite,
  }) : _item = item, super(key: key);

  final int index;
  CommandeNewVersion _item;
  final IconData icon;

  @override
  _MenuItemWidgetState createState() => _MenuItemWidgetState();
}

class _MenuItemWidgetState extends State<MenuItemWidget> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      //color: myGrey1,
      height: size.height *90 /812,
      child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: size.width *15 /375),
                child: iconCat[widget._item.categorie],
              ),
            ),
            Positioned(
              left: 102,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height *15 /812,),
                  Container(width: 140,child: Text(widget._item.nomMenu, style: myStyle(15, myGrey4, 500),maxLines: 3,)),
                  SizedBox(height: size.height *10 /812,),
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
                  SizedBox(height: size.height *5 /812,),
                  Text('${widget._item.quantite}', style: myStyle(17, myGrey4, 100),),
                ],
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(icon: Icon(Icons.add_box), iconSize: 35, onPressed: increment,splashRadius: 25,),
                  IconButton(
                    icon: Icon(Icons.indeterminate_check_box_outlined),
                    onPressed: decrement,
                    splashRadius: 20,),
                ],
              ),
            ),
          ]
      ),
    );
  }

  void increment(){
    setState(() {
      widget._item.quantite++;
    });
  }

  void decrement(){
    setState(() {
      if (widget._item.quantite > 1){
        widget._item.quantite--;
      }else{
        DeleteMenuItemNotification(index: widget.index).dispatch(context);
      }
    });
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

      default: {icon = Icons.brunch_dining;}
      break;
    }
  }
}

class DeleteMenuItemNotification extends Notification{
  final int index;
  DeleteMenuItemNotification({this.index});
}

class CommandeItemInfo extends StatelessWidget {
  final CommandeNewVersion commande;
  const CommandeItemInfo({Key key, this.commande}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      //color: myGrey1,
      height: size.height *90 /812,
      child: Stack(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: size.width *15 /375),
                child: iconCat[commande.categorie],
              ),
            ),
            Positioned(
              left: 102,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height *15 /812,),
                  Container(width: 160,child: Text(commande.nomMenu, style: myStyle(15, myGrey4, 500),maxLines: 2,overflow: TextOverflow.ellipsis,)),
                  SizedBox(height: size.height *10 /812,),
                  Text('${commande.prix.toString()} Frs', style: myStyle(12, myGrey3, 100),),
                ],
              ),
            ),
            Positioned(
              top: 70,
              right: 0,
              child: Text(commande.duree, style: myStyle(12, myGrey2, 100),),
            ),
            Positioned(
              top: 20,
              right: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Quantité', style: myStyle(12, myGrey3, 100),),
                  SizedBox(height: size.height *5 /812,),
                  Text('${commande.quantite}', style: myStyle(17, myGrey4, 100),),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: ProgressLine(color: myGrey2, percentage: (commande.etat * 100).toInt(),),
            ),
          ]
      ),
    );
  }
}

class ProgressLine extends StatelessWidget {
  const ProgressLine({
    Key key,
    this.color = myGrey2,
    @required this.percentage,
  }) : super(key: key);

  final Color color;
  final int percentage;

  @override
  Widget build(BuildContext context) {
    return Stack(
        children: [
          Container(
            width: double.infinity,
            height: 5,
            decoration: BoxDecoration(
              color: color.withOpacity(.1),
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
          ),
          LayoutBuilder(
            builder: (context, constraints) => Container(
              width: constraints.maxWidth * percentage/100,
              height: 5,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
            ),
          ),
        ]
    );
  }
}

Map iconCat = {
  'entrees': Icon(Icons.restaurant, color: myGrey4,size: 50,),
  'plats': Icon(Icons.room_service_rounded, color: myGrey4,size: 50,),
  'desserts': Icon(Icons.icecream, color: myGrey4,size: 50,),
  'boissons': Icon(Icons.wine_bar_rounded, color: myGrey4,size: 50,),
  'plats du jour' : Icon(Icons.new_releases_rounded, color: myGrey4,size: 50,),
};
