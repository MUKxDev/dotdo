import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:date_picker_timeline/extra/style.dart';
import 'package:dotdo/core/models/PChallenge.dart';
import 'package:dotdo/core/models/pcTask.dart';
import 'package:dotdo/shared/constant.dart';
import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/button/button_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:dotdo/widgets/smart_widgets/p_task/p_task_widget.dart';
import 'package:dotdo/widgets/smart_widgets/pvpchallenge/pvpchallenge_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'pvp_challenge_details_view_model.dart';

class PvpChallengeDetailsView extends StatelessWidget {
  final Map args;

  const PvpChallengeDetailsView({Key key, this.args}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PvpChallengeDetailsViewModel>.reactive(
      onModelReady: (PvpChallengeDetailsViewModel viewModel) =>
          viewModel.handelStartup(args),
      builder: (BuildContext context, PvpChallengeDetailsViewModel viewModel,
          Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Challenge'),
            shape: appBarShapeBorder,
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
                                      AsyncSnapshot<QuerySnapshot> snapshot) {
                                    PChallenge newChallenge;
                                    if (snapshot.hasData) {
                                      newChallenge = PChallenge.fromMap(
                                          snapshot.data.docs.first.data());
                                      viewModel.updateChallenge(newChallenge);
                                    }

                                    return (snapshot.hasData == false ||
                                            snapshot.data.docs.first.exists ==
                                                false)
                                        ? Container()
                                        : Column(
                                            children: [
                                              PvpchallengeWidget(
                                                width: screenWidth(context),
                                                onTap: () => viewModel
                                                    .challengeTapped(snapshot
                                                        .data.docs.first.id),
                                                lable: newChallenge.name,
                                                profile1Named:
                                                    viewModel.userA.userName,
                                                profile1ProgressValue:
                                                    newChallenge.noOfTasks == 0
                                                        ? 0
                                                        : newChallenge.aCTask /
                                                            newChallenge
                                                                .noOfTasks,
                                                profile1Image: NetworkImage(
                                                    viewModel.userA.profilePic),
                                                profile2Named:
                                                    viewModel.userB.userName,
                                                profile2ProgressValue:
                                                    newChallenge.noOfTasks == 0
                                                        ? 0
                                                        : newChallenge.bCTask /
                                                            newChallenge
                                                                .noOfTasks,
                                                profile2Image: NetworkImage(
                                                    viewModel.userB.profilePic),
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
                                                      activeDates: (viewModel
                                                                  .isEdit ||
                                                              viewModel
                                                                  .isReadOnly)
                                                          ? null
                                                          : [DateTime.now()],
                                                      initialSelectedDate:
                                                          (viewModel.isEdit ||
                                                                  viewModel
                                                                      .isReadOnly)
                                                              ? viewModel
                                                                  .challenge
                                                                  .startDate
                                                              : DateTime.now(),
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

                              // * PCUTasks
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
                                            int aInt = a.get('dueDate');
                                            int bInt = b.get('dueDate');
                                            return aInt.compareTo(bInt);
                                          });

                                          taskList.retainWhere((element) {
                                            DateTime dateTime = DateTime
                                                .fromMillisecondsSinceEpoch(
                                                    element.data()['dueDate']);

                                            return DateTime(
                                                    viewModel.selectedDate.year,
                                                    viewModel
                                                        .selectedDate.month,
                                                    viewModel.selectedDate.day)
                                                .isAtSameMomentAs(DateTime(
                                                    dateTime.year,
                                                    dateTime.month,
                                                    dateTime.day));
                                          });
                                        } else {
                                          taskList = [];
                                        }

                                        return (snapshot.hasData == false ||
                                                taskList.length == 0)
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
                                                  child: (viewModel.isEdit ||
                                                          viewModel.isReadOnly)
                                                      ? PTaskWidget(
                                                          userApic: viewModel
                                                              .userA.profilePic,
                                                          userBpic: viewModel
                                                              .userB.profilePic,
                                                          backgroundcolor: Theme.of(
                                                                          context)
                                                                      .brightness ==
                                                                  Brightness
                                                                      .light
                                                              ? AppColors
                                                                  .lightChallenge
                                                              : AppColors
                                                                  .darkChallenge,
                                                          task: PCTask.fromMap(
                                                              taskList[index]
                                                                  .data()),
                                                          onTap: () => viewModel
                                                              .taskTapped(
                                                                  taskList[
                                                                          index]
                                                                      .id),
                                                          // togglecompleted:
                                                          //     () {},
                                                        )
                                                      : Dismissible(
                                                          key: Key(
                                                              taskList[index]
                                                                  .id),
                                                          background:
                                                              // taskList[
                                                              //             index]
                                                              //         [
                                                              //         'completed']
                                                              //     ? Padding(
                                                              //         padding: const EdgeInsets
                                                              //                 .all(
                                                              //             10.0),
                                                              //         child:
                                                              //             Container(
                                                              //           decoration:
                                                              //               BoxDecoration(
                                                              //             borderRadius:
                                                              //                 BorderRadius.circular(10),
                                                              //             color: Theme.of(context).brightness == Brightness.light
                                                              //                 ? AppColors.lightNote
                                                              //                 : AppColors.darkNote,
                                                              //           ),
                                                              //           child:
                                                              //               Padding(
                                                              //             padding:
                                                              //                 const EdgeInsets.all(10.0),
                                                              //             child:
                                                              //                 Column(
                                                              //               mainAxisAlignment:
                                                              //                   MainAxisAlignment.center,
                                                              //               crossAxisAlignment:
                                                              //                   CrossAxisAlignment.start,
                                                              //               children: [
                                                              //                 LableTextWidget(
                                                              //                   lable: 'Not completed?',
                                                              //                   color: Theme.of(context).brightness == Brightness.light ? AppColors.darkGray : AppColors.white,
                                                              //                 ),
                                                              //               ],
                                                              //             ),
                                                              //           ),
                                                              //         ),
                                                              //       )
                                                              //     :
                                                              Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: Theme.of(context)
                                                                            .brightness ==
                                                                        Brightness
                                                                            .light
                                                                    ? AppColors
                                                                        .lightGreen
                                                                    : AppColors
                                                                        .darkGreen,
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                child: Column(
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
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          secondaryBackground: (
                                                              // taskList[index]
                                                              //       [
                                                              //       'completed']
                                                              //   ? Padding(
                                                              //       padding:
                                                              //           const EdgeInsets.all(10.0),
                                                              //       child:
                                                              //           Container(
                                                              //         decoration:
                                                              //             BoxDecoration(
                                                              //           borderRadius: BorderRadius.circular(10),
                                                              //           color: Theme.of(context).brightness == Brightness.light ? AppColors.lightNote : AppColors.darkNote,
                                                              //         ),
                                                              //         child:
                                                              //             Padding(
                                                              //           padding: const EdgeInsets.all(10.0),
                                                              //           child: Column(
                                                              //             mainAxisAlignment: MainAxisAlignment.center,
                                                              //             crossAxisAlignment: CrossAxisAlignment.end,
                                                              //             children: [
                                                              //               LableTextWidget(
                                                              //                 lable: 'Not completed?',
                                                              //                 color: Theme.of(context).brightness == Brightness.light ? AppColors.darkGray : AppColors.white,
                                                              //               ),
                                                              //             ],
                                                              //           ),
                                                              //         ),
                                                              //       ),
                                                              //     )
                                                              //   :
                                                              Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                    .all(10.0),
                                                            child: Container(
                                                              decoration:
                                                                  BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: Theme.of(context)
                                                                            .brightness ==
                                                                        Brightness
                                                                            .light
                                                                    ? AppColors
                                                                        .lightGreen
                                                                    : AppColors
                                                                        .darkGreen,
                                                              ),
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                            .all(
                                                                        10.0),
                                                                child: Column(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .end,
                                                                  children: [
                                                                    LableTextWidget(
                                                                      lable:
                                                                          'Done!',
                                                                      color: Colors
                                                                          .white,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ),
                                                          )),
                                                          direction:
                                                              DismissDirection
                                                                  .horizontal,
                                                          onDismissed:
                                                              (direction) {
                                                            if (direction ==
                                                                DismissDirection
                                                                    .startToEnd) {
                                                              viewModel
                                                                  .toggleCompletedUTask(
                                                                taskList[index]
                                                                    .id,
                                                              );
                                                            } else {
                                                              viewModel
                                                                  .toggleCompletedUTask(
                                                                taskList[index]
                                                                    .id,
                                                              );
                                                            }
                                                          },
                                                          child: PTaskWidget(
                                                            backgroundcolor: Theme.of(
                                                                            context)
                                                                        .brightness ==
                                                                    Brightness
                                                                        .light
                                                                ? AppColors
                                                                    .lightChallenge
                                                                : AppColors
                                                                    .darkChallenge,
                                                            task: PCTask.fromMap(
                                                                taskList[index]
                                                                    .data()),
                                                            onTap: () => viewModel
                                                                .taskTapped(
                                                                    taskList[
                                                                            index]
                                                                        .id),
                                                            togglecompleted:
                                                                () => viewModel
                                                                    .toggleCompletedUTask(
                                                              taskList[index]
                                                                  .id,
                                                            ),
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
      viewModelBuilder: () => PvpChallengeDetailsViewModel(),
    );
  }
}
