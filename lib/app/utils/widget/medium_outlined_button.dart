import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tzens/app/modules/register/views/register_view.dart';
import 'package:tzens/app/utils/constant/color.dart';

class MediumOutlinedButton extends StatelessWidget {
  final onPressed;

  const MediumOutlinedButton({
    super.key,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: onPressed,
      child: Text("Provider",
          style: TextStyle(
            color: Theme.of(context).colorScheme.primary,
          )),
      style: ButtonStyle(
        side: MaterialStateProperty.all(
          BorderSide(
            color: Theme.of(context).colorScheme.primary,
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
