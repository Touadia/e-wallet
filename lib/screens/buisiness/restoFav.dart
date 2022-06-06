import 'package:fluro/fluro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:up_pro_v2/variables/resto.dart';
import 'package:up_pro_v2/widgets/business_screen_widget.dart';

import '../../constants.dart';
import '../routage.dart';


class ListRestoFav extends StatefulWidget {
  const ListRestoFav({Key key}) : super(key: key);

  @override
  _ListRestoFavState createState() => _ListRestoFavState();
}

class _ListRestoFavState extends State<ListRestoFav> {

  Widget _buildListItem(BuildContext context, DocumentSnapshot document){
    return GestureDetector(
      onTap: () {
        Flurorouter.router.navigateTo(context, "/resto/${document['nom']}/${document.id}", transition: TransitionType.fadeIn);
      },
      child: Container(
        height: MediaQuery.of(context).size.height *90 /812,
        child: Stack(
          children: [
            Align(alignment: Alignment.lerp(Alignment.centerLeft, Alignment.center, .07), child: CircleAvatar(child: Icon(Icons.restaurant))),
            Positioned(top: 10, left: 70, child: Text(document['nom'])),
            Align(alignment: Alignment.lerp(Alignment.center, Alignment.centerRight, .7), child: Text('id: ${document.id}')),
            Positioned(top: 35, left: 70, child: Column(crossAxisAlignment: CrossAxisAlignment.start,children: [Text(document['localisation']), Text(document['vote']['note'].toString())])),
            Align(alignment: Alignment.bottomCenter, child: Divider(indent: 20, endIndent: 20,)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    repository.fillIdList();
    return Scaffold(
      body: Column(
        children: [
          ListRestoTopBar(title: 'Vos restaurants ❤️',),
          if(repository.nombreDeFav() != 0)
            Expanded(
              child: StreamBuilder(
                stream: repository.getFavStream(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) return LinearProgressIndicator();
                  return buildListFav(snapshot);
                },
              ),
            ),
          if (repository.nombreDeFav() == 0)
            Container(height: size.height *450 /812, width: size.width *.9, child: Center(child: Text('Vous n\'avez pas encore choisi de restaurant préféré.', style: myStyle(20, myGrey2, 800),),),),
    ],
    ),
    );
  }

  Widget buildListFav(AsyncSnapshot snapshot) {
    return ListView.builder(
      itemExtent: 80,
      itemCount: snapshot.data.docs.length,
      itemBuilder: (context, index){
        //print(snapshot.data.docs[index]['nom']);
        return _buildListItem(context, snapshot.data.docs[index]);
        },
    );
  }
}
