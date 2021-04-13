import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/models/challenge.dart';
import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/smart_widgets/active_challenge_card/active_challenge_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'two_row_grid_active_challenge_stream_view_model.dart';

class TwoRowGridActiveChallengeStreamWidget extends StatelessWidget {
  final Stream stream;
  final Widget widget;

  const TwoRowGridActiveChallengeStreamWidget(
      {Key key, @required this.stream, this.widget})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TwoRowGridActiveChallengeStreamViewModel>.reactive(
      onModelReady: (TwoRowGridActiveChallengeStreamViewModel viewModel) =>
          viewModel.handleStartUp(),
      builder: (BuildContext context,
          TwoRowGridActiveChallengeStreamViewModel viewModel, Widget _) {
        return StreamBuilder<QuerySnapshot>(
            stream: stream,
            builder: (context, snapshot) {
              List<QueryDocumentSnapshot> list;
              if (snapshot.hasData) {
                list = snapshot.data.docs;
                // Retain only the not completed and startDate is started
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
                            height: 205,
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
                            height: 225,
                            child: GridView.builder(
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.65,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 20,
                                ),
                                itemCount: list.length,
                                itemBuilder: (BuildContext context, index) {
                                  Challenge _challenge =
                                      Challenge.fromMap(list[index].data());
                                  return ActiveChallengeCardWidget(
                                      iconColor: _challenge.iconColor,
                                      iconData: IconDataSolid(
                                          _challenge.iconData.codePoint),
                                      lable: _challenge.name,
                                      description: _challenge.note,
                                      progressValue:
                                          (_challenge.noOfTasks == 0 ||
                                                  _challenge.noOfTasks == null)
                                              ? 0
                                              : (_challenge.noOfCompletedTasks /
                                                  _challenge.noOfTasks),
                                      onTap: () => viewModel
                                          .challengeTapped(list[index].id));
                                }),
                          ),
              );
            });
      },
      viewModelBuilder: () => TwoRowGridActiveChallengeStreamViewModel(),
    );
  }
}

// child: GridView.count(
//                     crossAxisCount: 2,
//                     childAspectRatio: 0.65,
//                     scrollDirection: Axis.horizontal,
//                     crossAxisSpacing: 10,
//                     mainAxisSpacing: 20,
//                     children: [
//                       ActiveChallengeCardWidget(
//                         lable: 'Index',
//                         onTap: () => print('Challenge Tapped'),
//                         progressValue: 0.5,
//                         description: '13 Tasks',
//                       ),
//                     ],
//                   ),
