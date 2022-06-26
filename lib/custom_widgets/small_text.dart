import 'package:flutter/material.dart';

class SmallText extends StatelessWidget {
  final Color? color;
  final double? height;
  final String? text;
  final double? size;
  final TextOverflow textOverflow;
  const SmallText(
      {Key? key,
      this.color = Colors.black54,
      this.height = 1.5,
      required this.text,
      this.size = 15,
      this.textOverflow = TextOverflow.ellipsis})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      style: TextStyle(
          fontSize: size, height: height, color: color, overflow: textOverflow),
    );
  }
}
