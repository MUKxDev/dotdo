import 'package:dotdo/core/models/challange.dart';
import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/card/card_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/prograss_bar/prograss_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LongChallangeCardWidget extends StatelessWidget {
  final Challange challange;
  final Function onTap;

  const LongChallangeCardWidget(
      {Key key, @required this.challange, @required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return // * Challange card
        CardWidget(
      backgroundcolor: Theme.of(context).brightness == Brightness.light
          ? AppColors.lightChallange
          : AppColors.darkChallange,
      onTap: () => onTap(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // * Description
                    DescriptionTextWidget(
                      description: challange.note,
                      color: AppColors.white.withAlpha(200),
                    ),
                    // * Lable
                    LableTextWidget(
                      lable: challange.name,
                      color: AppColors.white,
                    ),
                  ],
                ),

                // * Challange Icon
                challange.iconData != null
                    ? Icon(
                        IconDataSolid(challange.iconData.codePoint),
                        size: 24,
                        color: challange.iconColor ??
                            (Theme.of(context).brightness == Brightness.light
                                ? AppColors.lightGreen
                                : AppColors.darkGreen),
                      )
                    : Container(
                        height: 24,
                      ),
              ],
            ),

            // * Prograss bar
            PrograssBarWidget(
              progressValue: challange.noOfTasks == 0
                  ? 0
                  : challange.noOfCompletedTasks / challange.noOfTasks,
            ),
          ],
        ),
      ),
      height: 80,
      width: screenWidth(context),
    );
  }
}
