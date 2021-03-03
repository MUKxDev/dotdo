import 'package:dotdo/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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

  const TaskWidget(
      {Key key,
      @required this.public,
      @required this.checked,
      @required this.lable,
      @required this.due,
      @required this.category,
      @required this.onTap,
      @required this.toggleChecked})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TaskViewModel>.reactive(
      builder: (BuildContext context, TaskViewModel viewModel, Widget _) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: GestureDetector(
            onTap: onTap,
            child: Container(
              height: 68,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: GestureDetector(
                                  onTap: toggleChecked,
                                  child: Container(
                                    height: 19,
                                    width: 19,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).brightness ==
                                              Brightness.light
                                          ? Colors.white70
                                          : AppColors.darkBackground,
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    // * checkbox
                                    child: checked
                                        ? Icon(
                                            FontAwesomeIcons.check,
                                            size: 14,
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? AppColors.lightGreen
                                                    : AppColors.darkGreen,
                                          )
                                        : Container(),
                                  ),
                                ),
                              ),
                              Text(
                                lable,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          // * Public Icon
                          public
                              ? Icon(
                                  FontAwesomeIcons.globeAmericas,
                                  size: 14,
                                  color: Theme.of(context).brightness ==
                                          Brightness.light
                                      ? Colors.black38
                                      : Colors.white38,
                                )
                              : Container(),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Due: ${due.day} at ${due.hour}:${due.minute}',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Theme.of(context).brightness ==
                                      Brightness.light
                                  ? AppColors.lightGreen
                                  : AppColors.darkGreen,
                              fontSize: 14,
                            ),
                          ),
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
                ),
              ),
            ),
          ),
        );
      },
      viewModelBuilder: () => TaskViewModel(),
    );
  }
}
