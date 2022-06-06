import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:up_pro_v2/variables/resto.dart';
import 'perso.dart';




//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class Restaurant{
  String name;
  String location;
  double note;

  Restaurant(this.name, {this.location, this.note});

  DocumentReference reference;

  factory Restaurant.fromSnapshot(DocumentSnapshot snapshot) {
    Restaurant newRestaurant = Restaurant.fromJson(snapshot.data());
    newRestaurant.reference = snapshot.reference;
    return newRestaurant;
  }

  ///Json

  factory Restaurant.fromJson(Map<String, dynamic> json) => _RestaurantFromJson(json);

  Map<String, dynamic> toJson() => _RestaurantToJson(this);

  String toString() => "Restaurant<$name>";
}

class RestoDataRepository {
  // 1
  final CollectionReference collection = FirebaseFirestore.instance.collection('restaurants');
  List restoFavIdList = [];
  bool isFilled = false;

  Future<List> fillIdList() async {
    if (!isFilled){
      List myListe = [];
      var list = (await FirebaseFirestore.instance
          .collection('utilisateurs')
          .doc(USER.persoId)
          .collection('restaurants fav')
          .orderBy('id')
          .get());
      for (var doc in list.docs) {
        myListe.add(doc.data()['id']);
      }
      myListe.forEach((element) => restoFavIdList.add(element));
      print(myListe);
      print(restoFavIdList);
      isFilled = true;
      return null;
    }
  }
  // 2
  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Stream<QuerySnapshot> getFavStream() {
    print(restoFavIdList[0].runtimeType);
    return collection.where('id du restaurant', whereIn: restoFavIdList).snapshots();
  }

  int nombreDeFav(){
    return restoFavIdList.length;
  }
  // 3
  Future<DocumentReference> addRestaurant(Restaurant restaurant) {
    return collection.add(restaurant.toJson());
  }
  // 4
  updateRestaurant(Restaurant restaurant) async {
    await collection.doc(restaurant.reference.id).update(restaurant.toJson());
  }
}

class SingleRestoRepository {
  String id;
  String categorie;
  DocumentReference<Map<String, dynamic>> collection1;
  CollectionReference<Map<String, dynamic>> collection2;
  SingleRestoRepository({this.id, this.categorie}){
    // 1
    collection1 = FirebaseFirestore.instance.collection('restaurants').doc(this.id);
    categorie != null ? collection2 = FirebaseFirestore.instance.collection('restaurants').doc(this.id).collection(categorie) : null;
  }
  // 2
  Stream<DocumentSnapshot<Map<String, dynamic>>> getStream() {
    print('restaurants/$id');
    return collection1.snapshots();
  }

  Stream<QuerySnapshot> getCategoryStream() {
    print('restaurants/$id/$categorie');
    return collection2.snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> get() {
    return collection1.get();
  }
  // 3
  Future<DocumentReference> addRestaurant(Restaurant restaurant) {
    return collection1.update(restaurant.toJson());
  }
  // 4
  /*updateRestaurant(Restaurant restaurant) async {
    await collection.doc(restaurant.reference.id).update(restaurant.toJson());
  }*/
}

Restaurant _RestaurantFromJson(Map<String, dynamic> json) {
  return Restaurant(
    json['name'] as String,
    location: json['notes'] as String,
    note: json['type'] as double,
  );
}

Map<String, dynamic> _RestaurantToJson(Restaurant instance) => <String, dynamic> {
  'name': instance.name,
  'location': instance.location,
  'note': instance.note,
};



//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class Plat{
  String label;
  String cat;
  num prix;

  Plat({this.label, this.cat, this.prix,});
}

class PlatCommande extends Plat{
  int quantite;
  num etat;
  DateTime heure;

  String get categorie => cat.toString().substring(13);

  PlatCommande({this.quantite : 0, this.etat : 0, this.heure, String label, String cat, num prix,}) : super(label: label, cat: cat, prix: prix);

  @override
  String toString() => '$cat $label, $prix frs, $quantite';

  static List<PlatCommande> generate(int i, {String type}){
    return List<PlatCommande>.generate(i, (index) => PlatCommande(label: 'Plat ${Random().nextInt(100)}', prix: (Random().nextInt(1000)+1000).toDouble(), quantite: Random().nextInt(5)+1, cat: type),);
  }
}

enum PlatCategorie{
  entree,
  plat,
  dessert,
  boisson,
}


//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


class Commande{
  Utilisateur perso;
  List<PlatCommande> listePlat = [];

  Commande({this.perso});

  void ajouterPlat(PlatCommande plat) => listePlat.add(plat);

  void retirerPlat() => null;
}

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

class Table{
  int num;
  List<Utilisateur> listClient = [];
  Restaurant resto;
  //QRCode qrCode;

  Table({this.num, this.resto});
}