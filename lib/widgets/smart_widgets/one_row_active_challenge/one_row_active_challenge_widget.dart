import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/models/challenge.dart';
import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/long_challenge_card/long_challenge_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'one_row_active_challenge_view_model.dart';

class OneRowActiveChallengeWidget extends StatelessWidget {
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
                        height: 88,
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
                            height: 88,
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
                            height: 88,
                            child: ListView.builder(
                                itemExtent: screenWidth(context) * 0.6,
                                scrollDirection: Axis.horizontal,
                                itemCount: list.length,
                                itemBuilder: (BuildContext context, index) {
                                  Challenge _challenge =
                                      Challenge.fromMap(list[index].data());
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
