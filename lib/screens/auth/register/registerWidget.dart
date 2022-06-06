import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:password_dart/password_dart.dart';
import 'package:up_pro_v2/screens/auth/signIn.dart';
import 'package:up_pro_v2/screens/main/main_screen.dart';
import 'package:up_pro_v2/utils/authentification.dart';
import '../../../constants.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key key}) : super(key: key);

  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordController2 = TextEditingController();
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String _hashPassword;
  bool _success;
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
          SizedBox(height: defaultPadding,),
          Container(
            width: iphoneWidth *.95,
            child: TextFormField(
              controller: _nomController,
              decoration: InputDecoration(
                filled: true,
                fillColor: myGrey1.withOpacity(.4),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(width: 0.0,style: BorderStyle.none,),
                ),
                helperText: 'Nom',
                suffixText: 'Nom',
              ),
              validator: (value){
                if (value==null||value.isEmpty||value.length<=1){return 'Entrez votre nom';}
                return null;
              },
            ),
          ),
          SizedBox(height: defaultPadding,),
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
                if (value==null||value.isEmpty){return 'Entrez votre Email';}
                return null;
              },
            ),
          ),
          SizedBox(height: defaultPadding,),
          Container(
            width: iphoneWidth *.95,
            child: TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                filled: true,
                fillColor: myGrey1.withOpacity(.4),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(width: 0.0,style: BorderStyle.none,),
                ),
                helperText: 'Numero de téléphone',
                suffixText: 'Numero',
              ),
              validator: (value){
                if (value==null||value.isEmpty){return 'Entrez votre numero de téléphone';}
                return null;
              },
            ),
          ),
          SizedBox(height: defaultPadding,),
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
                if (value==null||value.isEmpty){return 'Entrez votre mot de passe';}
                if (value.length < 8){return 'Trop court, au moins 8 charactères';}
                return null;
              },
            ),
          ),
          SizedBox(height: defaultPadding,),
          Container(
            width: iphoneWidth *.95,
            child: TextFormField(
              obscureText: true,
              obscuringCharacter: '•',
              controller: _passwordController2,
              decoration: InputDecoration(
                filled: true,
                fillColor: myGrey1.withOpacity(.4),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                  borderSide: BorderSide(width: 0.0,style: BorderStyle.none,),
                ),
                helperText: 'Reécrivez le mot de passe',
                suffixText: 'Mot de passe',
              ),
              validator: (value){
                if (value==null||value.isEmpty){return 'Reécrirez votre mot de passe';}
                if (value.length < 8){return 'Trop court, au moins 8 charactères';}
                if (value != _passwordController.text){return 'Trop court, au moins 8 charactères';}
                return null;
              },
            ),
          ),
          SizedBox(height: defaultPadding,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: SizedBox(
              width: size.width*176/iphoneWidth,
              height: size.height*49/iphoneHeight,
              child: ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState.validate()){
                    _hashPassword = Password.hash(_passwordController.text, PBKDF2()).substring(15);
                    print(_hashPassword);
                    _register();
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: myGrey4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    )
                ),
                //ButtonStyle(backgroundColor: MaterialStateProperty.all(myGrey4),shape: MaterialStateProperty.all(value),
                child: Text('S\'inscrire',style: TextStyle(fontSize: size.width*18/iphoneWidth,fontWeight: FontWeight.bold,color: myGrey2),),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _register() async {
    final User user = (await
    FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    )
    ).user;
    if (user != null) {
      setState(() async {
        _success = true;
        _userEmail = user.email;
        print(_nomController.text);
        user.updateDisplayName(_nomController.text);
        emailUserSetup(user, _nomController.text,_phoneController.text);
        _nomController.text = '';
        _phoneController.text = '';
        _passwordController.text = '';
        _passwordController2.text = '';
        _emailController.text = '';
        await FirebaseAuth.instance.signOut();
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) => SignIn(),
          ),
        );
      });
    } else {
      setState(() {
        _success = true;
        print('$_success $_userEmail');
      });
    }
  }
  
}
