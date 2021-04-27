import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/card/card_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/prograss_bar/prograss_bar_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/public_icon/public_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'active_challenge_card_view_model.dart';

class ActiveChallengeCardWidget extends StatelessWidget {
  final bool public;
  final IconData iconData;
  final Color iconColor;
  final String lable;
  final String description;
  final double progressValue;
  final Function onTap;

  const ActiveChallengeCardWidget(
      {Key key,
      this.public = false,
      this.iconData,
      this.iconColor,
      @required this.lable,
      @required this.description,
      @required this.progressValue,
      @required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ActiveChallengeCardViewModel>.reactive(
      builder: (BuildContext context, ActiveChallengeCardViewModel viewModel,
          Widget _) {
        return CardWidget(
          backgroundcolor: Theme.of(context).brightness == Brightness.light
              ? AppColors.lightChallenge
              : AppColors.darkChallenge,
          borderRadius: 20,
          height: 120,
          width: 160,
          onTap: onTap,
          padding: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // * Public Icon
                  PublicIconWidget(public: public),
                  // * Challenge Icon
                  iconData != null
                      ? Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            color:
                                Theme.of(context).brightness == Brightness.light
                                    ? Theme.of(context)
                                        .scaffoldBackgroundColor
                                        .withAlpha(200)
                                    : Theme.of(context)
                                        .scaffoldBackgroundColor
                                        .withAlpha(150),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            IconDataSolid(iconData.codePoint),
                            size: 20,
                            color: iconColor,
                          ),
                        )
                      : Container(
                          height: 24,
                        ),
                ],
              ),
              // * Description
              DescriptionTextWidget(
                description: description,
                color: Theme.of(context).brightness == Brightness.light
                    ? AppColors.white.withAlpha(200)
                    : null,
                // color: AppColors.darkRoutine,
              ),
              // * Lable
              LableTextWidget(
                lable: lable,
                color: Theme.of(context).brightness == Brightness.light
                    ? AppColors.white
                    : null,
              ),
              // * Prograss bar
              PrograssBarWidget(
                progressValue: progressValue,
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => ActiveChallengeCardViewModel(),
    );
  }
}
