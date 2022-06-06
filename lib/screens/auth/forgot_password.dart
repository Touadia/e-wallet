import 'package:up_pro_v2/constants.dart';
import 'package:flutter/material.dart';


var txtF1 = TextEditingController();
var txtF2 = TextEditingController();
class ForgotPassword extends StatefulWidget {
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var iphoneWidth = 375;
    var iphoneHeight = 812;
    return Container(
      child:
      Column(
        children: [
          SizedBox(height: size.height* 58/iphoneHeight,),
          Center(child: Text('Mot de passe oublie',style: TextStyle(color: myGrey4,fontSize: size.width*25/iphoneWidth,fontWeight: FontWeight.bold),)),
          SizedBox(height: size.height*30/iphoneHeight,),
          Container(
            width: size.width *279/iphoneWidth,
            height: size.height*279/iphoneHeight,
            decoration:BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/forgot_password.jpg'),
                )
            ) ,
          ),
          SizedBox(height: size.height*31/iphoneHeight,),
          MyForgotForm(),
        ],
      ),
    );
  }
}

class MyForgotForm extends StatefulWidget {
  @override
  _MyForgotFormState createState() => _MyForgotFormState();
}

class _MyForgotFormState extends State<MyForgotForm> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var iphoneWidth = 375;
    var iphoneHeight = 812;
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width* 300/iphoneWidth ,
            height:size.height*49/iphoneHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: myGrey1,
            ),
            child: TextFormField(
              controller: txtF1,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.0,style: BorderStyle.none,)
                ),
                hintText: 'nouveau mot de passe',
              ),
              validator: (value){
                if (value==null||value.isEmpty){return 'Please enter some text';}
                return null;
              },
            ),
          ),
          SizedBox(height: size.height*24/iphoneHeight,),
          Container(
            width: size.width* 300/iphoneWidth ,
            height:size.height*49/iphoneHeight,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: myGrey1,
            ),
            child: TextFormField(
              controller: txtF2,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                    borderSide: BorderSide(width: 0.0,style: BorderStyle.none,)
                ),
                hintText: 'confirmation du nouveau mot de passe',
              ),
              validator: (value){
                if (value==null||value.isEmpty){return 'Please enter some text';}
                return null;
              },
            ),
          ),
          SizedBox(height: size.height*75/iphoneHeight,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: SizedBox(
              width: size.width*176/iphoneWidth,
              height: size.height*49/iphoneHeight,
              child: ElevatedButton(
                onPressed: (){
                  if (_formKey.currentState.validate()){
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Processing Data'),));
                    txtF1.text = '';
                    txtF2.text = '';
                  }
                },
                style: ElevatedButton.styleFrom(
                    primary: myGrey4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    )
                ),
                //ButtonStyle(backgroundColor: MaterialStateProperty.all(myGrey4),shape: MaterialStateProperty.all(value),
                child: Text('Valider',style: TextStyle(fontSize: size.width*18/iphoneWidth,fontWeight: FontWeight.bold,color: myGrey2),),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
