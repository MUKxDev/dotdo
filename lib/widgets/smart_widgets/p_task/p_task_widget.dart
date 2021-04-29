import 'package:dotdo/core/models/pcTask.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/card/card_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/check_box/check_box_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'p_task_view_model.dart';

class PTaskWidget extends StatelessWidget {
  final PCTask task;
  final Function onTap;
  final Function togglecompleted;
  final Color backgroundcolor;
  final String userApic;
  final String userBpic;

  const PTaskWidget({
    Key key,
    this.task,
    this.onTap,
    this.togglecompleted,
    this.backgroundcolor,
    this.userApic,
    this.userBpic,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PTaskViewModel>.reactive(
      builder: (BuildContext context, PTaskViewModel viewModel, Widget _) {
        return CardWidget(
          backgroundcolor: backgroundcolor,
          borderRadius: 10,
          height: null,
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  child: Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(userApic),
                                  ),
                                ),
                              ),
                            ),
                            CheckBoxWidget(
                                checked: task.aCompleted,
                                onTap: togglecompleted),
                          ],
                        ),
                        Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .scaffoldBackgroundColor
                                .withAlpha(150),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Icon(
                            IconDataSolid(task.iconData.codePoint),
                            size: 24,
                            color: task.iconColor,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            CheckBoxWidget(
                                paddingRight: 0,
                                checked: task.bCompleted,
                                onTap: togglecompleted),
                            Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  child: Image(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(userBpic),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          child: Row(
                            children: [
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
                                task.aCompleted == false)
                            ? (DateTime(task.dueDate.year, task.dueDate.month,
                                        task.dueDate.day) ==
                                    DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day)
                                ? DescriptionTextWidget(
                                    color: backgroundcolor == null
                                        ? (Theme.of(context).brightness ==
                                                Brightness.light
                                            ? AppColors.lightRed
                                            : AppColors.darkRed)
                                        : (Theme.of(context).brightness ==
                                                Brightness.light
                                            ? AppColors.darkChallenge
                                                .withAlpha(200)
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
                                            ? AppColors.darkChallenge
                                                .withAlpha(200)
                                            : AppColors.darkRed),
                                    description:
                                        'Overdue: ${viewModel.dateFormat.format(task.dueDate)} at ${viewModel.timeFormat.format(task.dueDate)}',
                                  ))
                            : (DateTime(task.dueDate.year, task.dueDate.month,
                                        task.dueDate.day) ==
                                    DateTime(
                                        DateTime.now().year,
                                        DateTime.now().month,
                                        DateTime.now().day)
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
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => PTaskViewModel(),
    );
  }
}
