import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/models/Routine.dart';
import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/long_routine_card/long_routine_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'routines_stream_view_model.dart';

class RoutinesStreamWidget extends StatelessWidget {
  final Stream stream;
  final Widget widget;

  const RoutinesStreamWidget({Key key, this.stream, this.widget})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RoutinesStreamViewModel>.reactive(
      builder:
          (BuildContext context, RoutinesStreamViewModel viewModel, Widget _) {
        return StreamBuilder<QuerySnapshot>(
            stream: stream,
            builder: (context, snapshot) {
              List<QueryDocumentSnapshot> list;
              if (snapshot.hasData) {
                list = snapshot.data.docs;
                // Retain only the not completed
                // list.retainWhere(
                //     (element) => element.data()['completed'] == false);
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
                    // * Routine Stream list
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
                                  description: 'You don\'t have any routines'),
                            ),
                          )
                        // * Routine Stream ListView
                        : Container(
                            height: 88,
                            child: ListView.builder(
                                itemExtent: screenWidth(context) * 0.6,
                                scrollDirection: Axis.horizontal,
                                itemCount: list.length,
                                itemBuilder: (BuildContext context, index) {
                                  Routine _routine =
                                      Routine.fromMap(list[index].data());
                                  return Padding(
                                    padding: (index + 1 == list.length)
                                        ? const EdgeInsets.only(right: 0)
                                        : const EdgeInsets.only(right: 10),
                                    child: LongRoutineCardWidget(
                                        showPrograssBar: false,
                                        routine: _routine,
                                        onTap: () => viewModel
                                            .routineTapped(list[index].id)),
                                  );
                                }),
                          ),
              );
            });
      },
      viewModelBuilder: () => RoutinesStreamViewModel(),
    );
  }
}
