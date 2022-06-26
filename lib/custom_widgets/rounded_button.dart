import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  final IconData? icon;
  final Color? backgroundColor;
  final Color? iconColor;
  final double? iconSize;
  final double? width;
  final double? height;
  final double? radius;
  final Function()? onTap;
  final Widget? child;

  const RoundedButton(
      {Key? key,
      this.icon,
      this.backgroundColor = Colors.grey,
      this.iconColor = Colors.black54,
      this.iconSize = 30,
      this.width = 50,
      this.height = 50,
      this.radius = 10,
      required this.onTap,
      this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(radius!),
        ),
        child: child ??
            Icon(
              icon,
              size: iconSize,
              color: iconColor,
            ),
      ),
      onTap: onTap,
    );
  }
}
