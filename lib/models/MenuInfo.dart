class MenuInfo{
  String nom, categorie, id;
  num prix;
  int quantite;
  String idRestaurant;

  MenuInfo({
    this.nom,
    this.prix,
    this.categorie,
    this.id,
  });

  MenuInfo.forFacture({this.nom, this.categorie, this.prix, this.quantite});

  Map<String, Object> toJson() {
    return {
      'nom': nom,
      'prix': prix,
    };
  }

  MenuInfo.fromListOfIdAndMap(List<dynamic> list, String cat){
    this.nom = (list[1] as Map)['nom'];
    this.prix = (list[1] as Map)['prix'];
    this.id = list[0];
    this.categorie = cat;
  }

  MenuInfo.fromMenuInfo(MenuInfo menuInfo){
    this.nom = menuInfo.nom;
    this.prix = menuInfo.prix;
    this.categorie = menuInfo.categorie;
    this.id = menuInfo.id;
  }

  String toString() => "Nom : $nom / Prix : $prix / Categorie : $categorie / id : $id";

  static MenuInfo menuInfoforCommande(Map<String, dynamic> data) {
    MenuInfo myMenu = MenuInfo(nom: data['nom'], categorie: data['categorie'], prix: data['prix']);
    myMenu.quantite = data['quantite'];
    return myMenu;
  }
}

