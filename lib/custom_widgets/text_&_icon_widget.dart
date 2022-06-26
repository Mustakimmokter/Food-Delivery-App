import 'package:flutter/material.dart';
import 'package:food_delivery_app_one/custom_widgets/small_text.dart';

class TextAndIconWidget extends StatelessWidget {
  final String? text;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;
  const TextAndIconWidget(
      {Key? key,
      required this.text,
      required this.icon,
      this.iconColor = Colors.red,
      this.iconSize = 20})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: iconColor,
          size: iconSize,
        ),
        SizedBox(width: 04),
        SmallText(text: text!),
      ],
    );
  }
}
