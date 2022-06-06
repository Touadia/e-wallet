import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:up_pro_v2/constants.dart';
import 'package:up_pro_v2/models/Commande.dart';
import 'package:up_pro_v2/models/Facture.dart';
import 'package:up_pro_v2/screens/routage.dart';
import 'package:up_pro_v2/variables/resto.dart';
import 'package:up_pro_v2/models/resto.dart';


class Facture extends StatefulWidget {
  final RestoPassedInfo data;
  Facture({Key key, this.data, id,}) : super(key: key);

  @override
  _FactureState createState() => _FactureState();
}

class _FactureState extends State<Facture> {
  var _listView;
  double total = 127380;
  var menuOption = PaquetMenu('Facture');

  @override
  void initState() {

    /*var random = Random();

    _listView = List.generate(listeCommande.length, (index) => Column(
      children: [
        MenuItemWidget(index: index, item: listeCommande[index], icon: menuOption.icon, quantite: listeCommande[index].quantite),
        Divider(indent: 20, endIndent: 20,),
      ],
    ));*/
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        label: Text('Payer', style: myStyle(15, myGrey1, 500),),
        icon: Icon(Icons.attach_money),
        backgroundColor: myGreen,
        splashColor: myGrey4,
        onPressed: () => myDialog(context),
      ),
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
            Heading(title: 'Facture',),
/*
            MenuList(list2: _listView,menuOption: menuOption,),
*/
            Container(
              width: size.width *.9,
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance.collection('restaurants').doc(widget.data.id).collection('transactions').where('id du client',isEqualTo: USER.persoId).where('etat',isEqualTo: "Non soldée").snapshots(),
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError){
                    print(snapshot.error);
                    return Center(child: Text('Quelque chose ne va pas, rechargez la page !', style: TextStyle(fontSize: 20),));
                  }
                  if (snapshot.connectionState == ConnectionState.waiting){
                    return Center(child: CircularProgressIndicator());
                  }
                  //le premier element de la site représente l'id et le deuxieme un map
                  var factures = snapshot.data.docs.map((e) => [e.id, e.data()]).toList();
                  /*return Container(width: size.width *.8, child: Align(alignment: Alignment.centerLeft, child: Text('Total : ${calculerTotal()} Francs CFA', style: myStyle(15, myGrey3, 600),)));*/
                  return factures.isNotEmpty ? Column(
                    children: List.generate(factures.length, (index)
                    {
                      return Column(
                        children: [
                          MenuItemWidget(item2: FactureModel.fromData(factures[index]),),
                          Divider(indent: 20, endIndent: 20,),
                        ],
                      );
                    }
                    ),
                  ) : SizedBox(
                    height:100,
                    child: Center(child: Text("Vous n'avez pas de factures à payer pour le moment !", style: myStyle(20, myGrey2, 800),)),
                  );
                }
              ),
            ),
          ],
        ),
      ),
    );
  }

  /*void buildListView(){
    _listView = List.generate(listeCommande.length, (index) => Column(
      children: [
        MenuItemWidget(index: index, item: listeCommande[index], icon: iconCat2[listeCommande[index].categorie], quantite: listeCommande[index].quantite),
        Divider(indent: 20, endIndent: 20,),
      ],
    ));
  }*/

  double calculerTotal(){
    total = 0;
    listeCommande.forEach((element) {total += element.quantite * element.prix;});
    return total;
  }

  void myDialog (BuildContext context)  {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: myGrey1,
        title: Text('Confirmation de payement', style: Theme.of(context).textTheme.headline5,),
        content: Container(
          child: Text('Vous allez procéder au paiement de vos factures...', style: Theme.of(context).textTheme.subtitle1,),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Annuler');
            },
            child: const Text('Annuler', style: TextStyle(fontSize: 20),),
          ),

          SizedBox(width: 100,),

          TextButton(
            onPressed: () async {
              var balance;
              var prix;
              var idfact;
              await FirebaseFirestore
                  .instance
                  .collection('utilisateurs')
                  .doc(USER.persoId)
                  .get().then((value) {
                    balance = value.data()['balance'];
              });
              await FirebaseFirestore.instance
                  .collection('restaurants')
                  .doc(widget.data.id)
                  .collection('transactions')
                  .where('id du client', isEqualTo: USER.persoId)
                  .where('etat',isEqualTo: 'Non soldée')
                  .limit(1)
                  .get()
                  .then((value) {
                    idfact = value.docs.first.id;
                    prix = value.docs.first.data()['prix'];
              });
              print('balance : $balance   prix : $prix');
              if(balance - prix >= 0){
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.green, content: Text('Paiement validé !')));
                await FirebaseFirestore
                    .instance
                    .collection('utilisateurs')
                    .doc(USER.persoId)
                    .update({
                  'balance' : FieldValue.increment(-prix),
                });
                await FirebaseFirestore.instance
                    .collection('restaurants')
                    .doc(widget.data.id)
                    .collection('transactions')
                    .doc(idfact).update({'etat' : 'Soldé'});
              }
              else {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(backgroundColor: Colors.red, content: Text('Paiement refusé, solde insuffisant !')));
              }
              Navigator.pop(context, 'Annuler');
            },
            child: Text('Continuer', style: TextStyle(fontSize: 20),),
          ),
        ],
      ),
    );
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
    CommandeNewVersion item, FactureModel item2, this.icon, this.index, int quantite,
  }) : _item = item, _item2 = item2, super(key: key);

  final int index;
  CommandeNewVersion _item;
  FactureModel _item2;
  final IconData icon;

  @override
  _MenuItemWidgetState createState() => _MenuItemWidgetState();
}


class _MenuItemWidgetState extends State<MenuItemWidget> {

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){},
      child: Container(
        //color: myGrey1,
        height: size.height *90 /812,
        child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  child: Icon(Icons.brunch_dining, color: myGrey4,size: 50,),
                ),
              ),
              Positioned(
                left: 102,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height *15 /812,),
                    Container(width: 140,child: Text(widget._item2.nomResto, style: myStyle(15, myGrey4, 500),maxLines: 3,)),
                    SizedBox(height: size.height *10 /812,),
                    Text('${widget._item2.prixTotal.toInt().toString()} Frs', style: myStyle(12, myGrey3, 100),),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.lerp(Alignment.center, Alignment.centerRight, .9),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Date', style: myStyle(12, myGrey3, 100),),
                    SizedBox(height: size.height *5 /812,),
                    Text('${getDate()}', style: myStyle(17, myGrey4, 100),),
                  ],
                ),
              ),
            ]
        ),
      ),
    );
  }

  String getDate() => "${widget._item2.date.day}/${widget._item2.date.month}/${widget._item2.date.year}   ${widget._item2.date.hour}:${widget._item2.date.minute}";
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

Map iconCat2 = {
  'entrees': Icon(Icons.restaurant, color: myGrey4,size: 50,),
  'plats': Icon(Icons.room_service_rounded, color: myGrey4,size: 50,),
  'desserts': Icon(Icons.icecream, color: myGrey4,size: 50,),
  'boissons': Icon(Icons.wine_bar_rounded, color: myGrey4,size: 50,),
  'plats du jour' : Icon(Icons.new_releases_rounded, color: myGrey4,size: 50,),
};
