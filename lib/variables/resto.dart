import 'package:up_pro_v2/models/Commande.dart';
import 'package:up_pro_v2/models/perso.dart';
import 'package:up_pro_v2/models/resto.dart';
import 'package:faker/faker.dart';

var fake = Faker();

List<CommandeNewVersion> listeCommande = [];

const List<PlatCategorie> CATEGORIE = PlatCategorie.values;

/*List<PlatCommande> ENTREES =
[
  PlatCommande(label:'Salade complette', cat: CATEGORIE[0], prix: 1500),
  PlatCommande(label:'Crevette', cat: CATEGORIE[0], prix: 2600),
  PlatCommande(label:'Omelette', cat: CATEGORIE[0], prix: 1000),
  PlatCommande(label:'Crudité', cat: CATEGORIE[0], prix: 1500),
  PlatCommande(label:'Verines avocat', cat: CATEGORIE[0], prix: 1500),
  PlatCommande(label:'Fromage à la crême aux herbes et saumon fumé', cat: CATEGORIE[0], prix: 2500),
  PlatCommande(label:'Pomme de terre farcie', cat: CATEGORIE[0], prix: 1000),
  PlatCommande(label:'Salade catalane', cat: CATEGORIE[0], prix: 1750),
  PlatCommande(label:'Salade de courgette crue au citron vert', cat: CATEGORIE[0], prix: 1500),
];

List<PlatCommande> PLATS =
[
  PlatCommande(label:fake.food.restaurant(), cat: CATEGORIE[1], prix: 1500),
  PlatCommande(label:fake.food.restaurant(), cat: CATEGORIE[1], prix: 2600),
  PlatCommande(label:fake.food.restaurant(), cat: CATEGORIE[1], prix: 1000),
  PlatCommande(label:fake.food.restaurant(), cat: CATEGORIE[1], prix: 1500),
  PlatCommande(label:fake.food.restaurant(), cat: CATEGORIE[1], prix: 1500),
  PlatCommande(label:fake.food.restaurant(), cat: CATEGORIE[1], prix: 2500),
  PlatCommande(label:fake.food.restaurant(), cat: CATEGORIE[1], prix: 1000),
  PlatCommande(label:fake.food.restaurant(), cat: CATEGORIE[1], prix: 1750),
  PlatCommande(label:fake.food.restaurant(), cat: CATEGORIE[1], prix: 1500),
];

List<PlatCommande> DESSERTS =
[
  PlatCommande(label:fake.food.dish(), cat: CATEGORIE[2], prix: 1500),
  PlatCommande(label:fake.food.dish(), cat: CATEGORIE[2], prix: 2600),
  PlatCommande(label:fake.food.dish(), cat: CATEGORIE[2], prix: 1000),
  PlatCommande(label:fake.food.dish(), cat: CATEGORIE[2], prix: 1500),
  PlatCommande(label:fake.food.dish(), cat: CATEGORIE[2], prix: 1500),
  PlatCommande(label:fake.food.dish(), cat: CATEGORIE[2], prix: 2500),
  PlatCommande(label:fake.food.dish(), cat: CATEGORIE[2], prix: 1000),
  PlatCommande(label:fake.food.dish(), cat: CATEGORIE[2], prix: 1750),
  PlatCommande(label:fake.food.dish(), cat: CATEGORIE[2], prix: 1500),
];

List<PlatCommande> BOISSONS =
[
  PlatCommande(label: fake.food.dish(), cat: CATEGORIE[3], prix: 1500),
  PlatCommande(label: fake.food.dish(), cat: CATEGORIE[3], prix: 2600),
  PlatCommande(label: fake.food.dish(), cat: CATEGORIE[3], prix: 1000),
  PlatCommande(label: fake.food.dish(), cat: CATEGORIE[3], prix: 1500),
  PlatCommande(label: fake.food.dish(), cat: CATEGORIE[3], prix: 1500),
  PlatCommande(label: fake.food.dish(), cat: CATEGORIE[3], prix: 2500),
  PlatCommande(label: fake.food.dish(), cat: CATEGORIE[3], prix: 1000),
  PlatCommande(label: fake.food.dish(), cat: CATEGORIE[3], prix: 1750),
  PlatCommande(label: fake.food.dish(), cat: CATEGORIE[3], prix: 1500),
];*/


/*Map<String, List<PlatCommande>> mapListMenu = {
  'Nos entrées': ENTREES,
  'Nos plats' : PLATS,
  'Nos boissons' : BOISSONS,
  'Nos desserts' : DESSERTS,
};*/



Utilisateur USER;
RestoDataRepository repository = RestoDataRepository();