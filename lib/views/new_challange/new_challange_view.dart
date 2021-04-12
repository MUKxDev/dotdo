import 'package:dotdo/shared/constant.dart';
import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/button/button_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/icon_button/icon_button_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:dotdo/widgets/smart_widgets/icon_picker_alter_dialog/icon_picker_alter_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'new_challange_view_model.dart';

class NewChallangeView extends StatelessWidget {
  final String challangeId;

  const NewChallangeView({Key key, this.challangeId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewChallangeViewModel>.reactive(
      onModelReady: (NewChallangeViewModel viewModel) =>
          viewModel.handelStartup(challangeId),
      builder:
          (BuildContext context, NewChallangeViewModel viewModel, Widget _) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              title: challangeId == null
                  ? Text('New Challange')
                  : Text('Challange'),
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
                                color: Theme.of(context).brightness ==
                                        Brightness.light
                                    ? AppColors.lightChallange
                                    : AppColors.darkChallange,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  children: [
                                    // Challange name
                                    TextField(
                                      autocorrect: true,
                                      maxLines: 2,
                                      maxLength: 50,
                                      keyboardType: TextInputType.text,
                                      decoration: InputDecoration(
                                        hintText: 'Enter challange name...',
                                        fillColor: Theme.of(context)
                                            .scaffoldBackgroundColor
                                            .withAlpha(200),
                                      ),
                                      controller: viewModel.nameController,
                                    ),
                                    // Challange Note
                                    Padding(
                                      padding: const EdgeInsets.only(top: 10),
                                      child: TextField(
                                        autocorrect: true,
                                        maxLines: 2,
                                        maxLength: 50,
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
                                      padding: const EdgeInsets.only(
                                        top: 20,
                                        bottom: 0,
                                        right: 10,
                                        left: 10,
                                      ),
                                      child: Column(
                                        children: [
                                          // Challange Icon
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              LableTextWidget(
                                                lable: 'Icon',
                                                color: AppColors.white,
                                              ),
                                              IconButtonWidget(
                                                iconData: viewModel.iconData,
                                                iconColor: viewModel.iconColor,
                                                backgroundColor:
                                                    Theme.of(context)
                                                        .scaffoldBackgroundColor
                                                        .withAlpha(200),
                                                iconSize: 20,
                                                height: 40,
                                                width: 40,
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
                                          // Challange startDate
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              LableTextWidget(
                                                lable: 'Start Date',
                                                color: AppColors.white,
                                              ),
                                              TextButton(
                                                onPressed: () =>
                                                    viewModel.updateStartDate(
                                                  showDatePicker(
                                                    context: context,
                                                    initialDate: challangeId ==
                                                            null
                                                        ? viewModel.currentDate
                                                        : viewModel.startDate,
                                                    firstDate:
                                                        viewModel.firstDate,
                                                    lastDate: DateTime(
                                                        viewModel.today.year +
                                                            10),
                                                  ),
                                                ),
                                                child: LableTextWidget(
                                                  lable: viewModel.dateFormat
                                                      .format(
                                                          viewModel.startDate),
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
                                          // Challange endDate
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              LableTextWidget(
                                                lable: 'End Date',
                                                color: AppColors.white,
                                              ),
                                              TextButton(
                                                onPressed: () =>
                                                    viewModel.updateEndDate(
                                                  showDatePicker(
                                                    context: context,
                                                    initialDate: challangeId ==
                                                            null
                                                        ? viewModel.currentDate
                                                        : viewModel.endDate,
                                                    firstDate:
                                                        viewModel.firstDate,
                                                    lastDate: DateTime(
                                                        viewModel.today.year +
                                                            10),
                                                  ),
                                                ),
                                                child: LableTextWidget(
                                                  lable: viewModel.dateFormat
                                                      .format(
                                                          viewModel.endDate),
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                challangeId == null
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
                                    onPressed: challangeId == null
                                        ? viewModel.next
                                        : viewModel.save,
                                    text: challangeId == null ? 'Next' : 'Save',
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
        );
      },
      viewModelBuilder: () => NewChallangeViewModel(),
    );
  }
}
