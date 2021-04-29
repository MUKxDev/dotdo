import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/models/challenge.dart';
import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/long_challenge_card/long_challenge_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'upcoming_challenge_stream_view_model.dart';

class UpcomingChallengeStreamWidget extends StatelessWidget {
  final Stream stream;
  final Widget widget;

  const UpcomingChallengeStreamWidget(
      {Key key, @required this.stream, this.widget})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<UpcomingChallengeStreamViewModel>.reactive(
      onModelReady: (UpcomingChallengeStreamViewModel viewModel) =>
          viewModel.handleStartUp(),
      builder: (BuildContext context,
          UpcomingChallengeStreamViewModel viewModel, Widget _) {
        return StreamBuilder<QuerySnapshot>(
            stream: stream,
            builder: (context, snapshot) {
              List<QueryDocumentSnapshot> list;
              if (snapshot.hasData) {
                list = snapshot.data.docs;
                // Retain only the not completed
                list.retainWhere(
                    (element) => element.data()['completed'] == false);
              } else {
                list = [];
              }
              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: snapshot.hasData == false
                    // CircularProgressIndicator
                    ? Container(
                        width: screenWidth(context),
                        height: 205,
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Center(child: CircularProgressIndicator()),
                      )
                    // * Challenge Stream grid
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
                                      'You don\'t have any upcoming challenges'),
                            ),
                          )
                        // * Challenge Stream grid
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
      viewModelBuilder: () => UpcomingChallengeStreamViewModel(),
    );
  }
}
