import 'package:dotdo/shared/constant.dart';
import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/icon_button/icon_button_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'icon_picker_alter_dialog_view_model.dart';

class IconPickerAlterDialogWidget extends StatelessWidget {
  final IconData iconData;
  final Color iconColor;
  final Function setIconData;
  final Function setIconColor;

  const IconPickerAlterDialogWidget(
      {Key key,
      @required this.setIconData,
      @required this.setIconColor,
      @required this.iconData,
      @required this.iconColor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<IconPickerAlterDialogViewModel>.reactive(
      onModelReady: (IconPickerAlterDialogViewModel viewModel) => viewModel
          .handleStartUp(iconData, iconColor, setIconData, setIconColor),
      builder: (BuildContext context, IconPickerAlterDialogViewModel viewModel,
          Widget _) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(10),
          scrollable: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          backgroundColor: Theme.of(context).primaryColor,
          content: Container(
            // height: screenHeight(context) * 0.5,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Top
                  Container(
                    // height: screenHeight(context) * 0.05,
                    // color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          LableTextWidget(lable: 'Choose an icon'),
                          Icon(
                            IconDataSolid(viewModel.iconData.codePoint),
                            color: viewModel.iconColor,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Color
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DescriptionTextWidget(description: 'Pick a Color'),
                      verticalSpaceXSmall(context),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Theme.of(context).scaffoldBackgroundColor),
                        height: screenHeight(context) * 0.09,
                        width: 300,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: AppColors.iconColors.length,
                          itemBuilder: (context, int index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: IconButtonWidget(
                              elevation: 0,
                              height: 40,
                              width: 40,
                              iconSize: 20,
                              iconColor: AppColors.iconColors[index],
                              backgroundColor: viewModel.iconColor ==
                                      AppColors.iconColors[index]
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).scaffoldBackgroundColor,
                              // backgroundColor: Theme.of(context).primaryColor,
                              iconData: FontAwesomeIcons.solidCircle,
                              onTap: () {
                                setIconColor(viewModel
                                    .colorTapped(AppColors.iconColors[index]));
                              },
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Icon
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DescriptionTextWidget(description: 'Pick an Icon'),
                        verticalSpaceXSmall(context),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Theme.of(context).scaffoldBackgroundColor),
                          height: screenHeight(context) * 0.3,
                          width: 300,
                          child: GridView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: iconDataList.length,
                            itemBuilder: (context, int index) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: IconButtonWidget(
                                elevation: 0,
                                height: 40,
                                width: 40,
                                iconSize: 20,
                                iconColor: viewModel.iconColor,
                                backgroundColor: viewModel.iconData ==
                                        iconDataList[index]
                                    ? Theme.of(context).primaryColor
                                    : Theme.of(context).scaffoldBackgroundColor,
                                iconData: IconDataSolid(
                                    iconDataList[index].codePoint),
                                // iconData: iconDataList[index],
                                onTap: () {
                                  setIconData(viewModel
                                      .iconTapped(iconDataList[index]));
                                },
                              ),
                            ),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => IconPickerAlterDialogViewModel(),
    );
  }
}
