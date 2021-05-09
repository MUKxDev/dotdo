import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/models/Routine.dart';
import 'package:dotdo/core/models/task.dart';
import 'package:dotdo/shared/constant.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/button/button_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/long_routine_card/long_routine_card_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/routine_task/routine_task_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'routine_details_view_model.dart';

class RoutineDetailsView extends StatelessWidget {
  final Map args;

  const RoutineDetailsView({Key key, this.args}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RoutineDetailsViewModel>.reactive(
      onModelReady: (RoutineDetailsViewModel viewModel) =>
          viewModel.handelStartup(args),
      builder:
          (BuildContext context, RoutineDetailsViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Routine'),
            shape: appBarShapeBorder,
            leading: args['isNew'] == true
                ? IconButton(
                    onPressed: () {
                      viewModel.returnToHome();
                    },
                    icon: Icon(
                      Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
                    ),
                  )
                : null,
            actions: [
              IconButton(
                  icon: Icon(
                    viewModel.isEdit ? Icons.edit_off : Icons.edit,
                  ),
                  onPressed: () => viewModel.toggleIsEdit()),
              IconButton(
                  icon: Icon(
                    FontAwesomeIcons.globeAmericas,
                    color: viewModel.isPublic
                        ? (Theme.of(context).brightness == Brightness.light
                            ? AppColors.lightGreen
                            : AppColors.darkGreen)
                        : null,
                  ),
                  onPressed: () => viewModel.toggleIsPublic()),
            ],
          ),
          bottomNavigationBar: viewModel.isBusy
              ? null
              : viewModel.isEdit
                  ?
                  //  * Add new task button
                  Container(
                      decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          )),
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: ButtonWidget(
                              borderRadius: 10,
                              onPressed: () => viewModel.addNewTask(),
                              text: 'Add new task'),
                        ),
                      ),
                    )
                  : null,
          body: SafeArea(
            child: viewModel.isBusy
                // CircularProgressIndicator
                ? Center(child: CircularProgressIndicator())
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                                child: StreamBuilder(
                                  stream: viewModel.routineStream,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
                                    Routine newRoutine;
                                    if (snapshot.hasData) {
                                      newRoutine =
                                          Routine.fromMap(snapshot.data.data());
                                      viewModel.updateRoutine(newRoutine);
                                    }

                                    return (snapshot.hasData == false ||
                                            snapshot.data.exists == false)
                                        ? Container()
                                        : LongRoutineCardWidget(
                                            routine: newRoutine,
                                            onTap: () =>
                                                viewModel.routineTapped(
                                                    snapshot.data.id),
                                          );
                                  },
                                ),
                              ),

                              // * RUTasks
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(20),
                                    bottomRight: Radius.circular(20),
                                  ),
                                  child: SingleChildScrollView(
                                    child: StreamBuilder(
                                      stream: viewModel.tasksStream,
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              snapshot) {
                                        List<QueryDocumentSnapshot> taskList;
                                        if (snapshot.hasData) {
                                          taskList = snapshot.data.docs;

                                          taskList.sort((a, b) {
                                            int aInt =
                                                a.get('completed') == false
                                                    ? 0
                                                    : 1;
                                            int bInt =
                                                b.get('completed') == false
                                                    ? 0
                                                    : 1;
                                            return aInt.compareTo(bInt);
                                          });
                                        } else {
                                          taskList = [];
                                        }

                                        return (snapshot.hasData == false ||
                                                snapshot.data.size == 0)
                                            ? Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 40),
                                                child: Center(
                                                  child: DescriptionTextWidget(
                                                    description:
                                                        'You don\'t have any tasks for this routine.',
                                                  ),
                                                ),
                                              )
                                            : ListView.builder(
                                                key: UniqueKey(),
                                                itemCount: taskList.length,
                                                itemBuilder: (
                                                  BuildContext context,
                                                  int index,
                                                ) =>
                                                    Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 0,
                                                      vertical: 10),
                                                  child: Dismissible(
                                                    key:
                                                        Key(taskList[index].id),
                                                    background:
                                                        taskList[index]
                                                                ['completed']
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color: Theme.of(context).brightness ==
                                                                            Brightness
                                                                                .light
                                                                        ? AppColors
                                                                            .lightNote
                                                                        : AppColors
                                                                            .darkNote,
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        LableTextWidget(
                                                                          lable:
                                                                              'Not completed?',
                                                                          color: Theme.of(context).brightness == Brightness.light
                                                                              ? AppColors.darkGray
                                                                              : AppColors.white,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            : Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color: Theme.of(context).brightness ==
                                                                            Brightness
                                                                                .light
                                                                        ? AppColors
                                                                            .lightGreen
                                                                        : AppColors
                                                                            .darkGreen,
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        LableTextWidget(
                                                                          lable:
                                                                              'Done!',
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                    secondaryBackground:
                                                        viewModel.isEdit
                                                            ? Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                child:
                                                                    Container(
                                                                  decoration:
                                                                      BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            10),
                                                                    color: Theme.of(context).brightness ==
                                                                            Brightness
                                                                                .light
                                                                        ? AppColors
                                                                            .lightRed
                                                                        : AppColors
                                                                            .darkRed,
                                                                  ),
                                                                  child:
                                                                      Padding(
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                    child:
                                                                        Column(
                                                                      mainAxisAlignment:
                                                                          MainAxisAlignment
                                                                              .center,
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .end,
                                                                      children: [
                                                                        LableTextWidget(
                                                                          lable:
                                                                              'Delete!',
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              )
                                                            : (taskList[index][
                                                                    'completed']
                                                                ? Padding(
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        color: Theme.of(context).brightness ==
                                                                                Brightness.light
                                                                            ? AppColors.lightNote
                                                                            : AppColors.darkNote,
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(10.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.end,
                                                                          children: [
                                                                            LableTextWidget(
                                                                              lable: 'Not completed?',
                                                                              color: Theme.of(context).brightness == Brightness.light ? AppColors.darkGray : AppColors.white,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                : Padding(
                                                                    padding: const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                    child:
                                                                        Container(
                                                                      decoration:
                                                                          BoxDecoration(
                                                                        borderRadius:
                                                                            BorderRadius.circular(10),
                                                                        color: Theme.of(context).brightness ==
                                                                                Brightness.light
                                                                            ? AppColors.lightGreen
                                                                            : AppColors.darkGreen,
                                                                      ),
                                                                      child:
                                                                          Padding(
                                                                        padding:
                                                                            const EdgeInsets.all(10.0),
                                                                        child:
                                                                            Column(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                              CrossAxisAlignment.end,
                                                                          children: [
                                                                            LableTextWidget(
                                                                              lable: 'Done!',
                                                                              color: Colors.white,
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )),
                                                    direction: DismissDirection
                                                        .horizontal,
                                                    onDismissed: (direction) {
                                                      if (direction ==
                                                          DismissDirection
                                                              .startToEnd) {
                                                        viewModel
                                                            .toggleCompletedUTask(
                                                                taskList[index]
                                                                    .id,
                                                                taskList[index][
                                                                    'completed']);
                                                      } else {
                                                        viewModel.isEdit
                                                            ? viewModel
                                                                .deleteUTask(
                                                                    taskList[
                                                                            index]
                                                                        .id)
                                                            : viewModel.toggleCompletedUTask(
                                                                taskList[index]
                                                                    .id,
                                                                taskList[index][
                                                                    'completed']);
                                                      }
                                                    },
                                                    child: RoutineTaskWidget(
                                                      backgroundcolor: Theme.of(
                                                                      context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? AppColors
                                                              .lightRoutine
                                                          : AppColors
                                                              .darkRoutine,
                                                      task: Task.fromMap(
                                                          taskList[index]
                                                              .data()),
                                                      onTap: () =>
                                                          viewModel.taskTapped(
                                                              taskList[index]
                                                                  .id),
                                                      togglecompleted: () => viewModel
                                                          .toggleCompletedUTask(
                                                              taskList[index]
                                                                  .id,
                                                              taskList[index][
                                                                  'completed']),
                                                    ),
                                                  ),
                                                ),
                                                shrinkWrap: true,
                                                physics: ScrollPhysics(),
                                              );
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        );
      },
      viewModelBuilder: () => RoutineDetailsViewModel(),
    );
  }
}
