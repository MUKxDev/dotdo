import 'package:flutter/material.dart';

class LableTextWidget extends StatelessWidget {
  final String lable;

  const LableTextWidget({Key key, @required this.lable}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      lable,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 16,
      ),
    );
  }
}
