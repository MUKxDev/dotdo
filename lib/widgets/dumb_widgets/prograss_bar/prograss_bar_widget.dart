import 'package:flutter/material.dart';

class PrograssBarWidget extends StatelessWidget {
  final double progressValue;
  final Color color;
  const PrograssBarWidget({Key key, @required this.progressValue, this.color})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: LinearProgressIndicator(
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? Colors.black26
              : Colors.white30,
          value: progressValue,
          valueColor:
              color == null ? null : AlwaysStoppedAnimation<Color>(color),
        ),
      ),
    );
  }
}
