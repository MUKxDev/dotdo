import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/models/PChallenge.dart';
import 'package:dotdo/shared/constant.dart';
import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
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
                                  if (snapshot.hasData) {
                                    if (snapshot.data.size > 0) {
                                      pvpChallenge = PChallenge.fromMap(
                                          snapshot.data.docs[index].data());
                                    }
                                  }
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
                                                    Container(
                                                      height: 40,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                                    .brightness ==
                                                                Brightness.light
                                                            ? Theme.of(context)
                                                                .scaffoldBackgroundColor
                                                                .withAlpha(200)
                                                            : Theme.of(context)
                                                                .scaffoldBackgroundColor
                                                                .withAlpha(150),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Center(
                                                        child: Tooltip(
                                                          message: 'Decline',
                                                          child: IconButton(
                                                              icon: Icon(
                                                                Icons.cancel,
                                                                color: Theme.of(context)
                                                                            .brightness ==
                                                                        Brightness
                                                                            .light
                                                                    ? AppColors
                                                                        .lightRed
                                                                    : AppColors
                                                                        .darkRed,
                                                              ),
                                                              onPressed: () =>
                                                                  viewModel.decline(
                                                                      snapshot
                                                                          .data
                                                                          .docs[
                                                                              index]
                                                                          .id)),
                                                        ),
                                                      ),
                                                    ),
                                                    horizontalSpaceSmall(
                                                        context),
                                                    Container(
                                                      height: 40,
                                                      width: 40,
                                                      decoration: BoxDecoration(
                                                        color: Theme.of(context)
                                                                    .brightness ==
                                                                Brightness.light
                                                            ? Theme.of(context)
                                                                .scaffoldBackgroundColor
                                                                .withAlpha(200)
                                                            : Theme.of(context)
                                                                .scaffoldBackgroundColor
                                                                .withAlpha(150),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(8),
                                                      ),
                                                      child: Center(
                                                        child: Tooltip(
                                                          message: 'Accept',
                                                          child: IconButton(
                                                              icon: Icon(
                                                                Icons
                                                                    .check_circle,
                                                                color: Theme.of(context)
                                                                            .brightness ==
                                                                        Brightness
                                                                            .light
                                                                    ? AppColors
                                                                        .lightGreen
                                                                    : AppColors
                                                                        .darkGreen,
                                                              ),
                                                              onPressed: () =>
                                                                  viewModel.accept(
                                                                      snapshot
                                                                          .data
                                                                          .docs[
                                                                              index]
                                                                          .id)),
                                                        ),
                                                      ),
                                                    ),
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
