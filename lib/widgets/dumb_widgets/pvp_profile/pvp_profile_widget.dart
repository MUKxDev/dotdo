import 'package:dotdo/widgets/dumb_widgets/prograss_bar/prograss_bar_widget.dart';
import 'package:flutter/material.dart';

class PvpProfileWidget extends StatelessWidget {
  final String name;
  final double progressValue;
  final ImageProvider<Object> image;

  const PvpProfileWidget({
    Key key,
    @required this.name,
    @required this.progressValue,
    @required this.image,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 40,
              width: 40,
              child: Image(
                image: image,
              ),
            ),
          ),
        ),
        Center(child: Text(name)),
        Container(
          width: 120,
          child: PrograssBarWidget(progressValue: progressValue),
        ),
      ],
    );
  }
}
