import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/models/PChallenge.dart';
import 'package:dotdo/core/models/pvp.dart';
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
  final String oppId;

  const PvpDetailsView({Key key, this.oppId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PvpDetailsViewModel>.reactive(
      onModelReady: (PvpDetailsViewModel viewModel) =>
          viewModel.handleOnStartup(oppId),
      builder: (BuildContext context, PvpDetailsViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('PvP'),
            shape: appBarShapeBorder,
          ),
          body: viewModel.isBusy
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        verticalSpaceXSmall(context),
                        // pvp card
                        StreamBuilder<QuerySnapshot>(
                            stream: viewModel.pvpCardStream,
                            builder: (context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              Pvp pvpCard;
                              if (snapshot.hasData) {
                                if (snapshot.data.size > 0) {
                                  pvpCard = Pvp.fromMap(
                                      snapshot.data.docs.first.data());
                                }
                              }
                              return Padding(
                                padding: const EdgeInsets.all(10),
                                child: Container(
                                  height: null,
                                  width: screenWidth(context),
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: snapshot.hasData == false
                                      ? Container(
                                          child: Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                        )
                                      : snapshot.data.size == 0
                                          ? Container(
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            )
                                          : Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(10),
                                                  child: Row(
                                                    children: [
                                                      Container(
                                                        width: screenWidth(
                                                                context) *
                                                            0.4,
                                                        child: PvpProfileWidget(
                                                            name: viewModel
                                                                .userA.userName,
                                                            image: NetworkImage(
                                                                viewModel.userA
                                                                    .profilePic)),
                                                      ),
                                                      Expanded(
                                                        child: Center(
                                                          child:
                                                              DescriptionTextWidget(
                                                                  description:
                                                                      'VS'),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: screenWidth(
                                                                context) *
                                                            0.4,
                                                        child: PvpProfileWidget(
                                                            name: viewModel
                                                                .userB.userName,
                                                            image: NetworkImage(
                                                                viewModel.userB
                                                                    .profilePic)),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 8.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      Container(
                                                        width: screenWidth(
                                                                context) *
                                                            0.4,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            LableTextWidget(
                                                              lable: 'Wins',
                                                              color: Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light
                                                                  ? AppColors
                                                                      .lightGreen
                                                                  : AppColors
                                                                      .darkGreen,
                                                            ),
                                                            LableTextWidget(
                                                              lable: pvpCard
                                                                  .aWinng
                                                                  .toString(),
                                                              color: Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light
                                                                  ? AppColors
                                                                      .lightGreen
                                                                  : AppColors
                                                                      .darkGreen,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Column(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          LableTextWidget(
                                                            lable: 'Draws',
                                                            color: Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light
                                                                ? AppColors
                                                                    .lightGold
                                                                : AppColors
                                                                    .darkGold,
                                                          ),
                                                          LableTextWidget(
                                                            lable: pvpCard.draws
                                                                .toString(),
                                                            color: Theme.of(context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light
                                                                ? AppColors
                                                                    .lightGold
                                                                : AppColors
                                                                    .darkGold,
                                                          ),
                                                        ],
                                                      ),
                                                      Container(
                                                        width: screenWidth(
                                                                context) *
                                                            0.4,
                                                        child: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            LableTextWidget(
                                                              lable: 'Wins',
                                                              color: Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light
                                                                  ? AppColors
                                                                      .lightGreen
                                                                  : AppColors
                                                                      .darkGreen,
                                                            ),
                                                            LableTextWidget(
                                                              lable: pvpCard
                                                                  .bWinning
                                                                  .toString(),
                                                              color: Theme.of(context)
                                                                          .brightness ==
                                                                      Brightness
                                                                          .light
                                                                  ? AppColors
                                                                      .lightGreen
                                                                  : AppColors
                                                                      .darkGreen,
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
                              );
                            }),

                        // pvp active challange
                        StreamBuilder<QuerySnapshot>(
                          stream: viewModel.activeChallangeStream,
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            PChallenge pvpChallenge;
                            if (snapshot.hasData) {
                              if (snapshot.data.size > 0) {
                                pvpChallenge = PChallenge.fromMap(
                                    snapshot.data.docs.first.data());
                              }
                            }
                            return snapshot.hasData == false
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: ButtonWidget(
                                        onPressed: viewModel.newChallengeTapped,
                                        text: 'New Challange'),
                                  )
                                : snapshot.data.size == 0
                                    ? Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: ButtonWidget(
                                            onPressed:
                                                viewModel.newChallengeTapped,
                                            text: 'New Challange'),
                                      )
                                    : Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            HeaderTextWidget(
                                                lable: 'Active challange'),
                                            verticalSpaceXSmall(context),
                                            PvpchallengeWidget(
                                              width: screenWidth(context),
                                              onTap: () => viewModel
                                                  .challengeTapped(snapshot
                                                      .data.docs.first.id),
                                              lable: pvpChallenge.name,
                                              profile1Named:
                                                  viewModel.userA.userName,
                                              profile1ProgressValue:
                                                  pvpChallenge.noOfTasks == 0
                                                      ? 0
                                                      : pvpChallenge.aCTask /
                                                          pvpChallenge
                                                              .noOfTasks,
                                              profile1Image: NetworkImage(
                                                  viewModel.userA.profilePic),
                                              profile2Named:
                                                  viewModel.userB.userName,
                                              profile2ProgressValue:
                                                  pvpChallenge.noOfTasks == 0
                                                      ? 0
                                                      : pvpChallenge.bCTask /
                                                          pvpChallenge
                                                              .noOfTasks,
                                              profile2Image: NetworkImage(
                                                  viewModel.userB.profilePic),
                                            ),
                                          ],
                                        ),
                                      );
                          },
                        ),
                        // Pvp history button
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: ButtonWidget(
                              onPressed: viewModel.historyTapped,
                              text: 'History'),
                        ),
                        // Pvp pending button
                        viewModel.isThereActiveChallange
                            ? Container()
                            : Row(
                                children: [
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 10,
                                        right: 10,
                                        left: 10,
                                      ),
                                      child: ButtonWidget(
                                          onPressed: viewModel.pendingTapped,
                                          text: 'Pending'),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                      bottom: 10,
                                      right: 10,
                                    ),
                                    child: Container(
                                      height: 60,
                                      width: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: Theme.of(context).brightness ==
                                                Brightness.light
                                            ? AppColors.lightRed
                                            : AppColors.darkRed,
                                      ),
                                      child: Center(
                                        child: LableTextWidget(
                                            color: AppColors.white,
                                            lable:
                                                viewModel.getNoOfPending == null
                                                    ? '0'
                                                    : viewModel.getNoOfPending
                                                        .toString()),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                      ],
                    ),
                  ),
                ),
        );
      },
      viewModelBuilder: () => PvpDetailsViewModel(),
    );
  }
}
