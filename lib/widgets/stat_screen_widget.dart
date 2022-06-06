import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import '../constants.dart';

class TopBar extends StatelessWidget {
  const TopBar({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: MediaQuery.of(context).size.height *.1,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            height: size.height *.05,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  height: 1,
                ),
                Text('My Balance',
                    style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.bold, fontSize: 19, color: myGrey4)),
                Icon(Icons.more_horiz_rounded),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TotalBalance extends StatefulWidget {
  const TotalBalance({Key key}) : super(key: key);

  @override
  _TotalBalanceState createState() => _TotalBalanceState();
}

class _TotalBalanceState extends State<TotalBalance> {
  int _currentIndex = 1;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
        //height: MediaQuery.of(context).size.height *.65,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height *.03,),
            Padding(
              padding: EdgeInsets.only(left: size.width *.05),
              child: Text('Total Balance', style: TextStyle(color: myGrey4, fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.w700),),
            ),
            Padding(
              padding: EdgeInsets.only(top: size.width *.04, left: size.width *.05,),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('\$660', style: TextStyle(color: myGrey4, fontFamily: 'Cousine', fontWeight: FontWeight.w700, fontSize: 30),),
                  SizedBox(width: size.width *.01,),
                  Icon(Icons.arrow_drop_up, color: myGreen, size: 25,),
                  Text('+\$60', style: TextStyle(color: myGreen, fontFamily: 'Cousine', fontWeight: FontWeight.w700, fontSize: 12),),
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.only(top: 30),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.horizontal(left: Radius.circular(10)),
                        onTap: () {
                          _toggle(1);
                        },
                        child: Ink(
                          height: size.height *.045,
                          width: size.width *.45,
                          decoration: BoxDecoration(
                              color: _currentIndex == 1
                                  ? myGrey4
                                  : myGrey1,
                              borderRadius:
                                  BorderRadius.horizontal(left: Radius.circular(10))),
                          child: Center(
                              child: Text('Income',
                                  style: Theme.of(context).textTheme.button.apply(color: _currentIndex == 1 ? myWhite : myGrey4))),
                        ),
                      ),
                      InkWell(
                        borderRadius: BorderRadius.horizontal(right: Radius.circular(10)),
                        onTap: () {
                          _toggle(2);
                        },
                        child: Ink(
                          height: size.height *.045,
                          width: size.width *.45,
                          decoration: BoxDecoration(
                              color: _currentIndex == 2
                                  ? myGrey4
                                  : myGrey1,
                              borderRadius:
                                  BorderRadius.horizontal(right: Radius.circular(10))),
                          child: Center(
                              child: Text('Outcome',
                                  style: Theme.of(context).textTheme.button.apply(color: _currentIndex == 2 ? myWhite : myGrey4))),
                        ),
                      ),
                    ])),
            Padding(
              padding: EdgeInsets.all(size.width *.05),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('+\$60.00', style: TextStyle(color: myGrey4, fontFamily: 'Cousine', fontWeight: FontWeight.w700, fontSize: 18),),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [Text('This week', style: TextStyle(color: myGrey1),), Icon(Icons.arrow_drop_down, color: myGrey1)],)
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5),
              child: Container(height: 300, width: size.width *.9,child: LineChartWidget()),
            ),
          ],
        )
    );
  }

  void _toggle(int next) {
    setState(() {
      _currentIndex = next;
    });
  }
}

class LineChartWidget extends StatelessWidget {
  const LineChartWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        minX: 1,
        maxX: 7,
        minY: 0,
        maxY: 5.5,
        titlesData: getTitleData(),
        gridData: FlGridData(
          show: true,
          drawHorizontalLine: false,
          drawVerticalLine: true,
          getDrawingVerticalLine: (value){
            return FlLine(strokeWidth: 1, color: myGrey1);
          }
        ),
        borderData: FlBorderData(
          show: false,
        ),
        lineBarsData: [
          LineChartBarData(
            spots: [
              FlSpot(1, 3),
              FlSpot(2, 2),
              FlSpot(3, 5),
              FlSpot(4, 2.5),
              FlSpot(5, 4),
              FlSpot(6, 3),
              FlSpot(7, 4),
            ],
            dotData: FlDotData(
              getDotPainter: (a,b,c,d) => FlDotCirclePainter(color: myGrey4, strokeColor: myWhite, strokeWidth: 3, radius: 2),
            ),
            isCurved: true,
            colors: [myGrey4],
            belowBarData: BarAreaData(
              show: true,
              colors: [myGrey1.withOpacity(.3), myGrey4.withOpacity(.25),]
            )
          )
        ]
      )
    );
  }

  static getTitleData () => FlTitlesData(
      show: true,
      bottomTitles: SideTitles(
        showTitles: true,
        getTitles: (value) {
          switch (value.toInt()){
            case 1:
              return 'Sun';
            case 2:
              return 'Mon';
            case 3:
              return 'Tue';
            case 4:
              return 'Wed';
            case 5:
              return 'Thu';
            case 6:
              return 'Fri';
            case 7:
              return 'Sat';
          }
          return '';
        },
        margin: 8,
      ),
    leftTitles: SideTitles(
      showTitles: true,
      reservedSize: 30,
      getTitles: (value) {
        switch (value.toInt()){
          case 0:
            return '';
        }
        int val = value.toInt();
        return '$val K';
      },
    )
  );
}


class BalanceStatistics extends StatefulWidget {
  const BalanceStatistics({Key key}) : super(key: key);

  @override
  _BalanceStatisticsState createState() => _BalanceStatisticsState();
}

class _BalanceStatisticsState extends State<BalanceStatistics> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(padding: EdgeInsets.only(top:30, left: size.width *.05),
      child: Text('Balance Statistics', style: TextStyle(color: myGrey4, fontFamily: 'Montserrat', fontSize: 15, fontWeight: FontWeight.w700),),)
    ;
  }
}
