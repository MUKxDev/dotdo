import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:date_picker_timeline/extra/style.dart';
import 'package:dotdo/core/models/challenge.dart';
import 'package:dotdo/core/models/task.dart';
import 'package:dotdo/shared/constant.dart';
import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/button/button_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/card/card_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/long_challenge_card/long_challenge_card_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/prograss_bar/prograss_bar_widget.dart';
import 'package:dotdo/widgets/smart_widgets/task/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'challenge_details_view_model.dart';

class ChallengeDetailsView extends StatelessWidget {
  final Map args;

  const ChallengeDetailsView({Key key, this.args}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ChallengeDetailsViewModel>.reactive(
      onModelReady: (ChallengeDetailsViewModel viewModel) =>
          viewModel.handelStartup(args),
      builder: (BuildContext context, ChallengeDetailsViewModel viewModel,
          Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Challenge'),
            shape: appBarShapeBorder,
            actions: [
              IconButton(
                  icon: Icon(
                    viewModel.isEdit ? Icons.edit_off : Icons.edit,
                  ),
                  onPressed: () => viewModel.toggleIsEdit())
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
                                  stream: viewModel.challengeStream,
                                  builder: (BuildContext context,
                                      AsyncSnapshot<DocumentSnapshot>
                                          snapshot) {
                                    Challenge newChallenge;
                                    if (snapshot.hasData) {
                                      newChallenge = Challenge.fromMap(
                                          snapshot.data.data());
                                      viewModel.updateChallenge(newChallenge);
                                    }

                                    return (snapshot.hasData == false ||
                                            snapshot.data.exists == false)
                                        ? Container()
                                        : Column(
                                            children: [
                                              LongChallengeCardWidget(
                                                challenge: newChallenge,
                                                onTap: () =>
                                                    viewModel.challengeTapped(
                                                        snapshot.data.id),
                                              ),

                                              // * Date Picker
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 20),
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            10),
                                                    child: DatePicker(
                                                      newChallenge.startDate,
                                                      height: 82,
                                                      daysCount: (newChallenge
                                                              .endDate
                                                              .difference(
                                                                  newChallenge
                                                                      .startDate)
                                                              .inDays +
                                                          1),
                                                      activeDates: viewModel
                                                              .isEdit
                                                          ? null
                                                          : [DateTime.now()],
                                                      initialSelectedDate:
                                                          DateTime.now(),
                                                      selectionColor:
                                                          Theme.of(context)
                                                              .accentColor,
                                                      selectedTextColor:
                                                          Colors.white,
                                                      dayTextStyle:
                                                          defaultDayTextStyle
                                                              .copyWith(
                                                        color: Theme.of(context)
                                                                    .brightness ==
                                                                Brightness.dark
                                                            ? Colors.white
                                                            : Colors.black,
                                                      ),
                                                      dateTextStyle:
                                                          defaultDateTextStyle
                                                              .copyWith(
                                                        color: Theme.of(context)
                                                                    .brightness ==
                                                                Brightness.dark
                                                            ? Colors.white
                                                            : Colors.black,
                                                      ),
                                                      monthTextStyle:
                                                          defaultMonthTextStyle
                                                              .copyWith(
                                                        color: Theme.of(context)
                                                                    .brightness ==
                                                                Brightness.dark
                                                            ? Colors.white
                                                            : Colors.black,
                                                      ),
                                                      onDateChange: (date) {
                                                        // New date selected
                                                        viewModel
                                                            .updateSelectedValue(
                                                                date: date);
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          );
                                  },
                                ),
                              ),

                              // * CUTasks
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
                                                  child: DateTime(
                                                              viewModel
                                                                  .selectedDate
                                                                  .year,
                                                              viewModel
                                                                  .selectedDate
                                                                  .month,
                                                              viewModel
                                                                  .selectedDate
                                                                  .day) ==
                                                          DateTime(
                                                              DateTime.now()
                                                                  .year,
                                                              DateTime.now()
                                                                  .month,
                                                              DateTime.now()
                                                                  .day)
                                                      ? DescriptionTextWidget(
                                                          description:
                                                              'You don\'t have any tasks for today.',
                                                        )
                                                      : DescriptionTextWidget(
                                                          description:
                                                              'You don\'t have any tasks for ${viewModel.dateFormat.format(viewModel.selectedDate)}.',
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
                                                    child: TaskWidget(
                                                      backgroundcolor: Theme.of(
                                                                      context)
                                                                  .brightness ==
                                                              Brightness.light
                                                          ? AppColors
                                                              .lightChallenge
                                                          : AppColors
                                                              .darkChallenge,
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
      viewModelBuilder: () => ChallengeDetailsViewModel(),
    );
  }
}
