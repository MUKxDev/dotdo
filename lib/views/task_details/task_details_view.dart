import 'dart:ui';

import 'package:dotdo/shared/constant.dart';
import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/button/button_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'task_details_view_model.dart';

class TaskDetailsView extends StatelessWidget {
  const TaskDetailsView({Key key, this.taskId}) : super(key: key);

  final String taskId;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaskDetailsViewModel>.reactive(
      onModelReady: (TaskDetailsViewModel viewModel) async =>
          await viewModel.handelStartup(taskId),
      builder:
          (BuildContext context, TaskDetailsViewModel viewModel, Widget _) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              title: Text('Task'),
              shape: appBarShapeBorder,
            ),
            body: viewModel.isBusy
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
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
                                    // Task title
                                    TextField(
                                      maxLines: 2,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        hintText: 'Enter a new title...',
                                        fillColor: Theme.of(context)
                                            .scaffoldBackgroundColor,
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
                                          fillColor:
                                              Theme.of(context).brightness ==
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
                                              LableTextWidget(
                                                  lable: 'Category'),
                                              DropdownButton(
                                                dropdownColor: Theme.of(context)
                                                    .primaryColor,
                                                value: viewModel.category,
                                                items: viewModel.categoryList
                                                    .map<
                                                            DropdownMenuItem<
                                                                String>>(
                                                        (String value) {
                                                  return DropdownMenuItem<
                                                      String>(
                                                    value: value,
                                                    child: Text(value),
                                                  );
                                                }).toList(),
                                                onChanged: (category) =>
                                                    viewModel.updateCategory(
                                                        category),
                                              ),
                                            ],
                                          ),
                                          // Task Due date
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              LableTextWidget(
                                                  lable: 'Due Date'),
                                              TextButton(
                                                onPressed: () =>
                                                    viewModel.updateDueDate(
                                                  showDatePicker(
                                                    context: context,
                                                    initialDate: viewModel
                                                            .isTaskIdNull
                                                        ? viewModel.currentDate
                                                        : viewModel.dueDate,
                                                    firstDate: viewModel.today,
                                                    lastDate: DateTime(
                                                        viewModel.today.year +
                                                            10),
                                                  ),
                                                ),
                                                child: LableTextWidget(
                                                  lable: viewModel.dateFormat
                                                      .format(
                                                          viewModel.dueDate),
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                ),
                                              )
                                            ],
                                          ),
                                          // Task Due time
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              LableTextWidget(
                                                  lable: 'Due Time'),
                                              TextButton(
                                                onPressed: () => viewModel
                                                    .updateDueTime(showTimePicker(
                                                        context: context,
                                                        initialTime: TimeOfDay
                                                            .fromDateTime(
                                                                viewModel
                                                                    .dueDate))),
                                                child: LableTextWidget(
                                                  lable: viewModel.timeFormat
                                                      .format(
                                                          viewModel.dueDate),
                                                  color: Theme.of(context)
                                                      .accentColor,
                                                ),
                                              )
                                            ],
                                          ),
                                          // Task Complated
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              LableTextWidget(
                                                  lable: 'Complated'),
                                              Switch(
                                                value: viewModel.complated,
                                                onChanged:
                                                    viewModel.updateComplated,
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
                                    backgroundColor:
                                        Theme.of(context).brightness ==
                                                Brightness.light
                                            ? AppColors.lightRed
                                            : AppColors.darkRed,
                                  ),
                                ),
                                viewModel.isTaskIdNull
                                    ? Container(
                                        width: screenWidth(context) * 0.4,
                                        child: ButtonWidget(
                                          onPressed: viewModel.addTask,
                                          text: 'Add',
                                        ),
                                      )
                                    : Container(
                                        width: screenWidth(context) * 0.4,
                                        child: ButtonWidget(
                                          onPressed: viewModel.updateUTask,
                                          text: 'Update',
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
