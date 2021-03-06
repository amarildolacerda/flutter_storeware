import 'package:flutter/material.dart';

class LabeledText extends StatelessWidget {
  final Widget? label;
  final Widget? text;
  final double? width;
  final double? height;
  final Color? color;
  const LabeledText(
      {Key? key, this.label, this.text, this.color, this.width, this.height})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: color ?? Colors.grey.withAlpha(10),
      margin: EdgeInsets.all(1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(child: label, height: 16, width: double.infinity),
          Divider(),
          text!
        ],
      ),
    );
  }
}
