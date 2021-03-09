import 'package:dotdo/core/models/task.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/smart_widgets/task/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'task_list_view_model.dart';

class TaskListWidget extends StatelessWidget {
  final List<Task> list;

  const TaskListWidget({Key key, @required this.list}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaskListViewModel>.reactive(
      builder: (BuildContext context, TaskListViewModel viewModel, Widget _) {
        return AnimatedList(
          key: viewModel.globalKey,
          initialItemCount: list.length,
          itemBuilder: (BuildContext context, int index, Animation animation) =>
              SizeTransition(
            axis: Axis.vertical,
            sizeFactor: animation,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Dismissible(
                // key: UniqueKey(),
                key: Key(list[index].id),
                background: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: AppColors.darkGreen,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Done!',
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
                      color: AppColors.darkGreen,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Done!',
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                direction: DismissDirection.horizontal,
                onDismissed: (direction) {
                  viewModel.toggleCheckedTask(index, list[index]);
                },
                child: TaskWidget(
                    public: list[index].public,
                    checked: list[index].checked,
                    lable: list[index].lable,
                    due: list[index].due,
                    category: list[index].category,
                    onTap: () => viewModel.onTaskTap(list[index]),
                    toggleChecked: () =>
                        viewModel.toggleCheckedTask(index, list[index]),
                    id: list[index].id),
              ),
            ),
          ),
          shrinkWrap: true,
          physics: ScrollPhysics(),
        );
      },
      viewModelBuilder: () => TaskListViewModel(),
    );
  }
}
