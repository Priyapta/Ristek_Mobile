import 'package:flutter/material.dart';

class ProfileName extends StatelessWidget {
  final String object;
  final IconData? icon;

  const ProfileName({super.key, required this.object, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 16.0, right: 16.0, top: 3, bottom: 15),
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            if (icon != null) Icon(icon),
            if (icon != null)
              SizedBox(
                width: 5,
              ),
            Expanded(
                child: Text(
              object,
              style:
                  TextStyle(fontFamily: "roboto", fontWeight: FontWeight.w700),
            )),
          ],
        ),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
