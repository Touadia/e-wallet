import 'package:fluro/fluro.dart';
import 'package:up_pro_v2/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:up_pro_v2/models/resto.dart';
import 'package:up_pro_v2/widgets/business_screen_widget.dart';

import '../routage.dart';


class ListResto extends StatefulWidget {
  const ListResto({Key key}) : super(key: key);

  @override
  _ListRestoState createState() => _ListRestoState();
}

class _ListRestoState extends State<ListResto> {
  RestoDataRepository repository = RestoDataRepository();

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
    return Scaffold(
      body: Column(
        children: [
          ListRestoTopBar(title: 'Vos restaurants',),
          Expanded(
            child: StreamBuilder(
              stream: repository.getStream(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return LinearProgressIndicator();
                return ListView.builder(
                  itemExtent: 80,
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index){
                    //print(snapshot.data.docs[index]['nom']);
                    return _buildListItem(context, snapshot.data.docs[index]);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
