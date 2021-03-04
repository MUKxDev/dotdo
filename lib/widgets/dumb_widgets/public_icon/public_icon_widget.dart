import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PublicIconWidget extends StatelessWidget {
  final bool public;

  const PublicIconWidget({Key key, @required this.public}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return public
        ? Icon(
            FontAwesomeIcons.globeAmericas,
            size: 14,
            color: Theme.of(context).brightness == Brightness.light
                ? Colors.black38
                : Colors.white38,
          )
        : Container();
  }
}
