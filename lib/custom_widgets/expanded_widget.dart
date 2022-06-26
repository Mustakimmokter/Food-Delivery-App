import 'package:flutter/material.dart';
import 'package:food_delivery_app_one/custom_widgets/small_text.dart';

class ExpandedTextWidget extends StatefulWidget {
  final String? text;
  const ExpandedTextWidget({Key? key, required this.text}) : super(key: key);

  @override
  State<ExpandedTextWidget> createState() => _ExpandedTextWidgetState();
}

class _ExpandedTextWidgetState extends State<ExpandedTextWidget> {
  late String firstHalf, secondHalf;
  double textHeight = 120;
  bool hiddenText = true;

  @override
  void initState() {
    super.initState();
    if (widget.text!.length > textHeight) {
      firstHalf = widget.text!.substring(0, textHeight.toInt());
      secondHalf =
          widget.text!.substring(textHeight.toInt() + 1, widget.text!.length);
    } else {
      firstHalf = widget.text!;
      secondHalf = widget.text!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: secondHalf.isEmpty
          ? SmallText(text: firstHalf)
          : Column(
              children: [
                Text(
                  hiddenText ? (firstHalf + '...') : (firstHalf + secondHalf),
                  style: TextStyle(fontSize: 16),
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      hiddenText = !hiddenText;
                    });
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      SmallText(text: 'Show more', color: Colors.blue[200]),
                      Icon(
                        hiddenText
                            ? Icons.arrow_drop_down
                            : Icons.arrow_drop_up,
                        color: Colors.blue[200],
                      )
                    ],
                  ),
                )
              ],
            ),
    );
  }
}
