import 'package:dotdo/theme/colors.dart';
import 'package:flutter/material.dart';

class DescriptionTextWidget extends StatelessWidget {
  final String description;
  final double fontSize;
  final bool bold;
  final Color color;
  final int maxLines;

  const DescriptionTextWidget(
      {Key key,
      @required this.description,
      this.fontSize = 14,
      this.bold = false,
      this.color,
      this.maxLines = 1})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      style: TextStyle(
          fontWeight: bold ? FontWeight.bold : FontWeight.normal,
          fontSize: fontSize,
          color: color ??
              (Theme.of(context).brightness == Brightness.light
                  ? AppColors.lightGreen
                  : AppColors.darkGreen)),
    );
  }
}
