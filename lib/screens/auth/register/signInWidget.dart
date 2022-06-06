import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:password_dart/password_dart.dart';
import 'package:up_pro_v2/screens/main/main_screen.dart';

import '../../../constants.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _success;
  String _hashPassword;
  String _userEmail;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var iphoneHeight = 812;
    var iphoneWidth = 375;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 5,),
          Container(
            width: iphoneWidth *.95,
            child: TextFormField(
              controller: _emailController,
              decoration: InputDecoration(
                filled: true,
                fillColor: myGrey1.withOpacity(.4),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(width: 0.0,style: BorderStyle.none,),
                ),
                helperText: 'Email',
                suffixText: 'Email',
              ),
              validator: (value){
                if (value==null||value.isEmpty){return 'Entrer quelque chose';}
                return null;
              },
            ),
          ),
          SizedBox(height: 5,),
          Container(
            width: iphoneWidth *.95,
            child: TextFormField(
              obscureText: true,
              obscuringCharacter: '•',
              controller: _passwordController,
              decoration: InputDecoration(
                filled: true,
                fillColor: myGrey1.withOpacity(.4),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(width: 0.0,style: BorderStyle.none,),
                ),
                helperText: 'Mot de passe',
                suffixText: 'Mot de passe',
              ),
              validator: (value){
                if (value==null||value.isEmpty){return 'Entrer quelque chose';}
                if (value.length < 8){return 'Trop court, au moins 8 charactères';}
                return null;
              },
            ),
          ),
          SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: SizedBox(
              width: size.width*176/iphoneWidth,
              height: size.height*49/iphoneHeight,
              child: ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()){
                    _hashPassword = Password.hash(_passwordController.text, PBKDF2()).substring(15);
                    _signInWithEmailAndPassword();
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: myGrey4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    )
                ),
                //ButtonStyle(backgroundColor: MaterialStateProperty.all(myGrey4),shape: MaterialStateProperty.all(value),
                child: Text('Se connecter',style: TextStyle(fontSize: size.width*18/iphoneWidth,fontWeight: FontWeight.bold,color: myGrey2),),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _signInWithEmailAndPassword() async {
    FirebaseAuth.instance.signOut();
    final User user = (await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    )).user;

    if (user != null) {
      setState(() {
        _success = true;
        _userEmail = user.email;
        _emailController.text = '';
        _passwordController.text = '';
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => MainScreen(
              // TODO : pass an my user type to the MainScreen constructor
              user: user,
            ),
          ),
        );
      });
    } else {
      setState(() {
        _success = false;
      });
    }
  }

}