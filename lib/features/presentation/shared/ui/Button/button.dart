import 'package:flutter/material.dart';
import 'package:money_management/core/helpers/helpers.dart';

class Button extends StatelessWidget {
  final Function onPress;
  final String text;
  final ButtonStyle? styleBtn;
  const Button(
      {super.key, required this.onPress, required this.text, this.styleBtn});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPress();
      },
      child: Text('$text'),
      style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: BorderSide(color: Colors.transparent)))
          .merge(styleBtn),
    );
  }
}
