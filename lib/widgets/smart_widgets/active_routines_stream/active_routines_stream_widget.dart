import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/models/Routine.dart';
import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/long_routine_card/long_routine_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'active_routines_stream_view_model.dart';

class ActiveRoutinesStreamWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ActiveRoutinesStreamViewModel>.reactive(
      builder: (BuildContext context, ActiveRoutinesStreamViewModel viewModel,
          Widget _) {
        return StreamBuilder<QuerySnapshot>(
            stream: viewModel.getActiveURoutines,
            builder: (context, snapshot) {
              List<QueryDocumentSnapshot> list;
              if (snapshot.hasData) {
                list = snapshot.data.docs;
                // Retain only the not completed and startDate is started
                // list.retainWhere((element) =>
                //     element.data()['completed'] == false &&
                //     element.data()['startDate'] <=
                //         DateTime.now().millisecondsSinceEpoch);
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
                                      'You don\'t have any active routines'),
                            ),
                          )
                        // * Routine Stream list
                        : Container(
                            height: 88,
                            child: ListView.builder(
                                shrinkWrap: true,
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
                                        routine: _routine,
                                        onTap: () => viewModel
                                            .routineTapped(list[index].id)),
                                  );
                                }),
                          ),
              );
            });
      },
      viewModelBuilder: () => ActiveRoutinesStreamViewModel(),
    );
  }
}
