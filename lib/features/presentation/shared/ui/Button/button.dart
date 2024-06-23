import 'package:flutter/material.dart';

class Button extends StatefulWidget {
  final Future<void> Function() onPress;
  final String text;
  final ButtonStyle? styleBtn;
  const Button(
      {super.key, required this.onPress, required this.text, this.styleBtn});

  @override
  State<Button> createState() => _ButtonState();
}

class _ButtonState extends State<Button> {
  bool isDisabled = false;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: isDisabled
          ? () {}
          : () async {
              setState(() {
                isDisabled = true;
              });
              await widget.onPress();
              setState(() {
                isDisabled = false;
              });
            },
      style: ElevatedButton.styleFrom(
              backgroundColor: Colors.black,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                  side: const BorderSide(color: Colors.transparent)))
          .merge(widget.styleBtn),
      child: isDisabled
          ? Container(
              height: 30,
              width: 30,
              padding: const EdgeInsets.all(5),
              child: const CircularProgressIndicator())
          : Text(widget.text),
    );
  }
}
