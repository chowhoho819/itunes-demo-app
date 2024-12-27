import 'package:flutter/material.dart';

class Warning extends StatelessWidget {
  final IconData? warningIcon;
  final String warningText;
  const Warning({super.key, this.warningIcon, required this.warningText});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: Column(
        spacing: 15,
        children: [
          Icon(warningIcon ?? Icons.warning, size: 80),
          Text(warningText, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}
