import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/models/task.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:dotdo/widgets/smart_widgets/task/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'today_tasks_list_view_model.dart';

class TodayTasksListWidget extends StatelessWidget {
  const TodayTasksListWidget({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TodayTasksListViewModel>.reactive(
      // onModelReady: (TodayTasksListViewModel viewModel) =>
      //     viewModel.handleOnStartUp(),
      builder:
          (BuildContext context, TodayTasksListViewModel viewModel, Widget _) {
        return StreamBuilder(
          stream: viewModel.stream,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            return (snapshot.hasData == false || snapshot.data.size == 0)
                ? Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Center(
                      child: DateTime(
                                  viewModel.currentDate.year,
                                  viewModel.currentDate.month,
                                  viewModel.currentDate.day) ==
                              DateTime(DateTime.now().year,
                                  DateTime.now().month, DateTime.now().day)
                          ? DescriptionTextWidget(
                              description:
                                  'You don\'t have any tasks for today.',
                            )
                          : DescriptionTextWidget(
                              description:
                                  'You don\'t have any tasks for ${viewModel.dateFormat.format(viewModel.currentDate)}.',
                            ),
                    ),
                  )
                : ListView.builder(
                    key: UniqueKey(),
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (
                      BuildContext context,
                      int index,
                    ) =>
                        Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      child: Dismissible(
                        key: Key(snapshot.data.docs[index].id),
                        background: Padding(
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
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                  ? AppColors.lightGreen
                                  : AppColors.darkGreen,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
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
                        direction: DismissDirection.horizontal,
                        onDismissed: (direction) {
                          viewModel.toggleCompletedUTask(
                              snapshot.data.docs[index].id,
                              snapshot.data.docs[index]['completed']);
                        },
                        child: TaskWidget(
                          task: Task.fromMap(snapshot.data.docs[index].data()),
                          onTap: () => viewModel
                              .taskTapped(snapshot.data.docs[index].id),
                          togglecompleted: () => viewModel.toggleCompletedUTask(
                              snapshot.data.docs[index].id,
                              snapshot.data.docs[index]['completed']),
                        ),
                      ),
                    ),
                    shrinkWrap: true,
                    physics: ScrollPhysics(),
                  );
          },
        );
      },
      viewModelBuilder: () => TodayTasksListViewModel(),
    );
  }
}
