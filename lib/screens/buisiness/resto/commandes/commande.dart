import 'dart:math';
import 'package:flutter/material.dart';
import 'package:up_pro_v2/constants.dart';
import 'package:up_pro_v2/models/Commande.dart';
import 'package:up_pro_v2/screens/routage.dart';
import 'package:up_pro_v2/variables/resto.dart';
import 'package:up_pro_v2/screens/buisiness/resto/commandes/commande_widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Commande extends StatefulWidget {
  final RestoPassedInfo data;
  Commande({Key key, this.data, id,}) : super(key: key);

  @override
  _CommandeState createState() => _CommandeState();
}

class _CommandeState extends State<Commande> {
  var _listCommande;
  var _listCommande2;
  var menuOption = PaquetMenu('Commande');

  @override
  void initState() {

    _listCommande2 = List.generate(listeCommande.length, (index) => Column(
      children: [
        MenuItemWidget(index: index, item: listeCommande[index], icon: menuOption.icon, quantite: listeCommande[index].quantite),
        Divider(indent: 20, endIndent: 20,),
      ],
    ));

    var random = Random();

    _listCommande = ListView.separated(
      itemCount: listeCommande.length,
      itemBuilder: (context, index) {
        return MenuItemWidget(index: index, item: listeCommande[index], icon: menuOption.icon, quantite: random.nextInt(5)+1,);
      },
      separatorBuilder: (context, index) => Divider(indent: 20, endIndent: 20,),
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      floatingActionButton: listeCommande.isNotEmpty ? FloatingActionButton.extended(
        label: Text('Valider', style: myStyle(15, myGrey1, 500),),
        icon: Icon(Icons.thumb_up_alt),
        backgroundColor: myGreen,
        splashColor: myGrey4,
        onPressed: () => myDialog(context),
      ) : FloatingActionButton(
        child: Text('Ø', style: myStyle(25, myGrey1, 500),),
        backgroundColor: myGrey4,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            header(context, size),
            SizedBox(height: size.height *60 /812,),
            Heading(title: 'Mon panier',),
            SizedBox(height: defaultPadding,),
            monPanierBuilder(size),
            SizedBox(height: defaultPadding,),
            Heading(title: 'Commande en cours',),
            mesCommadesBuilder(size),
            SizedBox(height: 80,),
          ],
        ),
      ),
    );
  }

  Container mesCommadesBuilder(Size size) {
    print(USER.persoId);
    return Container(
      width: size.width *.9,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('restaurants').doc(widget.data.id).collection('commandes').where('id du client',isEqualTo: USER.persoId).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError){
            print(snapshot.error);
            return Center(child: Text('Quelque chose ne va pas, rechargez la page !', style: TextStyle(fontSize: 20),));
          }
          if (snapshot.connectionState == ConnectionState.waiting){
            return Center(child: CircularProgressIndicator());
          }
          //le premier element de la site représente l'id et le deuxieme un map
          var commandes = snapshot.data.docs.map((e) => [e.id, e.data()]).toList();
          //print(snapshot.data.docs.first.id);
          return commandes.isNotEmpty ? Column(
            children: List.generate(commandes.length, (index)
            {
              var platCommande = CommandeNewVersion.testClient(commandes[index], DateTime.now());
              return Column(
                children: [
                  CommandeItemInfo(commande: platCommande,),
                  Divider(indent: 20, endIndent: 20,),
                ],
              );
            }
            ),
          ) : SizedBox(
            height:100,
            child: Center(child: Text("Vous n'avez pas de commandes en cours !", style: myStyle(20, myGrey2, 800),)),
          );
          },
      ),
    ) ;
  }

  NotificationListener<DeleteMenuItemNotification> monPanierBuilder(Size size) {
    return NotificationListener<DeleteMenuItemNotification>(
            child: Container(
              //height: size.height *550 /812,
              width: size.width *.9,
              child: listeCommande.length > 0 ?
              MenuList(
                //list: _listCommande,
                list2: _listCommande2,
                menuOption: menuOption,
              ) :
              SizedBox(
                height: 100,
                child: Center(
                  child: Text(
                    'Aucun menu selectionné pour le moment',
                    style: myStyle(20, myGrey2, 800),
                  ),
                ),
              ),
            ),
            onNotification: (notification){
              setState(() {
                listeCommande.removeAt(notification.index);
                buildListView();
              });
              return true;
            },
          );
  }

  Row header(BuildContext context, Size size) {
    return Row(
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
          );
  }

  void buildListView(){
    _listCommande2 = List.generate(listeCommande.length, (index) => Column(
      children: [
        MenuItemWidget(index: index, item: listeCommande[index], icon: iconCat2[listeCommande[index].categorie], quantite: listeCommande[index].quantite),
        Divider(indent: 20, endIndent: 20,),
      ],
    ));
    _listCommande = ListView.separated(
      itemCount: listeCommande.length,
      itemBuilder: (context, index) {
        return MenuItemWidget(index: index, item: listeCommande[index], icon: menuOption.icon, quantite: listeCommande[index].quantite);
      },
      separatorBuilder: (context, index) => Divider(indent: 20, endIndent: 20,),
    );
  }

  void myDialog (BuildContext context)  {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        backgroundColor: myGrey1.withOpacity(.9),
        title: Text('Confirmation de commande', style: Theme.of(context).textTheme.headline5,),
        content: Container(
          child: Text('Etes-vous sûr•e de vouloir valider vos commandes ?', style: Theme.of(context).textTheme.subtitle1,),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context, 'Non');
            },
            child: const Text('Non', style: TextStyle(fontSize: 20),),
          ),

          SizedBox(width: 100,),

          TextButton(
            onPressed: () {
              if(listeCommande.isNotEmpty){
                for(var commande in listeCommande){
                  FirebaseFirestore
                      .instance
                      .collection('restaurants')
                      .doc(widget.data.id)
                      .collection('commandes').add({
                    'categorie':commande.categorie,
                    'date': fromDateTime(DateTime.now()),
                    'etat': .05,
                    'id du restaurant': widget.data.id,
                    'nom': commande.nomMenu,
                    'nom du client': USER.nom,
                    'id du client': USER.persoId,
                    'numero de table': "7",
                    'prix': commande.prix,
                    'quantite': commande.quantite,
                  })
                  ;
                }
              }
              setState(() {
                listeCommande = [];
              });
              Navigator.pop(context, 'Oui');
              buildListView();
            },
            child: Text('Oui', style: TextStyle(fontSize: 20),),
          ),
        ],
      ),
    );
  }
}

Map iconCat2 = {
  'entrees': Icon(Icons.restaurant, color: myGrey4,size: 50,),
  'plats': Icon(Icons.room_service_rounded, color: myGrey4,size: 50,),
  'desserts': Icon(Icons.icecream, color: myGrey4,size: 50,),
  'boissons': Icon(Icons.wine_bar_rounded, color: myGrey4,size: 50,),
  'plats du jour' : Icon(Icons.new_releases_rounded, color: myGrey4,size: 50,),
};
