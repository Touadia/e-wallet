import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'MenuInfo.dart';

class CommandeNewVersion{
  String _tableId, _tableNum;
  String _clientId, _clientNom;
  String _commandeId;
  MenuInfo _plat;
  num _etat; // progression de la commande entre 0 et 1
  DateTime _date;
  String _duree;
  bool _methode;
  String _idRestaurant;
  
  String get nomMenu => _plat.nom;
  String get nomClient => _clientNom;
  String get categorie => _plat.categorie;
  String get numTable => _tableNum;
  String get duree => _duree;
  String get moment => "${_date.hour}:${_date.minute}";
  String get date => _date.toString();
  String get idRestaurant => _idRestaurant;
  String get commandeId => _commandeId;

  int get quantite => _plat.quantite;
  int get prix => _plat.prix;
  num get etat => _etat;
  bool get methode => _methode;

  set quantite(int qte){
    _plat.quantite = qte;
  }

  set etat(double state){
    _etat = state;
  }

  //Commande({this._tableId, this.tableNum, this.clientId, this.clientNom, this.commandeId, this.etat});

  CommandeNewVersion.testClient(List<dynamic> data, DateTime now){
    _commandeId = data[0];
    Map dataMap = data[1] as Map;
    _plat = MenuInfo.menuInfoforCommande(dataMap);
    _clientNom = dataMap['nom du client'];
    _tableNum = dataMap['numero de table'];
    _etat = dataMap['etat'];
    _date = fromTimestamp(dataMap['date']);
    _idRestaurant = dataMap['id du restaurant'];
    setDuree(now);
  }

  CommandeNewVersion({nom, cat, prix, quantite,}){
    _plat = MenuInfo(nom: nom, prix: prix, categorie: cat);
    _plat.quantite = quantite;
  }

  void setDuree(DateTime now) {
    Duration duration = now.difference(_date);
    if(duration.inMinutes == 0){
      _duree = 'A l\'instant';
    }
    else if(duration.inMinutes > 0 && duration.inMinutes <60){
      _duree = 'Il y a ${duration.inMinutes == 1 ? '${duration.inMinutes} minute' : '${duration.inMinutes} minutes'}';
    }
    else{
      _duree = 'Il y a ${duration.inHours == 1 ? '${duration.inHours} heure' : '${duration.inHours} heures'}';
    }
  }

  Map toJson() => {
    'id table' : _tableId,
    'numero de table' : _tableNum,
    'id client' : _clientId,
    'nom du client' : _clientNom,
    'etat' : _etat,
  };

}

//Column de la table de commande
//Total : Plat - Entrée - Client - Table - Date(heure)(il y a n minutes) - Etat - Methode(via l'appli ou non)
//Reduit : Plat - Table - Date(heure)(il y a n minutes)

DateTime fromTimestamp(Timestamp timestamp) => DateTime.parse(timestamp.toDate().toString());

Timestamp fromDateTime(DateTime date) => Timestamp.fromDate(date);

String getDuree(DateTime date) {
  Duration duration = DateTime.now().difference(date);
  if(duration.inMinutes == 0){
    return 'A l\'instant';
  }
  else if(duration.inMinutes > 0 && duration.inMinutes <60){
    return 'Il y a ${duration.inMinutes == 1 ? '${duration.inMinutes} minute' : '${duration.inMinutes} minutes'}';
  }
  else{
    return 'Il y a ${duration.inHours == 1 ? '${duration.inHours} heure' : '${duration.inHours} heures'}';
  }
}

Map iconCat = {
  'entrees': Icon(Icons.restaurant, color: myGrey4,size: 50,),
  'plats': Icon(Icons.room_service_rounded, color: myGrey4,size: 50,),
  'desserts': Icon(Icons.icecream, color: myGrey4,size: 50,),
  'boissons': Icon(Icons.wine_bar_rounded, color: myGrey4,size: 50,),
  'plats du jour' : Icon(Icons.new_releases_rounded, color: myGrey4,size: 50,),
};
