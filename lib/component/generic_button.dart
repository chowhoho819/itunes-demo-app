import 'package:flutter/material.dart';

class GenericButton extends StatefulWidget {
  final Function() onTap;
  final Color backgroundColor;
  final Color? fontColor;
  final String? text;
  final IconData? icon;
  final bool? shrink;
  final IconData? expandedIcon;

  const GenericButton.text({
    super.key,
    required this.onTap,
    required this.backgroundColor,
    required this.fontColor,
    required this.text,
    this.shrink,
  })  : icon = null,
        expandedIcon = null;

  const GenericButton.icon({
    super.key,
    required this.onTap,
    required this.backgroundColor,
    required this.icon,
    this.shrink,
  })  : text = null,
        fontColor = null,
        expandedIcon = null;

  const GenericButton.expandAble({
    super.key,
    required this.onTap,
    required this.backgroundColor,
    required this.icon,
    this.shrink,
    this.expandedIcon,
  })  : text = null,
        fontColor = null;

  @override
  State<GenericButton> createState() => _GenericButtonState();
}

class _GenericButtonState extends State<GenericButton> {
  bool _isExpanded = false;

  void _handleTap() {
    if (widget.expandedIcon != null && _isExpanded == false) {
      setState(() {
        _isExpanded = true;
      });
    } else if (widget.expandedIcon != null && _isExpanded == true) {
      setState(() {
        _isExpanded = false;
      });
    }
    widget.onTap();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: _shrinkBuilder(
        _childBuilder(),
      ),
    );
  }

  Widget _shrinkBuilder(Widget child) {
    if (widget.shrink == true) {
      return Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: widget.backgroundColor),
        child: child,
      );
    } else {
      return Container(
        constraints: BoxConstraints(minWidth: 60, maxWidth: 200, minHeight: 36, maxHeight: 36),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 50),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5), color: widget.backgroundColor),
        child: child,
      );
    }
  }

  Widget _childBuilder() {
    if (widget.text != null) {
      return Text(widget.text!, style: TextStyle(fontSize: 14, color: widget.fontColor));
    }
    if (widget.icon != null && _isExpanded == false) {
      return Icon(widget.icon, color: Colors.white, size: 30);
    }
    if (widget.expandedIcon != null && _isExpanded == true) {
      return Icon(widget.expandedIcon, color: Colors.white, size: 30);
    }
    // fall back case
    return Container();
  }
}
