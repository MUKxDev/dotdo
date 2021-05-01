import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/card/card_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/public_icon/public_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'inactive_challenge_card_view_model.dart';

class InactiveChallengeCardWidget extends StatelessWidget {
  final bool public;
  final IconData iconData;
  final Color iconColor;
  final String lable;
  final Function onTap;
  final Color backgroundcolor;
  final int likes;

  const InactiveChallengeCardWidget(
      {Key key,
      this.public = false,
      @required this.iconData,
      @required this.iconColor,
      @required this.lable,
      @required this.onTap,
      this.backgroundcolor,
      this.likes})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<InactiveChallengeCardViewModel>.reactive(
      builder: (BuildContext context, InactiveChallengeCardViewModel viewModel,
          Widget _) {
        return CardWidget(
          backgroundcolor: backgroundcolor,
          borderRadius: 20,
          height: 100,
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
                  likes == null
                      ? Container()
                      : DescriptionTextWidget(
                          color: AppColors.white.withAlpha(200),
                          description: 'Likes: ${likes.toString()}'),
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
              // * Lable
              LableTextWidget(
                color: backgroundcolor == null ? null : AppColors.white,
                lable: viewModel.capitalize(lable),
                maxLines: 2,
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => InactiveChallengeCardViewModel(),
    );
  }
}
