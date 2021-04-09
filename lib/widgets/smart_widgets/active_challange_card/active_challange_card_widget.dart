import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/card/card_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/prograss_bar/prograss_bar_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/public_icon/public_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'active_challange_card_view_model.dart';

class ActiveChallangeCardWidget extends StatelessWidget {
  final bool public;
  final IconData iconData;
  final Color iconColor;
  final String lable;
  final String description;
  final double progressValue;
  final Function onTap;

  const ActiveChallangeCardWidget(
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
    return ViewModelBuilder<ActiveChallangeCardViewModel>.reactive(
      builder: (BuildContext context, ActiveChallangeCardViewModel viewModel,
          Widget _) {
        return CardWidget(
          borderRadius: 20,
          height: 100,
          width: 150,
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
                  // * Challange Icon
                  iconData != null
                      ? Icon(
                          iconData,
                          size: 24,
                          color: iconColor ??
                              (Theme.of(context).brightness == Brightness.light
                                  ? AppColors.lightGreen
                                  : AppColors.darkGreen),
                        )
                      : Container(
                          height: 24,
                        ),
                ],
              ),
              // * Description
              DescriptionTextWidget(
                description: description,
                // color: AppColors.darkRoutine,
              ),
              // * Lable
              LableTextWidget(lable: lable),
              // * Prograss bar
              PrograssBarWidget(
                progressValue: progressValue,
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => ActiveChallangeCardViewModel(),
    );
  }
}
