import 'package:dotdo/theme/colors.dart';
import 'package:flutter/material.dart';

class DescriptionTextWidget extends StatelessWidget {
  final String description;
  final double fontSize;
  final bool bold;

  const DescriptionTextWidget(
      {Key key,
      @required this.description,
      this.fontSize = 14,
      this.bold = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: TextStyle(
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        fontSize: fontSize,
        color: Theme.of(context).brightness == Brightness.light
            ? AppColors.lightGreen
            : AppColors.darkGreen,
      ),
    );
  }
}
