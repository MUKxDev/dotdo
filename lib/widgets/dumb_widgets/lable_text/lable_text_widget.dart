import 'package:flutter/material.dart';

class LableTextWidget extends StatelessWidget {
  final String lable;
  final int maxLines;

  const LableTextWidget({Key key, @required this.lable, this.maxLines = 1})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      lable,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }
}
