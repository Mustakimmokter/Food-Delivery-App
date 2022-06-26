import 'package:flutter/material.dart';

class BigText extends StatelessWidget {
  final String? text;
  final double? size;
  final TextOverflow? overflow;
  final Color? color;
  const BigText(
      {Key? key,
      required this.text,
      this.size = 20,
      this.overflow = TextOverflow.ellipsis,
      this.color = Colors.lightBlueAccent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text!,
      overflow: overflow,
      style:
          TextStyle(fontSize: size, color: color, fontWeight: FontWeight.w500),
    );
  }
}
