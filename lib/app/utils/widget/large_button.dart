import 'package:flutter/material.dart';
import 'package:tzens/app/utils/constant/color.dart';

class LargeButton extends StatelessWidget {
  final String text;
  final Function()? onPressed;

  const LargeButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: onPressed,
      child: Text(text),
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size(370, 40)),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        backgroundColor:
            MaterialStateColor.resolveWith((states) => primaryColor),
        foregroundColor:
            MaterialStateColor.resolveWith((states) => Colors.white),
        shape: MaterialStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}
