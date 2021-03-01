import 'package:flutter/material.dart';

class HeaderTextWidget extends StatelessWidget {
  final String lable;

  const HeaderTextWidget({Key key, @required this.lable}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 40),
      child: Text(
        lable.toUpperCase(),
        style: Theme.of(context).textTheme.headline6,
      ),
    );
  }
}
