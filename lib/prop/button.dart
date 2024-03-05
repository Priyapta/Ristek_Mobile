import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color color;
  const Button(
      {super.key,
      required this.text,
      required this.onPressed,
      required this.color});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Container(
            padding: EdgeInsets.symmetric(vertical: 6),
            decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.black)),
            child: Center(
              child: Text(
                text,
                style: TextStyle(fontSize: 18, color: Colors.white),
              ),
            )),
      ),
    );
  }
}
