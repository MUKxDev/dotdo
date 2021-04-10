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
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<NewChallangeViewModel>.reactive(
      onModelReady: (NewChallangeViewModel viewModel) =>
          viewModel.handelStartup(),
      builder:
          (BuildContext context, NewChallangeViewModel viewModel, Widget _) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Scaffold(
            appBar: AppBar(
              title: Text('New Challange'),
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
                              // Challange title
                              TextField(
                                autocorrect: true,
                                maxLines: 1,
                                maxLength: 50,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                  hintText: 'Enter challange name...',
                                  fillColor:
                                      Theme.of(context).scaffoldBackgroundColor,
                                ),
                                controller: viewModel.nameController,
                              ),
                              // Task Note
                              Padding(
                                padding: const EdgeInsets.only(top: 10),
                                child: TextField(
                                  autocorrect: true,
                                  maxLines: 1,
                                  maxLength: 50,
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
                                        LableTextWidget(lable: 'Icon'),
                                        IconButtonWidget(
                                          iconData: viewModel.iconData,
                                          iconColor: viewModel.iconColor,
                                          backgroundColor: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          iconSize: 20,
                                          height: 40,
                                          width: 40,
                                          onTap: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return IconPickerAlterDialogWidget(
                                                    setIconData: (iconData) =>
                                                        viewModel.iconTapped(
                                                            iconData),
                                                    setIconColor: (iconColor) =>
                                                        viewModel.colorTapped(
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
                                    // Challange startDate
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        LableTextWidget(lable: 'Start Date'),
                                        TextButton(
                                          onPressed: () =>
                                              viewModel.updateStartDate(
                                            showDatePicker(
                                              context: context,
                                              initialDate:
                                                  viewModel.currentDate,
                                              firstDate: viewModel.firstDate,
                                              lastDate: DateTime(
                                                  viewModel.today.year + 10),
                                            ),
                                          ),
                                          child: LableTextWidget(
                                            lable: viewModel.dateFormat
                                                .format(viewModel.startDate),
                                            color:
                                                Theme.of(context).accentColor,
                                          ),
                                        )
                                      ],
                                    ),
                                    // Challange endDate
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        LableTextWidget(lable: 'End Date'),
                                        TextButton(
                                          onPressed: () =>
                                              viewModel.updateEndDate(
                                            showDatePicker(
                                              context: context,
                                              initialDate:
                                                  viewModel.currentDate,
                                              firstDate: viewModel.firstDate,
                                              lastDate: DateTime(
                                                  viewModel.today.year + 10),
                                            ),
                                          ),
                                          child: LableTextWidget(
                                            lable: viewModel.dateFormat
                                                .format(viewModel.endDate),
                                            color:
                                                Theme.of(context).accentColor,
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
                          Container(
                            width: screenWidth(context) * 0.4,
                            child: ButtonWidget(
                              onPressed: viewModel.cancel,
                              text: 'Cancel',
                              backgroundColor: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? AppColors.lightGray
                                  : AppColors.darkGray,
                              textColor: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? AppColors.darkGray
                                  : AppColors.white,
                            ),
                          ),
                          Container(
                            width: screenWidth(context) * 0.4,
                            child: ButtonWidget(
                              onPressed: viewModel.next,
                              text: 'Next',
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
