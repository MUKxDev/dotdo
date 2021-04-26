import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/models/PChallenge.dart';
import 'package:dotdo/shared/constant.dart';
import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/icon_button/icon_button_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:dotdo/widgets/smart_widgets/pvpchallenge/pvpchallenge_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'pvp_pending_view_model.dart';

class PvpPendingView extends StatelessWidget {
  final String pvpId;

  const PvpPendingView({Key key, this.pvpId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PvpPendingViewModel>.reactive(
      onModelReady: (PvpPendingViewModel viewModel) =>
          viewModel.handleOnStartup(pvpId),
      builder: (BuildContext context, PvpPendingViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Pending'),
            shape: appBarShapeBorder,
          ),
          body: viewModel.isBusy
              ? Center(
                  child: CircularProgressIndicator(),
                )
              :
              // pvp active challange
              StreamBuilder<QuerySnapshot>(
                  stream: viewModel.pendingChallangeStream,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    PChallenge pvpChallenge;
                    if (snapshot.hasData) {
                      if (snapshot.data.size > 0) {
                        pvpChallenge =
                            PChallenge.fromMap(snapshot.data.docs.first.data());
                      }
                    }
                    return snapshot.hasData == false
                        ? Center(
                            child: DescriptionTextWidget(
                                description:
                                    'You don\'t have any pending PvPs'),
                          )
                        : snapshot.data.size == 0
                            ? Center(
                                child: DescriptionTextWidget(
                                    description:
                                        'You don\'t have any pending PvPs'),
                              )
                            : ListView.builder(
                                itemCount: snapshot.data.size,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10, horizontal: 10),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        children: [
                                          verticalSpaceSmall(context),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                LableTextWidget(
                                                    lable: 'Accept?'),
                                                Row(
                                                  children: [
                                                    IconButtonWidget(
                                                        elevation: 0,
                                                        iconData: Icons.cancel,
                                                        iconColor: Theme.of(
                                                                        context)
                                                                    .brightness ==
                                                                Brightness.light
                                                            ? AppColors.lightRed
                                                            : AppColors.darkRed,
                                                        onTap: () => viewModel
                                                            .decline(snapshot
                                                                .data
                                                                .docs[index]
                                                                .id)),
                                                    IconButtonWidget(
                                                        elevation: 0,
                                                        iconData:
                                                            Icons.check_circle,
                                                        iconColor: Theme.of(
                                                                        context)
                                                                    .brightness ==
                                                                Brightness.light
                                                            ? AppColors
                                                                .lightGreen
                                                            : AppColors
                                                                .darkGreen,
                                                        onTap: () => viewModel
                                                            .accept(snapshot
                                                                .data
                                                                .docs[index]
                                                                .id)),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          // verticalSpaceXSmall(context),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                verticalSpaceXSmall(context),
                                                PvpchallengeWidget(
                                                  width: screenWidth(context),
                                                  onTap: () => viewModel
                                                      .challengeTapped(snapshot
                                                          .data.docs[index].id),
                                                  lable: pvpChallenge.name,
                                                  profile1Named:
                                                      viewModel.userA.userName,
                                                  profile1ProgressValue:
                                                      pvpChallenge.noOfTasks ==
                                                              0
                                                          ? 0
                                                          : pvpChallenge
                                                                  .aCTask /
                                                              pvpChallenge
                                                                  .noOfTasks,
                                                  profile1Image: NetworkImage(
                                                      viewModel
                                                          .userA.profilePic),
                                                  profile2Named:
                                                      viewModel.userB.userName,
                                                  profile2ProgressValue:
                                                      pvpChallenge.noOfTasks ==
                                                              0
                                                          ? 0
                                                          : pvpChallenge
                                                                  .bCTask /
                                                              pvpChallenge
                                                                  .noOfTasks,
                                                  profile2Image: NetworkImage(
                                                      viewModel
                                                          .userB.profilePic),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                  },
                ),
        );
      },
      viewModelBuilder: () => PvpPendingViewModel(),
    );
  }
}
