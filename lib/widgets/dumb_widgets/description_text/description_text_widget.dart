import 'package:dotdo/theme/colors.dart';
import 'package:flutter/material.dart';

class DescriptionTextWidget extends StatelessWidget {
  final String description;

  const DescriptionTextWidget({Key key, @required this.description})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      overflow: TextOverflow.ellipsis,
      maxLines: 1,
      style: TextStyle(
        color: Theme.of(context).brightness == Brightness.light
            ? AppColors.lightGreen
            : AppColors.darkGreen,
      ),
    );
  }
}
