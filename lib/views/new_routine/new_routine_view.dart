import 'package:dotdo/shared/constant.dart';
import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/button/button_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/icon_button/icon_button_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:dotdo/widgets/smart_widgets/icon_picker_alter_dialog/icon_picker_alter_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'new_routine_view_model.dart';

class NewRoutineView extends StatelessWidget {
  final String routineId;

  const NewRoutineView({Key key, this.routineId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewRoutineViewModel>.reactive(
      onModelReady: (NewRoutineViewModel viewModel) =>
          viewModel.handelStartup(routineId),
      builder: (BuildContext context, NewRoutineViewModel viewModel, Widget _) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              title: routineId == null ? Text('New Routine') : Text('Routine'),
              shape: appBarShapeBorder,
            ),
            body: viewModel.isBusy
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SafeArea(
                    child: SingleChildScrollView(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? AppColors.lightRoutine
                                      : AppColors.darkRoutine,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Column(
                                    children: [
                                      // Routine name
                                      TextField(
                                        autocorrect: true,
                                        maxLines: 2,
                                        maxLength: 50,
                                        keyboardType: TextInputType.text,
                                        decoration: InputDecoration(
                                          hintText: 'Enter routine name...',
                                          fillColor: Theme.of(context)
                                              .scaffoldBackgroundColor
                                              .withAlpha(200),
                                        ),
                                        controller: viewModel.nameController,
                                      ),
                                      // Routine Note
                                      Padding(
                                        padding: const EdgeInsets.only(top: 10),
                                        child: TextField(
                                          autocorrect: true,
                                          maxLines: 2,
                                          maxLength: 50,
                                          keyboardType: TextInputType.text,
                                          decoration: InputDecoration(
                                            hintText: 'Note...',
                                            fillColor:
                                                Theme.of(context).brightness ==
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
                                        padding: const EdgeInsets.only(
                                          top: 20,
                                          bottom: 0,
                                          right: 10,
                                          left: 10,
                                        ),
                                        child: Column(
                                          children: [
                                            // Routine Icon
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                LableTextWidget(
                                                  lable: 'Icon',
                                                  color: AppColors.white,
                                                ),
                                                IconButtonWidget(
                                                  // borderRadius: 2,
                                                  iconData: viewModel.iconData,
                                                  iconColor:
                                                      viewModel.iconColor,
                                                  backgroundColor: Theme.of(
                                                          context)
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
                                            // Routine Active
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                LableTextWidget(
                                                  lable: 'Active',
                                                  color: AppColors.white,
                                                ),
                                                Switch(
                                                  activeColor: Theme.of(context)
                                                      .accentColor,
                                                  value: viewModel.active,
                                                  onChanged: (isActive) =>
                                                      viewModel.updateActive(
                                                          isActive),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  routineId == null
                                      ? Container(
                                          width: screenWidth(context) * 0.4,
                                          child: ButtonWidget(
                                            onPressed: viewModel.cancel,
                                            text: 'Cancel',
                                            backgroundColor:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? AppColors.lightGray
                                                    : AppColors.darkGray,
                                            textColor:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? AppColors.darkGray
                                                    : AppColors.white,
                                          ),
                                        )
                                      : Container(
                                          width: screenWidth(context) * 0.4,
                                          child: ButtonWidget(
                                            onPressed: viewModel.delete,
                                            text: 'Delete',
                                            backgroundColor:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? AppColors.lightRed
                                                    : AppColors.darkRed,
                                            textColor: AppColors.white,
                                          ),
                                        ),
                                  Container(
                                    width: screenWidth(context) * 0.4,
                                    child: ButtonWidget(
                                      onPressed: routineId == null
                                          ? viewModel.next
                                          : viewModel.save,
                                      text: routineId == null ? 'Next' : 'Save',
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
          ),
        );
      },
      viewModelBuilder: () => NewRoutineViewModel(),
    );
  }
}
