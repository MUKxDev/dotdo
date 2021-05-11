import 'package:dotdo/core/models/Routine.dart';
import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/card/card_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/prograss_bar/prograss_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LongRoutineCardWidget extends StatelessWidget {
  final Routine routine;
  final Function onTap;
  final bool showPrograssBar;
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
  const LongRoutineCardWidget(
      {Key key,
      @required this.routine,
      @required this.onTap,
      this.showPrograssBar = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return
        // * Routine card
        CardWidget(
      height: null,
      width: screenWidth(context),
      backgroundcolor: Theme.of(context).brightness == Brightness.light
          ? AppColors.lightRoutine
          : AppColors.darkRoutine,
      onTap: () => onTap(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // * Description
                    DescriptionTextWidget(
                      description: routine.note,
                      color: AppColors.white.withAlpha(200),
                    ),
                    // * Lable
                    LableTextWidget(
                      lable: capitalize(routine.name),
                      color: AppColors.white,
                    ),
                  ],
                ),
              ),

              // * Routine Icon
              routine.iconData != null
                  ? Container(
                      height: 45,
                      width: 45,
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .scaffoldBackgroundColor
                            .withAlpha(150),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        IconDataSolid(routine.iconData.codePoint),
                        size: 24,
                        color: routine.iconColor,
                      ),
                    )
                  : Container(
                      height: 45,
                    ),
            ],
          ),

          // * Prograss bar
          showPrograssBar
              ? PrograssBarWidget(
                  color: AppColors.lightYellow,
                  progressValue: routine.noOfTasks == 0
                      ? 0
                      : routine.noOfCompletedTasks / routine.noOfTasks,
                )
              : Container(),
        ],
      ),
    );
  }
}
