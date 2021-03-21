import 'package:flutter/material.dart';

class IconButtonWidget extends StatelessWidget {
  final Function onTap;
  final Color backgroundColor;
  final Color iconColor;
  final double height;
  final double width;
  final IconData iconData;
  final double iconSize;

  const IconButtonWidget(
      {Key key,
      @required this.onTap,
      this.backgroundColor,
      this.height = 50,
      this.width = 50,
      this.iconColor,
      @required this.iconData,
      this.iconSize = 24})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onTap,
      child: Container(
        height: height,
        width: width,
        child: Icon(
          iconData,
          color: iconColor ?? Theme.of(context).accentColor,
          size: iconSize,
        ),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          backgroundColor ?? Theme.of(context).primaryColor,
        ),
        shape: MaterialStateProperty.all<CircleBorder>(
          CircleBorder(),
        ),
      ),
    );
  }
}
