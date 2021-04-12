import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/models/challange.dart';
import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/long_challange_card/long_challange_card_widget.dart';
import 'package:dotdo/widgets/smart_widgets/active_challange_card/active_challange_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'one_row_active_challange_view_model.dart';

class OneRowActiveChallangeWidget extends StatelessWidget {
  // final Stream stream;

  const OneRowActiveChallangeWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<OneRowActiveChallangeViewModel>.reactive(
      builder: (BuildContext context, OneRowActiveChallangeViewModel viewModel,
          Widget _) {
        return StreamBuilder<QuerySnapshot>(
            stream: viewModel.getActiveUChallange,
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
                                      'You don\'t have any active challanges'),
                            ),
                          )
                        // * Challange Stream list
                        : Container(
                            height: 80,
                            child: ListView.builder(
                                // padding: EdgeInsets.symmetric(horizontal: 5),
                                itemExtent: screenWidth(context) * 0.6,
                                scrollDirection: Axis.horizontal,
                                itemCount: list.length,
                                itemBuilder: (BuildContext context, index) {
                                  Challange _challange =
                                      Challange.fromMap(list[index].data());
                                  // return Padding(
                                  //   padding: const EdgeInsets.symmetric(
                                  //       horizontal: 10),
                                  //   child: ActiveChallangeCardWidget(
                                  //       iconColor: _challange.iconColor,
                                  //       iconData: IconDataSolid(
                                  //           _challange.iconData.codePoint),
                                  //       lable: _challange.name,
                                  //       description: _challange.note,
                                  //       progressValue: (_challange.noOfTasks ==
                                  //                   0 ||
                                  //               _challange.noOfTasks == null)
                                  //           ? 0
                                  //           : (_challange.noOfCompletedTasks /
                                  //               _challange.noOfTasks),
                                  //       onTap: () => viewModel
                                  //           .challangeTapped(list[index].id)),
                                  // );
                                  return Padding(
                                    padding: (index + 1 == list.length)
                                        ? const EdgeInsets.only(right: 0)
                                        : const EdgeInsets.only(right: 10),
                                    child: LongChallangeCardWidget(
                                        challange: _challange,
                                        onTap: () => viewModel
                                            .challangeTapped(list[index].id)),
                                  );
                                }),
                          ),
              );
            });
      },
      viewModelBuilder: () => OneRowActiveChallangeViewModel(),
    );
  }
}
