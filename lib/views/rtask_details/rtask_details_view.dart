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
import 'rtask_details_view_model.dart';

class RtaskDetailsView extends StatelessWidget {
  final Map args;

  const RtaskDetailsView({Key key, this.args}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<RtaskDetailsViewModel>.reactive(
      onModelReady: (RtaskDetailsViewModel viewModel) =>
          viewModel.handelStartup(
              args['taskId'], args['routineId'], args['icon'], args['color']),
      builder:
          (BuildContext context, RtaskDetailsViewModel viewModel, Widget _) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              title: Text('Routine Task'),
              shape: appBarShapeBorder,
            ),
            body: viewModel.isBusy
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SafeArea(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Center(
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  // color: Theme.of(context).primaryColor,
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
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 20, horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            LableTextWidget(
                                                lable: 'Icon',
                                                color: AppColors.white),
                                            IconButtonWidget(
                                              iconData: IconDataSolid(
                                                  viewModel.iconData.codePoint),
                                              iconColor: viewModel.iconColor,
                                              backgroundColor: Theme.of(context)
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
                                                        iconData:
                                                            viewModel.iconData,
                                                        iconColor:
                                                            viewModel.iconColor,
                                                      );
                                                    });
                                              },
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
                                  Container(
                                    width: screenWidth(context) * 0.4,
                                    child: ButtonWidget(
                                      onPressed: viewModel.cancel,
                                      text: 'Cancel',
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
                              ),
                              viewModel.isTaskIdNull
                                  ? Container()
                                  : Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: ButtonWidget(
                                        onPressed: viewModel.deleteUTask,
                                        text: 'Delete',
                                        backgroundColor:
                                            Theme.of(context).brightness ==
                                                    Brightness.light
                                                ? AppColors.lightRed
                                                : AppColors.darkRed,
                                      ),
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
      viewModelBuilder: () => RtaskDetailsViewModel(),
    );
  }
}
