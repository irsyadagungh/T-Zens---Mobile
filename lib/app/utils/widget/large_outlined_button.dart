import 'package:flutter/material.dart';
import 'package:tzens/app/utils/constant/color.dart';

class LargeOutlinedButton extends StatelessWidget {
  final onPressed;

  const LargeOutlinedButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text("Provider",
          style: TextStyle(
            color: primaryColor,
          )),
      style: ButtonStyle(
        side: MaterialStateProperty.all(
          BorderSide(
            color: primaryColor,
          ),
        ),
        shape: MaterialStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
