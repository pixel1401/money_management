import 'dart:ui';

import 'package:flutter/material.dart';

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    try {
      hexColor = hexColor.toUpperCase().replaceAll("#", "");
      if (hexColor.length == 6) {
        hexColor = "FF" + hexColor;
      }
      return int.tryParse(hexColor, radix: 16) ?? 0xFF000000;
    } catch (e) {
      print('Error in HexColor: $e');
      return 0xFF000000;
    }
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}

String colorToHex(Color color) => '#${color.value.toRadixString(16)}';

List<String> months = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December'
];

List<String> days = [
  'Monday',
  'Tuesday',
  'Wednesday',
  'Thursday',
  'Friday',
  'Saturday',
  'Saturday',
  'Sunday'
];

SizedBox Space([double? heightArg, double? widthArg]) {
  return SizedBox(
    height: heightArg,
    width: widthArg,
  );
}

num calculateSum(List<dynamic> stringNumbers) {
  // Используем fold для эффективного суммирования
  return stringNumbers.fold<double>(0, (previousValue, element) {
    // Преобразуем строку в число и добавляем к текущей сумме
    double number = double.tryParse(element) ?? 0.0;
    return previousValue + number;
  });
}
