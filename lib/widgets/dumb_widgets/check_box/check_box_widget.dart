import 'package:dotdo/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CheckBoxWidget extends StatelessWidget {
  final bool checked;
  final Function onTap;

  const CheckBoxWidget({Key key, @required this.checked, @required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Material(
        color: Theme.of(context).scaffoldBackgroundColor.withAlpha(150),
        borderRadius: BorderRadius.circular(5),
        child: InkWell(
          borderRadius: BorderRadius.circular(5),
          onTap: onTap,
          child: Ink(
            height: 19,
            width: 19,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
            ),
            child: checked
                ? Icon(
                    FontAwesomeIcons.check,
                    size: 14,
                    color: Theme.of(context).brightness == Brightness.light
                        ? AppColors.lightGreen
                        : AppColors.darkGreen,
                  )
                : Container(),
          ),
        ),
      ),
    );
  }
}
