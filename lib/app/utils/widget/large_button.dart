import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;
  final WidgetStateColor color;

  const LargeButton(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      child: Text(text),
      style: ButtonStyle(
        minimumSize: WidgetStateProperty.all(Size(370, 40)),
        shadowColor: WidgetStateProperty.all(Colors.transparent),
        backgroundColor: color,
        foregroundColor: WidgetStateColor.resolveWith((states) => Colors.white),
        shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
