import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:up_pro_v2/constants.dart';
import 'package:up_pro_v2/models/Commande.dart';
import 'package:up_pro_v2/variables/resto.dart';

class AccountInfo extends StatefulWidget {
  const AccountInfo({Key key}) : super(key: key);

  @override
  _AccountInfoState createState() => _AccountInfoState();
}

class _AccountInfoState extends State<AccountInfo> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double visaHeight = size.width * .90 * 293 / 514;
    double visaWidth = size.width * .90;
    print(size.height);
    return Container(
      height: size.height < 850 ? size.height * .52 : size.height * .42,
      decoration: BoxDecoration(color: myWhite),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 70,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                        text: TextSpan(
                            text: 'Salut ',
                            style: Theme.of(context)
                                .textTheme
                                .headline5
                                .apply(fontWeightDelta: 1),
                            children: [
                          TextSpan(
                              text: '${USER.nom}.',
                              style: TextStyle(fontWeight: FontWeight.bold))
                        ])),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Gère bien ton argent avec notre application',
                      style: TextStyle(color: myGrey2, fontSize: 12),
                    ),
                  ],
                ),
                Icon(Icons.notifications_none_rounded),
              ],
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: VisaCard(size: size, visaHeight: visaHeight, visaWidth: visaWidth),
          ),
        ],
      ),
    );
  }
}

class VisaCard extends StatelessWidget {
  const VisaCard({
    Key key,
    @required this.size,
    @required this.visaHeight,
    @required this.visaWidth,
  }) : super(key: key);

  final Size size;
  final double visaHeight;
  final double visaWidth;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance.collection('utilisateurs').doc(USER.persoId).snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError){
          return Center(child: Text('Quelque chose ne va pas, rechargez la page !', style: TextStyle(fontSize: 30),),);
        }
        if (snapshot.hasData && !snapshot.data.exists) {
          return Center(child: Text('Document does not exist', style: TextStyle(fontSize: 30),));
        }
        if (snapshot.connectionState == ConnectionState.done){
          return Center(child: CircularProgressIndicator());
        }
        return buildVisaCard(snapshot);
      }
    );
  }

  Stack buildVisaCard(AsyncSnapshot<DocumentSnapshot<Object>> snapshot) {
    Map monCompte = snapshot.data.data();
    return Stack(
        alignment: Alignment.topLeft,
          children: [
            Positioned(
                //left: -10,
              top: 13,
              child: Container(
                height: size.width * .90 * 293 / 514,
                width: size.width * .80,
                decoration: BoxDecoration(
                  color: myGrey2,
                  borderRadius: BorderRadius.horizontal(
                      right: Radius.circular(20)
                  ),
                ),
              ),
            ),
            Positioned(
                //left: -10,
                top: 7,
                child: Container(
                    height: size.width * .90 * 293 / 514,
                    width: size.width * .85,
                    decoration: BoxDecoration(
                        color: myGrey3,
                        borderRadius: BorderRadius.horizontal(
                            right: Radius.circular(20)
                        )
                    )
                )
            ),
            Positioned(
              left: 0,
              child: Container(
                height: visaHeight,
                width: visaWidth,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Color.fromARGB( 255, 50, 50, 51),
                      Color.fromARGB( 255, 46, 46, 47),
                      Color.fromARGB( 255, 42, 41, 43),
                      Color.fromARGB( 255, 38, 38, 40),
                      Color.fromARGB( 255, 35, 35, 37),
                      Color.fromARGB( 255, 35, 34, 36),
                      Color.fromARGB( 255, 34, 34, 35),
                      Color.fromARGB( 255, 33, 33, 35),
                      Color.fromARGB( 255, 31, 31, 33),
                    ]
                  ),
                  color: myGrey4,
                  borderRadius: BorderRadius.horizontal(right: Radius.circular(20)),
                ),
                child: Stack(
                  children: [
                    Positioned(top: visaHeight *.15, right: visaHeight *.18, child: Image(height: size.width * .90 *.095, image: AssetImage('assets/images/visaLogo2.png'),)),
                    Positioned(top: visaHeight *.13, left: visaHeight *.18,child: Text('Balance', style: TextStyle(color: myGrey3, fontFamily: 'Montserrat',fontSize: 14, fontWeight: FontWeight.bold,),),),
                    Positioned(top: visaHeight *.30, left: visaHeight *.18,child: Text('${monCompte['balance']} Frs', style: TextStyle(color: myGrey1, fontFamily: 'Cousine',fontSize: 30, fontWeight: FontWeight.bold,),),),
                    Positioned(top: visaHeight *.63, left: visaHeight *.18,child: Text('* * * *  2 3 4 5', style: TextStyle(color: myGrey3, fontFamily: 'Cousine',fontSize: 20, fontWeight: FontWeight.w700,),),),
                    Positioned(top: visaHeight *.80, left: visaHeight *.18,child: Text(monCompte['name'], style: TextStyle(color: myGrey3, fontFamily: 'Cousine',fontSize: 20, fontWeight: FontWeight.w500,),),),
                  ],
                ),
              ),
            ),
          ]
      );
  }
}

