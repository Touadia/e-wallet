import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class Personne{
  String persoId;
  String nom;
  String email;
  String photoURL;
  String phoneNumber;
  String password;
}

class Utilisateur extends Personne{
  String numAccount;
  String country = 'CI';
  double balance;
  var historiqueTransaction = {
    'entrees': [],
    'sorties': [],
  };

  // Utilisateur({this.numCompte, this.googleInfo, String persoId, String nom, String prenoms,}) : super(persoId: persoId,nom: nom,);

  Utilisateur.fromGoogleUser(User user) {
    print('displayName ${user.displayName}');
    nom = user.displayName;
    persoId = user.uid;
    email = user.email;
    photoURL = user.photoURL;
    phoneNumber = user.phoneNumber;
    password = null;
  }

  @override
  String toString() {
    // TODO: implement toString
    return "name $nom" +
          "\npersoId $persoId" +
          "\nemail $email" +
        "\nphotoURL $photoURL" +
        "\nphoneNumber $phoneNumber" +
        "\npassword $password" +
        "\nnumAccount $numAccount" +
        "\nbalance ${balance == null ? 0 : balance} Frs";
  }

  /*Utilisateur.fromFirebaseDocument(CollectionReference doc){
    var value = doc.get();
    var docu = value.data['name'];
    name = doc['name'];
    persoId = user.uid;
    email = user.email;
    photoURL = user.photoURL;
    phoneNumber = user.phoneNumber;
    password = null;
  }*/
}

class Employe extends Personne{
  double note;
  CategorieEmploye cat;

  String get categorie => cat.toString().substring(17);

  Employe({this.note, this.cat, String persoId, String nom, String prenoms,});
}

enum CategorieEmploye {
  Serveur,
  Administrateur,
  Cuisto,
}
