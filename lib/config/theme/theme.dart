import 'package:flutter/material.dart';
import 'package:money_management/core/helpers/helpers.dart';

// 
final Color primary = HexColor('#fff');


final Color black = HexColor('#303030');
final Color successColor = HexColor('#58BC6B');
final Color errorColor = Colors.red.shade400;


final Color textPrimary = HexColor('#303030');
final Color textSecondary = HexColor('#606060');  
final Color textDisabled = HexColor('#B2B2B2');  



ThemeData theme() {
  return ThemeData(
    scaffoldBackgroundColor: Colors.white,
    fontFamily: "Poppins",
    appBarTheme: appBarTheme(),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(fontWeight: FontWeight.bold),
      bodyMedium: TextStyle(fontWeight: FontWeight.w600),
      titleMedium: TextStyle()
    ).apply(bodyColor: textPrimary, displayColor: Colors.amber),
    // colorScheme: ColorScheme.fromSeed(
    //   seedColor: Colors.deepPurple,
    //   onPrimary: Colors.amber,
    // ),
  );
}


AppBarTheme appBarTheme () {
  return const AppBarTheme(
    color: Colors.white,
    elevation: 0,
    centerTitle: true,
    iconTheme: IconThemeData(color: Color(0XFF8B8B8B)),
    titleTextStyle: TextStyle(color:Color(0XFF8B8B8B) , fontSize: 18  )
  );
}