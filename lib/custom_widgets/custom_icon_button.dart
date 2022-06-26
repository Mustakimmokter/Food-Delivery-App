import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Widget? child;
  final IconData? icon;
  final Color? iconColor;
  final Function()? onTap;
  final double? iconSize;
  const CustomIconButton(
      {Key? key,
      this.child,
      this.icon,
      this.iconColor,
      required this.onTap,
      this.iconSize})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: child ??
          Icon(
            icon,
            color: iconColor,
            size: iconSize,
          ),
    );
  }
}
