import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/models/task.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:dotdo/widgets/smart_widgets/task/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'task_list_view_model.dart';

class TaskListWidget extends StatelessWidget {
  const TaskListWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaskListViewModel>.reactive(
      builder: (BuildContext context, TaskListViewModel viewModel, Widget _) {
        return StreamBuilder(
          stream: viewModel.stream,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            List<QueryDocumentSnapshot> taskList;
            if (snapshot.hasData) {
              taskList = snapshot.data.docs;

              taskList.sort((a, b) {
                int aInt = a.get('completed') == false ? 0 : 1;
                int bInt = b.get('completed') == false ? 0 : 1;
                return aInt.compareTo(bInt);
              });
            } else {
              taskList = [];
            }

            return (snapshot.hasData == false || snapshot.data.size == 0)
                ? Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Center(
                        child: DescriptionTextWidget(
                      description: 'You don\'t have any Up Coming Tasks.',
                    )),
                  )
                : ListView.builder(
                    key: UniqueKey(),
                    itemCount: taskList.length,
                    itemBuilder: (
                      BuildContext context,
                      int index,
                    ) =>
                        Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Dismissible(
                        key: Key(taskList[index].id),
                        background: taskList[index]['completed']
                            ? Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? AppColors.lightNote
                                        : AppColors.darkNote,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        LableTextWidget(
                                          lable: 'Not completed?',
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? AppColors.darkGray
                                              : AppColors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? AppColors.lightGreen
                                        : AppColors.darkGreen,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        LableTextWidget(
                                          lable: 'Done!',
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                        secondaryBackground: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? AppColors.lightRed
                                  : AppColors.darkRed,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  LableTextWidget(
                                    lable: 'Delete!',
                                    color: Colors.white,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        direction: DismissDirection.horizontal,
                        onDismissed: (direction) {
                          if (direction == DismissDirection.startToEnd) {
                            viewModel.toggleCompletedUTask(taskList[index].id,
                                taskList[index]['completed']);
                          } else {
                            viewModel.deleteUTask(taskList[index].id);
                          }
                        },
                        child: TaskWidget(
                          task: Task.fromMap(taskList[index].data()),
                          onTap: () => viewModel.taskTapped(taskList[index].id),
                          togglecompleted: () => viewModel.toggleCompletedUTask(
                              taskList[index].id, taskList[index]['completed']),
                        ),
                      ),
                    ),
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                  );
          },
        );
      },
      viewModelBuilder: () => TaskListViewModel(),
    );
  }
}
