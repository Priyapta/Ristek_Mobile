import 'package:flutter/material.dart';

class PriorityButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final bool buttonpress;
  final String text;
  final double screen;
  final Color color;

  const PriorityButton(
      {super.key,
      required this.onPressed,
      required this.buttonpress,
      required this.text,
      required this.screen,
      required this.color});

  @override
  State<PriorityButton> createState() => _PriorityButtonState();
}

class _PriorityButtonState extends State<PriorityButton> {
  @override
  Widget build(BuildContext context) {
    final bool button;

    Color textColor = widget.buttonpress ? Colors.white : Colors.deepPurple;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25),
      child: GestureDetector(
        onTap: widget.onPressed,
        child: Container(
          width: widget.screen,
          padding: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: widget.color,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: Colors.black),
          ),
          child: Center(
            child: Text(
              widget.text,
              style: TextStyle(
                  fontSize: 18, color: textColor, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
