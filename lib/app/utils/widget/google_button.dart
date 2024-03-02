import 'package:flutter/material.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Image.asset(
          //   "assets/images/google.png",
          //   width: 20,
          // ),
          SizedBox(
            width: 10,
          ),
          Text("Google"),
        ],
      ),
      style: ButtonStyle(
        minimumSize: MaterialStateProperty.all(Size(370, 40)),
        shadowColor: MaterialStateProperty.all(Colors.transparent),
        backgroundColor:
            MaterialStateColor.resolveWith((states) => Colors.white),
        foregroundColor:
            MaterialStateColor.resolveWith((states) => Colors.black),
        shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10))),
      ),
    );
  }
}