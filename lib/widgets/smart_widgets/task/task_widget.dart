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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Row(
                        children: [
                          // * CheckBox
                          CheckBoxWidget(
                              checked: task.completed, onTap: togglecompleted),
                          // *taskName
                          Expanded(
                            child: Container(
                              child: LableTextWidget(
                                lable: task.taskName,
                                color: backgroundcolor == null
                                    ? null
                                    : AppColors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    (task.dueDate.isBefore(DateTime.now()) &&
                            task.completed == false)
                        ? (DateTime(task.dueDate.year, task.dueDate.month,
                                    task.dueDate.day) ==
                                DateTime(DateTime.now().year,
                                    DateTime.now().month, DateTime.now().day)
                            ? DescriptionTextWidget(
                                color: backgroundcolor == null
                                    ? (Theme.of(context).brightness ==
                                            Brightness.light
                                        ? AppColors.lightRed
                                        : AppColors.darkRed)
                                    : (Theme.of(context).brightness ==
                                            Brightness.light
                                        ? AppColors.darkChallenge.withAlpha(200)
                                        : AppColors.darkRed),
                                description:
                                    'Overdue: Today at ${viewModel.timeFormat.format(task.dueDate)}',
                              )
                            : DescriptionTextWidget(
                                color: backgroundcolor == null
                                    ? (Theme.of(context).brightness ==
                                            Brightness.light
                                        ? AppColors.lightRed
                                        : AppColors.darkRed)
                                    : (Theme.of(context).brightness ==
                                            Brightness.light
                                        ? AppColors.darkChallenge.withAlpha(200)
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
              ),
              Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).scaffoldBackgroundColor.withAlpha(150),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  IconDataSolid(task.iconData.codePoint),
                  size: 24,
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
