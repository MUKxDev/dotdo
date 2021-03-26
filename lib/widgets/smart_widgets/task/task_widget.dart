import 'package:dotdo/core/models/task.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/card/card_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/check_box/check_box_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'task_view_model.dart';

class TaskWidget extends StatelessWidget {
  final Task task;
  final Function onTap;
  final Function togglecompleted;

  const TaskWidget({
    Key key,
    @required this.onTap,
    @required this.task,
    @required this.togglecompleted,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaskViewModel>.reactive(
      builder: (BuildContext context, TaskViewModel viewModel, Widget _) {
        return CardWidget(
          borderRadius: 10,
          height: 70,
          width: double.infinity,
          onTap: onTap,
          padding: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      // * CheckBox
                      CheckBoxWidget(
                          checked: task.completed, onTap: togglecompleted),
                      // *taskName
                      LableTextWidget(lable: task.taskName),
                    ],
                  ),
                  // // * Public Icon
                  // PublicIconWidget(public: public),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // * DueDateWidget
                  (task.dueDate.isBefore(DateTime.now()) &&
                          task.completed == false)
                      ? (DateTime(task.dueDate.year, task.dueDate.month,
                                  task.dueDate.day) ==
                              DateTime(DateTime.now().year,
                                  DateTime.now().month, DateTime.now().day)
                          ? DescriptionTextWidget(
                              color: (Theme.of(context).brightness ==
                                      Brightness.light
                                  ? AppColors.lightRed
                                  : AppColors.darkRed),
                              description:
                                  'Overdue: Today at ${viewModel.timeFormat.format(task.dueDate)}',
                            )
                          : DescriptionTextWidget(
                              color: (Theme.of(context).brightness ==
                                      Brightness.light
                                  ? AppColors.lightRed
                                  : AppColors.darkRed),
                              description:
                                  'Overdue: ${viewModel.dateFormat.format(task.dueDate)} at ${viewModel.timeFormat.format(task.dueDate)}',
                            ))
                      : (DateTime(task.dueDate.year, task.dueDate.month,
                                  task.dueDate.day) ==
                              DateTime(DateTime.now().year,
                                  DateTime.now().month, DateTime.now().day)
                          ? DescriptionTextWidget(
                              description:
                                  'Due date: Today at ${viewModel.timeFormat.format(task.dueDate)}',
                            )
                          : DescriptionTextWidget(
                              description:
                                  'Due date: ${viewModel.dateFormat.format(task.dueDate)} at ${viewModel.timeFormat.format(task.dueDate)}',
                            )),
                  // * Category
                  Row(
                    children: [
                      Icon(
                        Icons.adjust,
                        color: Theme.of(context).accentColor,
                        size: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          width: 100,
                          child: Text(
                            task.category,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => TaskViewModel(),
    );
  }
}
