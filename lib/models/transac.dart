import 'package:up_pro_v2/models/perso.dart';
import 'package:up_pro_v2/models/resto.dart';

class Facture{
  Commande commande;
  Restaurant restaurant;
  Facture({this.commande, this.restaurant});

//Map <String, Dynamic> facture() => commande.listePlat.to;
}

class Transaction{
  DateTime date = DateTime.now();
  Personne expediteur;
  Restaurant restaurant;

  Transaction({this.expediteur, this.restaurant});
}
