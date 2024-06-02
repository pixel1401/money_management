import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:money_management/features/domain/entity/post.dart';
import 'package:money_management/features/presentation/widgets/Indicator/indicator.dart';

class AppColors {
  static const Color primary = contentColorCyan;
  static const Color menuBackground = Color(0xFF090912);
  static const Color itemsBackground = Color(0xFF1B2339);
  static const Color pageBackground = Color(0xFF282E45);
  static const Color mainTextColor1 = Colors.white;
  static const Color mainTextColor2 = Colors.white70;
  static const Color mainTextColor3 = Colors.white38;
  static const Color mainGridLineColor = Colors.white10;
  static const Color borderColor = Colors.white54;
  static const Color gridLinesColor = Color(0x11FFFFFF);

  static const Color contentColorBlack = Colors.black;
  static const Color contentColorWhite = Colors.white;
  static const Color contentColorBlue = Color(0xFF2196F3);
  static const Color contentColorYellow = Color(0xFFFFC300);
  static const Color contentColorOrange = Color(0xFFFF683B);
  static const Color contentColorGreen = Color(0xFF3BFF49);
  static const Color contentColorPurple = Color(0xFF6E1BFF);
  static const Color contentColorPink = Color(0xFFFF3AF2);
  static const Color contentColorRed = Color(0xFFE80054);
  static const Color contentColorCyan = Color(0xFF50E4FF);

  static Color generateColor(int index) {
    List colors = [
      primary,
      contentColorBlue,
      contentColorYellow,
      contentColorOrange,
      contentColorGreen,
      contentColorPurple,
      contentColorPink,
      contentColorRed,
    ];

    return colors[index];
  }
}



class PieChartSample2 extends StatefulWidget {
  final List<PieChartVM> values;
  const PieChartSample2({super.key, required this.values});

  @override
  State<StatefulWidget> createState() => PieChart2State();
}

class PieChart2State extends State<PieChartSample2> {
  int touchedIndex = -1;

  
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.3,
      child: Column(
        children: <Widget>[
          const SizedBox(
            height: 18,
          ),
          Expanded(
            child: AspectRatio(
              aspectRatio: 1,
              child: PieChart(
                PieChartData(
                  pieTouchData: PieTouchData(
                    touchCallback: (FlTouchEvent event, pieTouchResponse) {
                      setState(() {
                        if (!event.isInterestedForInteractions ||
                            pieTouchResponse == null ||
                            pieTouchResponse.touchedSection == null) {
                          touchedIndex = -1;
                          return;
                        }
                        touchedIndex = pieTouchResponse
                            .touchedSection!.touchedSectionIndex;
                      });
                    },
                  ),
                  borderData: FlBorderData(
                    show: false,
                  ),
                  sectionsSpace: 0,
                  centerSpaceRadius: 40,
                  sections: widget.values.isEmpty ? [] : showingSections(),
                ),
              ),
            ),
          ),
          showLegends(),
          const SizedBox(
            width: 28,
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {
    return widget.values.asMap().entries.map((value) {
      final isTouched = value.key == touchedIndex;
      final fontSize = isTouched ? 25.0 : 16.0;
      final radius = isTouched ? 60.0 : 50.0;
      const shadows = [Shadow(color: Colors.black, blurRadius: 2)];

      return (PieChartSectionData(
        color: AppColors.generateColor(value.key),
        value: double.tryParse(value.value.percent.toString()),
        title: value.value.percent.toString() + '%',
        radius: radius,
        titleStyle: TextStyle(
          fontSize: fontSize,
          fontWeight: FontWeight.bold,
          color: AppColors.mainTextColor1,
          shadows: shadows,
        ),
      ));
    }).toList();
  }

  Widget showLegends() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ...widget.values.asMap().entries.map((data) => (Indicator(
              color: AppColors.generateColor(data.key),
              text: data.value.title,
              isSquare: true,
            )))
      ],
    );
  }
}
