import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:money_management/features/domain/entity/post.dart';

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


Map<String, List<Post>> getMapData(PostsData data) {
  Map<String, List<Post>> map = {};
  try {
    DateTime today = DateTime.now();
    DateTime yesterday = today.subtract(Duration(days: 1));

    String formatDateKey(DateTime date) {
      if (date.year == today.year &&
          date.month == today.month &&
          date.day == today.day) {
        return "Сегодня";
      } else if (date.year == yesterday.year &&
          date.month == yesterday.month &&
          date.day == yesterday.day) {
        return "Вчера";
      } else {
        return DateFormat('dd.MM.yyyy').format(date);
      }
    }

    for (var item in data.posts) {
      DateTime? date = DateTime.tryParse(item.date);

      String dateKey = date != null ? formatDateKey(date) : item.date;

      if (!map.containsKey(dateKey)) {
        map[dateKey] = [];
      }
      map[dateKey]!.add(item);
    }

    return map;
  } catch (e) {
    print('Error in getMapData: $e');
    return map;
  }
}