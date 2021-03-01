import 'package:dotdo/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      @required this.public,
      @required this.iconData,
      @required this.iconColor,
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
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(20),
            child: Ink(
              height: 100,
              width: 150,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // * Public Icon
                        public
                            ? Icon(
                                FontAwesomeIcons.globeAmericas,
                                size: 14,
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? Colors.black38
                                    : Colors.white38,
                              )
                            : Container(),
                        // * Challange Icon
                        Icon(
                          iconData,
                          size: 24,
                          color: iconColor,
                        ),
                      ],
                    ),
                    // * Description
                    Text(
                      description,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(color: AppColors.darkGreen),
                    ),
                    // * Lable
                    Text(
                      lable,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    // * Prograss bar
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: LinearProgressIndicator(
                          value: progressValue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => ActiveChallangeCardViewModel(),
    );
  }
}
