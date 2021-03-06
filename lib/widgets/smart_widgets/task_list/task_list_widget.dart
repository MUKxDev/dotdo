import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/smart_widgets/task/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'task_list_view_model.dart';

class TaskListWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaskListViewModel>.reactive(
      builder: (BuildContext context, TaskListViewModel viewModel, Widget _) {
        return AnimatedList(
          key: viewModel.globalKey,
          initialItemCount: viewModel.getTaskList().length,
          itemBuilder: (BuildContext context, int index, Animation animation) =>
              SizeTransition(
            axis: Axis.vertical,
            sizeFactor: animation,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Dismissible(
                key: UniqueKey(),
                background: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.darkGreen,
                  ),
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
                secondaryBackground: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: AppColors.darkRed,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Remove!',
                      ),
                    ],
                  ),
                ),
                direction: DismissDirection.horizontal,
                onDismissed: (direction) {
                  if (direction == DismissDirection.startToEnd) {
                    print('object dismissed startToEnd');
                    viewModel.toggleCheckedTask(index);
                  } else if (direction == DismissDirection.endToStart) {
                    print('object dismissed endToStart');
                    viewModel.removeTask(index);
                  }
                },
                child: TaskWidget(
                    public: viewModel.getTaskList()[index].public,
                    checked: viewModel.getTaskList()[index].checked,
                    lable: viewModel.getTaskList()[index].lable,
                    due: viewModel.getTaskList()[index].due,
                    category: viewModel.getTaskList()[index].category,
                    onTap: () => viewModel.onTaskTap(index),
                    toggleChecked: () => viewModel.toggleCheckedTask(index),
                    id: viewModel.getTaskList()[index].id),
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
