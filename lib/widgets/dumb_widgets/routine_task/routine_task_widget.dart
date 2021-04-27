import 'package:dotdo/core/models/task.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/card/card_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/check_box/check_box_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RoutineTaskWidget extends StatelessWidget {
  final Task task;
  final Function onTap;
  final Function togglecompleted;
  final Color backgroundcolor;

  const RoutineTaskWidget(
      {Key key,
      this.task,
      this.onTap,
      this.togglecompleted,
      this.backgroundcolor})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                      onTap == null
                          ? Container()
                          : CheckBoxWidget(
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
                DescriptionTextWidget(
                  description: task.taskNote,
                  color: backgroundcolor == null
                      ? null
                      : AppColors.white.withAlpha(200),
                ),
              ],
            ),
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor.withAlpha(150),
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
  }
}
