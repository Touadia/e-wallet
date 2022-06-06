import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:password_dart/password_dart.dart';
import 'package:up_pro_v2/constants.dart';
import 'package:up_pro_v2/screens/auth/register/registerScreen.dart';
import 'package:up_pro_v2/screens/auth/register/signInScreen.dart';
import 'package:up_pro_v2/screens/auth/signUp.dart';
import 'package:up_pro_v2/screens/main/main_screen.dart';
import 'package:up_pro_v2/screens/routage.dart';
import 'package:up_pro_v2/utils/authentification.dart';


class Connexion extends StatefulWidget {
  @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var iphoneWidth = 375;
    var iphoneHeight = 812;
    return Container(
      child:
      Column(
        children: [
          SizedBox(height: size.height* 61/iphoneHeight,),
          Center(child: Text('Connexion',style: TextStyle(color: myGrey4,fontSize: size.width*25/iphoneWidth,fontWeight: FontWeight.bold),)),
          SizedBox(height: size.height*44/iphoneHeight,),
          Container(
            width: size.width,
            height: size.width/1.5,
            decoration:BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/people_using_qr.jpg'),
                )
            ) ,
          ),
          SizedBox(height: size.height*50/iphoneHeight,),
          //MyCustomForm(),
          SizedBox(height: 10,),
          FutureBuilder(
            future: Authentication.initializeFirebase(context: context),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text('Error initializing Firebase');
              } else if (snapshot.connectionState == ConnectionState.done) {
                return Column(
                  children: [
                    GoogleSignInButton(),
                    MailAuth(forSignIn: true,),
                    MailAuth(forSignIn: false,),
                  ],
                );
              }
              return CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.deepOrangeAccent,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  final _formKey = GlobalKey<FormState>();
  var _email = TextEditingController();
  var _psw = TextEditingController();
  bool _isLogingIn = false;

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
          Container(
            width: iphoneWidth *.95,
            child: TextFormField(
              controller: _email,
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
              controller: _psw,
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
                return null;
              },
            ),
          ),
          SizedBox(height: 5,),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: (){
                  Navigator.of(context).push((
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) => SignUp(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          var begin = Offset(-1.0, 0.0);
                          var end = Offset.zero;
                          var curve = Curves.ease;

                          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

                          return SlideTransition(
                            position: animation.drive(tween),
                            child: child,
                          );
                        },
                      )
                  ),);
                },
                child: Text('S\'inscrire',style: TextStyle(fontSize:size.width*14/iphoneWidth ,color: myGrey2,decoration: TextDecoration.underline),),
              ),
              TextButton(
                onPressed: (){},
                child: Text('Mot de passe oublié',style: TextStyle(fontSize:size.width*14/iphoneWidth ,color: myGrey2,decoration: TextDecoration.underline),),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: SizedBox(
              width: size.width*176/iphoneWidth,
              height: size.height*49/iphoneHeight,
              child: _isLogingIn ?
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ) :
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState.validate()){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Processing Data'),));
                    try {
                      var hash = Password.hash(_psw.text, PBKDF2());
                      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                          email: _email.text,
                          password: hash,
                      );
                      setState(() {
                        _isLogingIn = true;
                      });
                    } on FirebaseAuthException catch (e) {
                      if (e.code == 'user-not-found') {
                        print('No user found for that email.');
                      } else if (e.code == 'wrong-password') {
                        print('Wrong password provided for that user.');
                      }
                    }
                    setState(() {
                      _isLogingIn = false;
                    });
                    Flurorouter.router.navigateTo(context, "/main");
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
}


class GoogleSignInButton extends StatefulWidget {
  @override
  _GoogleSignInButtonState createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool _isSigningIn = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      )
          : OutlinedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
        onPressed: () async {
          setState(() {
            _isSigningIn = true;
          });
           User user = await Authentication.signInWithGoogle(context: context);
           googleUserSetup(user);

           setState(() {
             _isSigningIn = false;
           });

           if (user != null) {
             Navigator.of(context).pushReplacement(
               MaterialPageRoute(
                 builder: (context) => MainScreen(
                   // TODO : pass an my user type to the MainScreen constructor
                   user: user,
                 ),
               ),
             );
           }
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage("assets/images/google_logo.png"),
                height: 35.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Google',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}


class MailAuth extends StatefulWidget {
  final bool forSignIn;

  MailAuth({
    Key key,
    this.forSignIn,
  }) : super(key: key);
  
  @override
  _MailAuthState createState() => _MailAuthState();
}

class _MailAuthState extends State<MailAuth> {
  bool _isSigningIn = false;
  bool _forSignIn;
  
  @override
  void initState() {
    // TODO: implement initState
    _forSignIn = widget.forSignIn;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _forSignIn ?
    Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      )
          : OutlinedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => RegisterScreen(),),);
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage("assets/images/mail.png"),
                height: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'S\'enregister',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    )
    : Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: _isSigningIn
          ? CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      )
          : OutlinedButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all(Colors.white),
          shape: MaterialStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40),
            ),
          ),
        ),
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => SignInScreen(),),);
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage("assets/images/mail.png"),
                height: 25.0,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Se connecter',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black54,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
