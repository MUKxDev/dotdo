import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/models/challenge.dart';
import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/long_challenge_card/long_challenge_card_widget.dart';
import 'package:dotdo/widgets/smart_widgets/active_challenge_card/active_challenge_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'one_row_active_challenge_view_model.dart';

class OneRowActiveChallengeWidget extends StatelessWidget {
  // final Stream stream;

  const OneRowActiveChallengeWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OneRowActiveChallengeViewModel>.reactive(
      builder: (BuildContext context, OneRowActiveChallengeViewModel viewModel,
          Widget _) {
        return StreamBuilder<QuerySnapshot>(
            stream: viewModel.getActiveUChallenge,
            builder: (context, snapshot) {
              List<QueryDocumentSnapshot> list;
              if (snapshot.hasData) {
                list = snapshot.data.docs;
                // Retain only the not completed and startDate is started
                list.retainWhere((element) =>
                    element.data()['completed'] == false &&
                    element.data()['startDate'] <=
                        DateTime.now().millisecondsSinceEpoch);
              } else {
                list = [];
              }
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: snapshot.hasData == false
                    // CircularProgressIndicator
                    ? Container(
                        width: screenWidth(context),
                        height: 80,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    : list.length == 0
                        // CircularProgressIndicator
                        ? Container(
                            width: screenWidth(context),
                            height: 80,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: DescriptionTextWidget(
                                  description:
                                      'You don\'t have any active challenges'),
                            ),
                          )
                        // * Challenge Stream list
                        : Container(
                            height: 80,
                            child: ListView.builder(
                                // padding: EdgeInsets.symmetric(horizontal: 5),
                                itemExtent: screenWidth(context) * 0.6,
                                scrollDirection: Axis.horizontal,
                                itemCount: list.length,
                                itemBuilder: (BuildContext context, index) {
                                  Challenge _challenge =
                                      Challenge.fromMap(list[index].data());
                                  // return Padding(
                                  //   padding: const EdgeInsets.symmetric(
                                  //       horizontal: 10),
                                  //   child: ActiveChallengeCardWidget(
                                  //       iconColor: _challenge.iconColor,
                                  //       iconData: IconDataSolid(
                                  //           _challenge.iconData.codePoint),
                                  //       lable: _challenge.name,
                                  //       description: _challenge.note,
                                  //       progressValue: (_challenge.noOfTasks ==
                                  //                   0 ||
                                  //               _challenge.noOfTasks == null)
                                  //           ? 0
                                  //           : (_challenge.noOfCompletedTasks /
                                  //               _challenge.noOfTasks),
                                  //       onTap: () => viewModel
                                  //           .challengeTapped(list[index].id)),
                                  // );
                                  return Padding(
                                    padding: (index + 1 == list.length)
                                        ? const EdgeInsets.only(right: 0)
                                        : const EdgeInsets.only(right: 10),
                                    child: LongChallengeCardWidget(
                                        challenge: _challenge,
                                        onTap: () => viewModel
                                            .challengeTapped(list[index].id)),
                                  );
                                }),
                          ),
              );
            });
      },
      viewModelBuilder: () => OneRowActiveChallengeViewModel(),
    );
  }
}
