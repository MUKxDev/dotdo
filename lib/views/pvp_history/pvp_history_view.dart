import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/models/PChallenge.dart';
import 'package:dotdo/shared/constant.dart';
import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/user_card/user_card_widget.dart';
import 'package:dotdo/widgets/smart_widgets/pvpchallenge/pvpchallenge_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'pvp_history_view_model.dart';

class PvpHistoryView extends StatelessWidget {
  final String pvpId;

  const PvpHistoryView({Key key, this.pvpId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PvpHistoryViewModel>.reactive(
      onModelReady: (PvpHistoryViewModel viewModel) =>
          viewModel.handleOnStartup(pvpId),
      builder: (BuildContext context, PvpHistoryViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('History'),
            shape: appBarShapeBorder,
          ),
          body: viewModel.isBusy
              ? Center(
                  child: CircularProgressIndicator(),
                )
              :
              // pvp completed challange
              StreamBuilder<QuerySnapshot>(
                  stream: viewModel.completedChallangeStream,
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    PChallenge pvpChallenge;

                    return snapshot.hasData == false
                        ? Center(
                            child: DescriptionTextWidget(
                                description:
                                    'You don\'t have any completed PvPs'),
                          )
                        : snapshot.data.size == 0
                            ? Center(
                                child: DescriptionTextWidget(
                                    description:
                                        'You don\'t have any completed PvPs'),
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
                                          // verticalSpaceSmall(context),
                                          Padding(
                                            padding:
                                                pvpChallenge.challangeWinner ==
                                                        'Draw'
                                                    ? const EdgeInsets.only(
                                                        left: 20,
                                                        right: 20,
                                                        top: 20)
                                                    : const EdgeInsets.only(
                                                        left: 20,
                                                        right: 10,
                                                        top: 10),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    LableTextWidget(
                                                        lable: 'Challange'),
                                                    LableTextWidget(
                                                        lable: 'Winner: '),
                                                  ],
                                                ),
                                                horizontalSpaceXSmall(context),
                                                pvpChallenge.challangeWinner ==
                                                        'Draw'
                                                    ? DescriptionTextWidget(
                                                        description: pvpChallenge
                                                                .challangeWinner ??
                                                            'Null')
                                                    : (pvpChallenge
                                                                .challangeWinner ==
                                                            viewModel.userAId
                                                        ? DescriptionTextWidget(
                                                            description: viewModel
                                                                    .userA
                                                                    .userName ??
                                                                'Null')
                                                        : Expanded(
                                                            child:
                                                                UserCardWidget(
                                                              user: viewModel
                                                                  .userB,
                                                              backgroundcolor:
                                                                  Theme.of(
                                                                          context)
                                                                      .scaffoldBackgroundColor,
                                                            ),
                                                          )),
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
                                                  onTap: null,
                                                  // onTap: () => viewModel
                                                  //     .challengeTapped(snapshot
                                                  //         .data.docs[index].id),
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
      viewModelBuilder: () => PvpHistoryViewModel(),
    );
  }
}
