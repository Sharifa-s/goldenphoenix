
import 'package:flutter/material.dart';
import 'package:goldenphoenix/Design/colors.dart';

class Button extends StatelessWidget {
  final String title;
  final void Function()? onPressed;
  const Button({super.key, required this.title, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        side: BorderSide(color: MyColors.primaryColor),
        borderRadius: BorderRadius.circular(9.0),
      ),
      color: MyColors.primaryColor,
      padding: const EdgeInsets.symmetric(horizontal: 70, vertical: 20),
      onPressed: onPressed,
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white , fontFamily: 'EagleLake'),
      ),
    );
  }
}
