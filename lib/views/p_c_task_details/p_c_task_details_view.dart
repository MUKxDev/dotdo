import 'package:dotdo/shared/constant.dart';
import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/button/button_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/icon_button/icon_button_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:dotdo/widgets/smart_widgets/icon_picker_alter_dialog/icon_picker_alter_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'p_c_task_details_view_model.dart';

class PCTaskDetailsView extends StatelessWidget {
  final Map args;

  const PCTaskDetailsView({Key key, this.args}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PCTaskDetailsViewModel>.reactive(
      onModelReady: (PCTaskDetailsViewModel viewModel) =>
          viewModel.handelStartup(args),
      builder:
          (BuildContext context, PCTaskDetailsViewModel viewModel, Widget _) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              title: Text('Challenge Task'),
              shape: appBarShapeBorder,
            ),
            body: viewModel.isBusy
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Center(
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                // color: Theme.of(context).primaryColor,
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? AppColors.lightChallenge
                                    : AppColors.darkChallenge,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    // Task title
                                    TextField(
                                      autocorrect: true,
                                      maxLines: 2,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        hintText: 'Enter a new title...',
                                        fillColor: Theme.of(context)
                                            .scaffoldBackgroundColor
                                            .withAlpha(200),
                                      ),
                                      controller: viewModel.labelController,
                                    ),
                                    // Task Note
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: TextField(
                                        autocorrect: true,
                                        maxLines: 6,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          hintText: 'Note...',
                                          fillColor: Theme.of(context)
                                                      .brightness ==
                                                  Brightness.light
                                              ? AppColors.lightNote
                                                  .withAlpha(200)
                                              : AppColors.darkNote
                                                  .withAlpha(200),
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
                                          // Task Icon
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              LableTextWidget(
                                                  lable: 'Icon',
                                                  color: AppColors.white),
                                              IconButtonWidget(
                                                iconData: IconDataSolid(
                                                    viewModel
                                                        .iconData.codePoint),
                                                iconColor: viewModel.iconColor,
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .scaffoldBackgroundColor
                                                        .withAlpha(200),
                                                iconSize: 20,
                                                height: 45,
                                                width: 45,
                                                onTap: () {
                                                  showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return IconPickerAlterDialogWidget(
                                                          setIconData: (iconData) =>
                                                              viewModel
                                                                  .iconTapped(
                                                                      iconData),
                                                          setIconColor: (iconColor) =>
                                                              viewModel
                                                                  .colorTapped(
                                                                      iconColor),
                                                          iconData: viewModel
                                                              .iconData,
                                                          iconColor: viewModel
                                                              .iconColor,
                                                        );
                                                      });
                                                },
                                              ),
                                            ],
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              LableTextWidget(
                                                  lable: 'Due Time',
                                                  color: AppColors.white),
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
                                                              .brightness ==
                                                          Brightness.light
                                                      ? AppColors.white
                                                          .withAlpha(200)
                                                      : AppColors.darkGreen,
                                                ),
                                              )
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
                            viewModel.isTaskIdNull
                                ? Container(
                                    width: screenWidth(context),
                                    child: ButtonWidget(
                                      onPressed: viewModel.addTask,
                                      text: 'Add',
                                    ),
                                  )
                                : Container(
                                    width: screenWidth(context),
                                    child: ButtonWidget(
                                      onPressed: viewModel.cancel,
                                      text: 'Back',
                                      backgroundColor:
                                          Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? AppColors.lightGray
                                              : AppColors.darkGray,
                                      textColor: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? AppColors.darkGray
                                          : AppColors.white,
                                    ),
                                  ),
                          ],
                        ),
                      ),
                    ),
                  ),
          ),
        );
      },
      viewModelBuilder: () => PCTaskDetailsViewModel(),
    );
  }
}
