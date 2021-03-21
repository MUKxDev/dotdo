import 'dart:ui';

import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:dotdo/shared/constant.dart';
import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/button/button_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/card/card_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/textfield/textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'task_details_view_model.dart';

class TaskDetailsView extends StatelessWidget {
  final String taskID;

  const TaskDetailsView({Key key, this.taskID}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaskDetailsViewModel>.reactive(
      builder:
          (BuildContext context, TaskDetailsViewModel viewModel, Widget _) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              title: Text('Task'),
              shape: appBarShapeBorder,
            ),
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              // Task lable
                              TextField(
                                maxLines: 2,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: 'Enter a new task...',
                                  fillColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                controller: viewModel.labelController,
                              ),
                              // Task Note
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: TextField(
                                  maxLines: 6,
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    hintText: 'Note...',
                                    fillColor: Theme.of(context).brightness ==
                                            Brightness.light
                                        ? AppColors.lightNote
                                        : AppColors.darkNote,
                                  ),
                                  controller: viewModel.noteController,
                                ),
                              ),
                              // options list
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 20, horizontal: 10),
                                child: Column(
                                  children: [
                                    // Task category
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        LableTextWidget(lable: 'Category'),
                                        DropdownButton(
                                          dropdownColor:
                                              Theme.of(context).primaryColor,
                                          value: viewModel.category,
                                          items: viewModel.categoryList
                                              .map<DropdownMenuItem<String>>(
                                                  (String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (category) => viewModel
                                              .updateCategory(category),
                                        ),
                                      ],
                                    ),
                                    // Task Due date
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        LableTextWidget(lable: 'Due Date'),
                                        TextButton(
                                          onPressed: () =>
                                              viewModel.updateDueDate(
                                            showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime.now(),
                                              lastDate: DateTime(2101),
                                            ),
                                          ),
                                          child: LableTextWidget(
                                            lable: viewModel.dateFormat
                                                .format(viewModel.dueDate),
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                        )
                                      ],
                                    ),
                                    // Task Due time
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        LableTextWidget(lable: 'Due Time'),
                                        TextButton(
                                          onPressed: () => viewModel
                                              .updateDueTime(showTimePicker(
                                                  context: context,
                                                  initialTime:
                                                      TimeOfDay.fromDateTime(
                                                          viewModel.dueDate))),
                                          child: LableTextWidget(
                                            lable: viewModel.timeFormat
                                                .format(viewModel.dueDate),
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                        )
                                      ],
                                    ),
                                    // Task Public
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        LableTextWidget(lable: 'Public'),
                                        Switch(
                                          value: viewModel.public,
                                          onChanged: viewModel.updatePublic,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      verticalSpaceSmall(context),
                      // Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: screenWidth(context) * 0.4,
                            child: ButtonWidget(
                              onPressed: viewModel.cancel,
                              text: 'Cancel',
                              backgroundColor: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? AppColors.lightRed
                                  : AppColors.darkRed,
                            ),
                          ),
                          Container(
                            width: screenWidth(context) * 0.4,
                            child: ButtonWidget(
                              onPressed: viewModel.addTask,
                              text: 'Add',
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => TaskDetailsViewModel(),
    );
  }
}
