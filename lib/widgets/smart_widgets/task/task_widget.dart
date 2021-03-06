import 'package:dotdo/widgets/dumb_widgets/card/card_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/check_box/check_box_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/public_icon/public_icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'task_view_model.dart';

class TaskWidget extends StatelessWidget {
  final bool public;
  final bool checked;
  final String lable;
  final DateTime due;
  final String category;
  final Function onTap;
  final Function toggleChecked;
  final String id;

  const TaskWidget(
      {Key key,
      @required this.public,
      @required this.checked,
      @required this.lable,
      @required this.due,
      @required this.category,
      @required this.onTap,
      @required this.toggleChecked,
      @required this.id})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaskViewModel>.reactive(
      builder: (BuildContext context, TaskViewModel viewModel, Widget _) {
        return CardWidget(
          borderRadius: 10,
          height: 70,
          width: double.infinity,
          onTap: onTap,
          padding: 10,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      // * CheckBox
                      CheckBoxWidget(checked: checked, onTap: toggleChecked),
                      // *lable
                      LableTextWidget(lable: lable),
                    ],
                  ),
                  // * Public Icon
                  PublicIconWidget(public: public),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // * DescriptionTextWidget
                  DescriptionTextWidget(
                    description: 'Due: ${due.day} at ${due.hour}:${due.minute}',
                  ),
                  // * Category
                  Row(
                    children: [
                      Icon(
                        Icons.adjust,
                        color: Theme.of(context).accentColor,
                        size: 16,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Container(
                          width: 100,
                          child: Text(
                            category,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => TaskViewModel(),
    );
  }
}
