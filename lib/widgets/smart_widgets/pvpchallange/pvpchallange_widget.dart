import 'package:dotdo/widgets/dumb_widgets/card/card_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/pvp_profile/pvp_profile_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'pvpchallange_view_model.dart';

class PvpchallangeWidget extends StatelessWidget {
  final Function onTap;
  final String lable;

  final String profile1Named;
  final double profile1ProgressValue;
  final ImageProvider<Object> profile1Image;

  final String profile2Named;
  final double profile2ProgressValue;
  final ImageProvider<Object> profile2Image;

  // ? I don't know about this
  const PvpchallangeWidget({
    Key key,
    @required this.onTap,
    @required this.lable,
    @required this.profile1Named,
    @required this.profile1ProgressValue,
    @required this.profile1Image,
    @required this.profile2Named,
    @required this.profile2ProgressValue,
    @required this.profile2Image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PvpchallangeViewModel>.reactive(
      builder:
          (BuildContext context, PvpchallangeViewModel viewModel, Widget _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: CardWidget(
            height: 140,
            width: 300,
            borderRadius: 20,
            padding: 10,
            onTap: onTap,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                LableTextWidget(lable: lable),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // * PVP Profile wedgit
                    PvpProfileWidget(
                      name: profile1Named,
                      progressValue: profile1ProgressValue,
                      image: profile1Image,
                    ),
                    Center(
                      child: LableTextWidget(
                        lable: 'VS',
                      ),
                    ),
                    PvpProfileWidget(
                      name: profile2Named,
                      progressValue: profile2ProgressValue,
                      image: profile2Image,
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => PvpchallangeViewModel(),
    );
  }
}
