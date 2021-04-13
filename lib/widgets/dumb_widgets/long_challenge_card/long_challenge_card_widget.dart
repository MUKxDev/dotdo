import 'package:dotdo/core/models/challenge.dart';
import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/card/card_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/prograss_bar/prograss_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LongChallengeCardWidget extends StatelessWidget {
  final Challenge challenge;
  final Function onTap;

  const LongChallengeCardWidget(
      {Key key, @required this.challenge, @required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return // * Challenge card
        CardWidget(
      height: 80,
      width: screenWidth(context),
      backgroundcolor: Theme.of(context).brightness == Brightness.light
          ? AppColors.lightChallenge
          : AppColors.darkChallenge,
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
                      description: challenge.note,
                      color: AppColors.white.withAlpha(200),
                    ),
                    // * Lable
                    LableTextWidget(
                      lable: challenge.name,
                      color: AppColors.white,
                    ),
                  ],
                ),
              ),

              // * Challenge Icon
              challenge.iconData != null
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
                        IconDataSolid(challenge.iconData.codePoint),
                        size: 24,
                        color: challenge.iconColor,
                      ),
                    )
                  : Container(
                      height: 45,
                    ),
            ],
          ),

          // * Prograss bar
          PrograssBarWidget(
            progressValue: challenge.noOfTasks == 0
                ? 0
                : challenge.noOfCompletedTasks / challenge.noOfTasks,
          ),
        ],
      ),
    );
  }
}
