import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/models/challange.dart';
import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/smart_widgets/active_challange_card/active_challange_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'two_row_grid_active_challange_stream_view_model.dart';

class TwoRowGridActiveChallangeStreamWidget extends StatelessWidget {
  final Stream stream;
  final Widget widget;

  const TwoRowGridActiveChallangeStreamWidget(
      {Key key, @required this.stream, this.widget})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TwoRowGridActiveChallangeStreamViewModel>.reactive(
      onModelReady: (TwoRowGridActiveChallangeStreamViewModel viewModel) =>
          viewModel.handleStartUp(),
      builder: (BuildContext context,
          TwoRowGridActiveChallangeStreamViewModel viewModel, Widget _) {
        return StreamBuilder<QuerySnapshot>(
            stream: stream,
            builder: (context, snapshot) {
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
                    // * Challange Stream grid
                    : snapshot.data.size == 0
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
                                      'You don\'t have any active challanges'),
                            ),
                          )
                        // * Challange Stream grid
                        : Container(
                            height: 205,
                            child: GridView.builder(
                                scrollDirection: Axis.horizontal,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 0.65,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 20,
                                ),
                                itemCount: snapshot.data.size,
                                itemBuilder: (BuildContext context, index) {
                                  Challange _challange = Challange.fromMap(
                                      snapshot.data.docs[index].data());
                                  return ActiveChallangeCardWidget(
                                      iconColor: _challange.iconColor,
                                      iconData: IconDataSolid(
                                          _challange.iconData.codePoint),
                                      lable: _challange.name,
                                      description: _challange.note,
                                      progressValue:
                                          (_challange.noOfTasks == 0 ||
                                                  _challange.noOfTasks == null)
                                              ? 0
                                              : (_challange.noOfCompletedTasks /
                                                  _challange.noOfTasks),
                                      onTap: () => viewModel.challangeTapped(
                                          snapshot.data.docs[index].id));
                                }),
                          ),
              );
            });
      },
      viewModelBuilder: () => TwoRowGridActiveChallangeStreamViewModel(),
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
//                       ActiveChallangeCardWidget(
//                         lable: 'Index',
//                         onTap: () => print('Challenge Tapped'),
//                         progressValue: 0.5,
//                         description: '13 Tasks',
//                       ),
//                     ],
//                   ),
