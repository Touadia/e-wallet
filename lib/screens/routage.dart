import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:up_pro_v2/screens/main/SplashScreen.dart';
import 'package:up_pro_v2/screens/buisiness/restoList.dart';
import 'package:up_pro_v2/screens/main/main_screen.dart';
import 'package:up_pro_v2/screens/auth/signIn.dart';
import 'package:up_pro_v2/screens/buisiness/resto/commandes/commande.dart';
import 'package:up_pro_v2/screens/buisiness/resto/facture.dart';
import 'package:up_pro_v2/screens/buisiness/resto/home.dart';
import 'package:up_pro_v2/screens/buisiness/resto/menu/catMenu.dart';
import 'package:up_pro_v2/screens/buisiness/resto/menu/menu.dart';

import 'buisiness/restoFav.dart';



class Flurorouter{

  static final FluroRouter router = FluroRouter();

  static Handler _splashHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => SplashScreen());

  static Handler _signUpHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => SignIn());

  static Handler _mainHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => MainScreen());

  static Handler _restoHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => Restaurant(name : params['name'][0], id: params['id'][0],));

  static Handler _menuHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    final args = ModalRoute.of(context).settings.arguments as RestoPassedInfo;
    return Menu(data: args);
  });

  static Handler _restoListHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => ListResto());

  static Handler _restoFavHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) => ListRestoFav());

  static Handler _commandeHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    final args = ModalRoute.of(context).settings.arguments as RestoPassedInfo;
    return Commande(data: args);
  });

  static Handler _factureHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    final args = ModalRoute.of(context).settings.arguments as RestoPassedInfo;
    return Facture(data: args);
  });

  static Handler _catHandler = Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    final args = ModalRoute.of(context).settings.arguments as RestoPassedInfo;
    return CategoryMenu(data: args,);
  });

  static void setupRouter() {
    router.define('/', handler: _splashHandler);
    router.define('/signUp', handler: _signUpHandler);
    router.define('/main', handler: _mainHandler,transitionType: TransitionType.fadeIn, transitionDuration: Duration(milliseconds: 1000));
    router.define('/main/listResto', handler: _restoListHandler,transitionType: TransitionType.fadeIn,);
    router.define('/main/restoFav', handler: _restoFavHandler,transitionType: TransitionType.fadeIn,);
    router.define('/resto/:name/:id', handler: _restoHandler,transitionType: TransitionType.inFromRight);
    router.define('/menu', handler: _menuHandler,transitionType: TransitionType.inFromRight);
    router.define('/commande', handler: _commandeHandler,transitionType: TransitionType.inFromRight);
    router.define('/facture', handler: _factureHandler,transitionType: TransitionType.inFromRight);
    router.define('/menu/categoryMenu', handler: _catHandler,transitionType: TransitionType.inFromRight,);
  }
}

class RestoPassedInfo{
  final String nom;
  final List<String> categorie;
  final String localisation;
  final num note;
  final String id;

  RestoPassedInfo({this.id, this.nom, this.localisation, this.note, this.categorie,});
}