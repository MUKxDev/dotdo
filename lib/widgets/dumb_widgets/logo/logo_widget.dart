import 'package:dotdo/svg/svg.dart';
import 'package:flutter/material.dart';

class LogoWidget extends StatelessWidget {
  final double height;
  final double width;

  const LogoWidget({Key key, this.height, this.width}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return //* .Do logo svg
        Theme.of(context).brightness == Brightness.light
            ? Hero(
                tag: '_logoSvglight',
                child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Container(
                      child: logoSvgLight,
                      height: height ?? 80,
                      width: width ?? 80,
                    )),
              )
            : Hero(
                tag: '_logoSvgDark',
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    child: logoSvgDark,
                    height: height ?? 80,
                    width: width ?? 80,
                  ),
                ),
              );
  }
}
