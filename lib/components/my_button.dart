import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final color;
  final textColor;

  const MyButton({
    super.key, 
    required this.text,
    required this.onTap,
    this.color,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 80,
        width: 88,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(500),
        ),
        padding: const EdgeInsets.all(5),
        margin: const EdgeInsets.all(5),
        child: Center(
          child: Text(text, style: TextStyle(color: textColor, fontSize: 28),),
          ),
      ),
    );
  }
}