import 'package:dotdo/core/models/task.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/card/card_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/check_box/check_box_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'task_view_model.dart';

class TaskWidget extends StatelessWidget {
  final Task task;
  final Function onTap;
  final Function togglecompleted;
  final Color backgroundcolor;

  const TaskWidget({
    Key key,
    @required this.onTap,
    @required this.task,
    @required this.togglecompleted,
    this.backgroundcolor,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaskViewModel>.reactive(
      builder: (BuildContext context, TaskViewModel viewModel, Widget _) {
        return CardWidget(
          backgroundcolor: backgroundcolor,
          borderRadius: 10,
          height: 70,
          width: double.infinity,
          onTap: onTap,
          padding: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          // * CheckBox
                          CheckBoxWidget(
                              checked: task.completed, onTap: togglecompleted),
                          // *taskName
                          LableTextWidget(
                            lable: task.taskName,
                            color: backgroundcolor == null
                                ? null
                                : AppColors.white,
                          ),
                        ],
                      ),
                    ],
                  ),
                  (task.dueDate.isBefore(DateTime.now()) &&
                          task.completed == false)
                      ? (DateTime(task.dueDate.year, task.dueDate.month,
                                  task.dueDate.day) ==
                              DateTime(DateTime.now().year,
                                  DateTime.now().month, DateTime.now().day)
                          ? DescriptionTextWidget(
                              color: backgroundcolor == null
                                  ? null
                                  : AppColors.darkChallange.withAlpha(200),
                              description:
                                  'Overdue: Today at ${viewModel.timeFormat.format(task.dueDate)}',
                            )
                          : DescriptionTextWidget(
                              color: backgroundcolor == null
                                  ? null
                                  : AppColors.darkChallange.withAlpha(200),
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
                              color: backgroundcolor == null
                                  ? null
                                  : AppColors.white.withAlpha(200),
                            )
                          : DescriptionTextWidget(
                              description:
                                  'Due date: ${viewModel.dateFormat.format(task.dueDate)} at ${viewModel.timeFormat.format(task.dueDate)}',
                              color: backgroundcolor == null
                                  ? null
                                  : AppColors.white.withAlpha(200),
                            )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  IconDataSolid(task.iconData.codePoint),
                  color: task.iconColor,
                ),
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => TaskViewModel(),
    );
  }
}