class TransacHistory extends StatelessWidget {
  const TransacHistory({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    Size size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 30,),
        Padding(
          padding: EdgeInsetsDirectional.only(start: 30,bottom: 20, end: 30),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Recent Transaction',
                style: Theme.of(context).textTheme.headline4.apply(fontFamily: 'Montserrat',fontSizeFactor: .5, color: myGrey4, fontWeightDelta: 4),
              ),
              Text(
                'Show All',
                style: Theme.of(context).textTheme.caption.apply(fontSizeFactor: 1, color: myGrey1, fontWeightDelta: 2),
              ),
            ],
          ),
        ),
        StreamBuilder(
            stream: FirebaseFirestore.instance.collection('utilisateurs').doc(USER.persoId).collection('transactions').orderBy('date').limit(10).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasError){
                return Center(child: Text('Something wrong'));
              }
              if(!snapshot.hasData){
                return Center(child: CircularProgressIndicator());
              }
              var catList = snapshot.data.docs;
              return catList.length == 0 ? Container(height: size.height *100 /812, width: size.width *.9, child: Center(child: Text('Vous n\'avez effectué aucune transaction pour le moment', style: myStyle(20, myGrey2, 800),),),) :
              Column(
                children: [
                  for (var i=0; i < catList.length; i++) TransactionTile(
                    icon: Icons.dinner_dining,
                    label: catList[i]['nom du receveur'],
                    incomeOrNot: catList[i]['type de transaction'] == 'entrée' ? 'in' : 'out',
                    price: catList[i]['montant'],
                    date: fromTimestamp(catList[i]['date']),
                  )
                ],
              );
            }
        ),
        //TransactionTile(icon: Icons.video_collection_rounded, label: 'YouTube Pro', incomeOrNot: 'out', price: 20),
        //TransactionTile(icon: Icons.account_balance_wallet_outlined,label: 'From Danielle Bolou', incomeOrNot: 'in', price: 500),
        //TransactionTile(icon: Icons.nightlife,label: 'Cafe & Bar', incomeOrNot: 'out', price: 16),
        //TransactionTile(icon: Icons.sports_baseball_outlined,label: 'Tenis outfit', incomeOrNot: 'out', price: 130),
        //TransactionTile(icon: Icons.account_balance_wallet_outlined,label: 'Figma Pro', incomeOrNot: 'out', price: 110),
        //TransactionTile(icon: Icons.nightlife,label: 'Cafe', incomeOrNot: 'in', price: 20.12),
        //TransactionTile(icon: Icons.sports_baseball_outlined,label: 'ONG', incomeOrNot: 'in', price: 112.45),
        SizedBox(height: height * .1,)
      ],
    );
  }
}

class TransactionTile extends StatelessWidget {
  final IconData icon;
  final String label;
  final num price;
  final String incomeOrNot;
  final DateTime date;
  const TransactionTile({Key key, this.icon, this.label, this.price, this.incomeOrNot, this.date}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double size = 20;
    double width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
      width: width,
      child: Stack(
        children: [
          Container(
            width: size *2.5,
            height: size *2.5,
            decoration: BoxDecoration(
              border: Border.all(color: myGrey, width: 1.5),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: myGrey4,),
          ),
          Positioned(left: 60, top: 5,child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: TextStyle(color: myGrey4, fontFamily: 'Montserrat',fontSize: 16, fontWeight: FontWeight.bold),),
              Text(getDate(), style: TextStyle(color: myGrey2, fontFamily: 'Montserrat',fontSize: 12,),)
            ],
          )),
          Positioned(right: 10, top: 15,child: Text(incomeOrNot == 'in' ? '+$price Frs' : '-$price Frs', style: TextStyle(color: myGrey4, fontSize: 17, fontFamily: 'Montserrat', fontWeight: FontWeight.bold),)),
        ],
      ),
    );
  }

  String getDate() => "${date.day}/${date.month}/${date.year}   ${date.hour}:${date.minute}";
}
