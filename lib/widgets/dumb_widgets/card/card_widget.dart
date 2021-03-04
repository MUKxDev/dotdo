import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final Function onTap;
  final Widget child;
  final double height;
  final double width;
  final double borderRadius;
  final double padding;
  const CardWidget(
      {Key key,
      @required this.onTap,
      @required this.child,
      @required this.height,
      @required this.width,
      @required this.borderRadius,
      @required this.padding})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Material(
        borderRadius: BorderRadius.circular(borderRadius),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(borderRadius),
          child: Ink(
            height: height,
            width: width,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.circular(borderRadius),
            ),
            child: Padding(
              padding: EdgeInsets.all(padding),
              child: child,
            ),
          ),
        ),
      ),
    );
  }
}
