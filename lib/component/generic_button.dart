import 'package:flutter/material.dart';

class GenericButton extends StatelessWidget {
  final Function() onTap;
  final Color backgroundColor;
  final Color fontColor;
  final String text;
  const GenericButton({
    super.key,
    required this.onTap,
    required this.backgroundColor,
    required this.fontColor,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        constraints: BoxConstraints(minWidth: 60, maxWidth: 200, minHeight: 36, maxHeight: 36),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 50),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: backgroundColor),
        child: Text(text, style: TextStyle(fontSize: 14, color: fontColor)),
      ),
    );
  }
}
