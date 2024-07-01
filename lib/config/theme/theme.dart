import 'package:flutter/material.dart';
import 'package:money_management/core/helpers/helpers.dart';

// 
final Color primary = HexColor('#fff');


final Color black = HexColor('#303030');
final Color successColor = HexColor('#58BC6B');
final Color errorColor = Colors.red.shade400;
final Color redColors = HexColor('#FD3C4A');


final Color textPrimary = HexColor('#303030');
final Color textSecondary = HexColor('#606060');  
final Color textDisabled = HexColor('#B2B2B2');  

enum ColorOpacity { twenty, twentyFive , thirty, thirtyFive, forty, fortyFive, fifty, fiftyFive, sixty, sixtyFive, seventy, seventyFive, eighty, eightyFive, ninety, ninetyFive, hundred }


Color dark (ColorOpacity? value) {
  Map<ColorOpacity, Color> data = {
    ColorOpacity.twentyFive: Colors.black45,
    ColorOpacity.fifty: Colors.black54,
    ColorOpacity.seventyFive: Colors.black87,
    ColorOpacity.hundred: Colors.black
  };

  return data[value] ?? data[ColorOpacity.hundred]!;
}


Color light (ColorOpacity? value) {
  Map<ColorOpacity, Color> data = {
    ColorOpacity.twenty: Colors.white24,
    ColorOpacity.forty: Colors.white54,
    ColorOpacity.sixty: Colors.white60,
    ColorOpacity.eighty: Colors.white70,
    ColorOpacity.hundred: Colors.white
  };

  return data[value] ?? data[ColorOpacity.hundred]!;
}


Color violet (ColorOpacity? value) {

  Map<ColorOpacity, Color> data = {
    ColorOpacity.twenty: HexColor('#EEE5FF'),
    ColorOpacity.forty: HexColor('#D3BDFF'),
    ColorOpacity.sixty: HexColor('#B18AFF'),
    ColorOpacity.eighty: HexColor('#8F57FF'),
    ColorOpacity.hundred: HexColor('#7F3DFF')
  };

  return data[value] ?? data[ColorOpacity.hundred]!;
}

Color red (ColorOpacity? value) {
  Map<ColorOpacity, Color> data = {
    ColorOpacity.twenty: HexColor('#FDD5D7'),
    ColorOpacity.forty: HexColor('#FDA2A9'),
    ColorOpacity.sixty: HexColor('#FD6F7A'),
    ColorOpacity.eighty: HexColor('#FD5662'),
    ColorOpacity.hundred: HexColor('#FD3C4A')
  };

  return data[value] ?? data[ColorOpacity.hundred]!;
}

Color green (ColorOpacity? value) {
  Map<ColorOpacity, Color> data = {
    ColorOpacity.twenty: HexColor('#CFFAEA'),
    ColorOpacity.forty: HexColor('#93EACA'),
    ColorOpacity.sixty: HexColor('#65D1AA'),
    ColorOpacity.eighty: HexColor('#2AB784'),
    ColorOpacity.hundred: HexColor('#00A86B')
  };

  return data[value] ?? data[ColorOpacity.hundred]!;
}

Color yellow (ColorOpacity? value) {
  Map<ColorOpacity, Color> data = {
    ColorOpacity.twenty: HexColor('#FCEED4'),
    ColorOpacity.forty: HexColor('#FCDDA1'),
    ColorOpacity.sixty: HexColor('#FCCC6F'),
    ColorOpacity.eighty: HexColor('#FCBB3C'),
    ColorOpacity.hundred: HexColor('#FCAC12')
  };

  return data[value] ?? data[ColorOpacity.hundred]!;
}


Color blue (ColorOpacity? value) {
  Map<ColorOpacity, Color> data = {
    ColorOpacity.twenty: HexColor('#BDDCFF'),
    ColorOpacity.forty: HexColor('#8AC0FF'),
    ColorOpacity.sixty: HexColor('#57A5FF'),
    ColorOpacity.eighty: HexColor('#248AFF'),
    ColorOpacity.hundred: HexColor('#0077FF')
  };

  return data[value] ?? data[ColorOpacity.hundred]!;
}



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