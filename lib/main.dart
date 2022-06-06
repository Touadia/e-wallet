import 'package:flutter/material.dart';
import 'screens/routage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState(){
    super.initState();
    Flurorouter.setupRouter();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UP PRO',
      initialRoute: '/',
      onGenerateRoute: Flurorouter.router.generator,
    );
  }
}

