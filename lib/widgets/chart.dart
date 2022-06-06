import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:up_pro_v2/constants.dart';

class LineChartSample2 extends StatefulWidget {
  @override
  _LineChartSample2State createState() => _LineChartSample2State();
}

class _LineChartSample2State extends State<LineChartSample2> {
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];

  bool showAvg = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AspectRatio(
          aspectRatio: 3,
          child: Container(
            /*decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(18),
                ),
                color: Color(0xff232d37)
            ),*/
            child: LineChart(
              mainData(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        horizontalInterval: 500,
        show: true,
        drawVerticalLine: false,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: myGrey.withAlpha(50),
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 10,
          getTextStyles: (value) =>
          const TextStyle(color: myWhite, fontSize: 12),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '17 Mar';
              case 3:
                return '18 Mar';
              case 5:
                return '19 Mar';
              case 7:
                return '20 Mar';
              case 9:
                return '21 Mar';
            }
            return '';
          },
          margin: 5,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          getTextStyles: (value) => const TextStyle(
            color: myWhite,
            fontWeight: FontWeight.normal,
            fontSize: 12,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 0:
                return '\$0';
              case 500:
                return '\$500';
              case 1000:
                return '\$1000';
              case 1500:
                return '\$1500';
            }
            return '';
          },
          reservedSize: 60,
          margin: 10,
        ),
      ),
      borderData: FlBorderData(show: true, border: Border.all(color: const Color(0xff37434d), width: 0)),
      minX: 0,
      maxX: 10,
      minY: 0,
      maxY: 1501,
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 255),
            FlSpot(1, 400),
            FlSpot(3, 950),
            FlSpot(5, 600),
            FlSpot(7, 960),
            FlSpot(9, 1300),
          ],
          isCurved: true,
          colors: gradientColors,
          barWidth: 4,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            colors: gradientColors.map((color) => color.withOpacity(0.3)).toList(),
          ),
        ),
      ],
    );
  }
}