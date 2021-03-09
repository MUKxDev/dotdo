import 'package:dotdo/theme/colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final Function onPressed;
  final double height;
  final double width;
  final double borderRadius;
  final String text;
  final Color textColor;
  final Color backgroundColor;
  final Color backgroundOnPressedColor;
  final double fontSize;
  final FontWeight fontWeight;

  const ButtonWidget({
    Key key,
    @required this.onPressed,
    this.height = 60,
    this.width = double.infinity,
    this.borderRadius = 20,
    @required this.text,
    this.textColor = AppColors.white,
    this.backgroundColor,
    this.fontSize = 18,
    this.fontWeight = FontWeight.bold,
    this.backgroundOnPressedColor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      child: TextButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.resolveWith<RoundedRectangleBorder>(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          backgroundColor: MaterialStateProperty.resolveWith<Color>(
            (Set<MaterialState> states) {
              if (states.contains(MaterialState.pressed))
                return backgroundOnPressedColor ??
                    Theme.of(context).accentColor.withOpacity(0.5);
              return backgroundColor ?? Theme.of(context).accentColor; // Else.
            },
          ),
        ),
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: fontWeight,
            fontSize: fontSize,
          ),
        ),
      ),
    );
  }
}
