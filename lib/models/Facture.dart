import 'Commande.dart';
import 'MenuInfo.dart';

class FactureModel{
  String idFacture;
  String idClient;
  String idResto;
  String nomClient;
  String nomResto;
  DateTime date;
  num prixTotal;
  String etat;
  String modePayement;
  List<MenuInfo> commandes = [];

  FactureModel.fromData(List<dynamic> data){
    idFacture = data[0];
    Map dataMap = data[1] as Map;

    idClient = dataMap['id du client'];
    idResto = dataMap['id du restaurant'];
    nomClient = dataMap['nom du client'];
    nomResto = dataMap['nom du restaurant'];

    etat = dataMap['etat'];
    modePayement = dataMap['mode de payement'];

    date = fromTimestamp(dataMap['date']);
    prixTotal = dataMap['prix'];
    List com = dataMap['commandes'];
    com.forEach((element) {
      commandes.add(MenuInfo.forFacture(
        nom: element['nom du plat'],
        categorie: element['categorie'],
        quantite: element['quantite'],
        prix: element['prix'],
      ));
    });
  }
}