import 'package:dotdo/shared/constant.dart';
import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/button/button_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/header_text/header_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/pvp_profile/pvp_profile_widget.dart';
import 'package:dotdo/widgets/smart_widgets/pvpchallenge/pvpchallenge_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'pvp_details_view_model.dart';

class PvpDetailsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PvpDetailsViewModel>.reactive(
      builder: (BuildContext context, PvpDetailsViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('PvP'),
            shape: appBarShapeBorder,
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceXSmall(context),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 170,
                    width: screenWidth(context),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Container(
                                width: screenWidth(context) * 0.4,
                                child: PvpProfileWidget(
                                    name: viewModel.user1Name,
                                    image: NetworkImage(viewModel.user1Avatar)),
                              ),
                              Expanded(
                                child: Center(
                                  child:
                                      DescriptionTextWidget(description: 'VS'),
                                ),
                              ),
                              Container(
                                width: screenWidth(context) * 0.4,
                                child: PvpProfileWidget(
                                    name: viewModel.user2Name,
                                    image: NetworkImage(viewModel.user2Avatar)),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                width: screenWidth(context) * 0.4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    LableTextWidget(
                                      lable: 'Wins',
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? AppColors.lightGreen
                                          : AppColors.darkGreen,
                                    ),
                                    LableTextWidget(
                                      lable: viewModel.noOfWins,
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? AppColors.lightGreen
                                          : AppColors.darkGreen,
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    LableTextWidget(
                                      lable: 'Draws',
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? AppColors.lightGold
                                          : AppColors.darkGold,
                                    ),
                                    LableTextWidget(
                                      lable: viewModel.noOfDraws,
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? AppColors.lightGold
                                          : AppColors.darkGold,
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                width: screenWidth(context) * 0.4,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    LableTextWidget(
                                      lable: 'Losses',
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? AppColors.lightRed
                                          : AppColors.darkRed,
                                    ),
                                    LableTextWidget(
                                      lable: viewModel.noOfLosses,
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? AppColors.lightRed
                                          : AppColors.darkRed,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: ButtonWidget(
                      onPressed: viewModel.newChallengeTapped,
                      text: 'New Challange'),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderTextWidget(lable: 'Active challange'),
                      verticalSpaceXSmall(context),
                      PvpchallengeWidget(
                        width: screenWidth(context),
                        onTap: viewModel.challengeTapped,
                        lable: 'Drink water',
                        profile1Named: viewModel.user1Name,
                        profile1ProgressValue: viewModel.noUser1TasksCompleted /
                            viewModel.noTotalTasks,
                        profile1Image: NetworkImage(viewModel.user1Avatar),
                        profile2Named: viewModel.user2Name,
                        profile2ProgressValue: viewModel.noUser2TasksCompleted /
                            viewModel.noTotalTasks,
                        profile2Image: NetworkImage(viewModel.user2Avatar),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => PvpDetailsViewModel(),
    );
  }
}
