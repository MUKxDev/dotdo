import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/button/button_widget.dart';
import 'package:flutter/material.dart';

// TODO: to be deleted or changed to smart
class TapbarWidget extends StatelessWidget {
  final bool mode;
  final Function toggleMode;
  final String tab1text;
  final String tab2text;
  final Color backgroundColor;

  const TapbarWidget(
      {Key key,
      @required this.mode,
      @required this.toggleMode,
      @required this.tab1text,
      @required this.tab2text,
      this.backgroundColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
      child: Container(
        height: 50,
        width: screenWidth(context),
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonWidget(
                onPressed: () => toggleMode,
                text: tab1text,
                width: screenWidth(context) * 0.44,
                borderRadius: 5,
                fontSize: 14,
                backgroundColor: mode
                    ? (backgroundColor ?? Theme.of(context).accentColor)
                    : (backgroundColor?.withAlpha(0) ??
                        Theme.of(context).accentColor.withAlpha(0)),
                textColor: Theme.of(context).brightness == Brightness.light
                    ? (mode
                        ? AppColors.white
                        : AppColors.darkBackground.withAlpha(200))
                    : (mode ? AppColors.white : AppColors.white.withAlpha(100)),
              ),
              ButtonWidget(
                onPressed: () => toggleMode,
                text: tab2text,
                width: screenWidth(context) * 0.44,
                borderRadius: 5,
                fontSize: 14,
                backgroundColor: mode
                    ? (backgroundColor?.withAlpha(0) ??
                        Theme.of(context).accentColor.withAlpha(0))
                    : (backgroundColor ?? Theme.of(context).accentColor),
                textColor: Theme.of(context).brightness == Brightness.light
                    ? (mode
                        ? AppColors.darkBackground.withAlpha(200)
                        : AppColors.white)
                    : (mode ? AppColors.white.withAlpha(100) : AppColors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
