import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/button/button_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/header_text/header_text_widget.dart';
import 'package:dotdo/widgets/smart_widgets/active_routines_stream/active_routines_stream_widget.dart';
import 'package:dotdo/widgets/smart_widgets/datepicker/datepicker_widget.dart';
import 'package:dotdo/widgets/smart_widgets/one_row_active_challenge/one_row_active_challenge_widget.dart';
import 'package:dotdo/widgets/smart_widgets/overdue_tasks_list%20/overdue_tasks_list_widget.dart';
import 'package:dotdo/widgets/smart_widgets/task_list/task_list_widget.dart';
import 'package:dotdo/widgets/smart_widgets/today_tasks_list/today_tasks_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'today_view_model.dart';

class TodayView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TodayViewModel>.reactive(
      onModelReady: (TodayViewModel viewModel) => viewModel.handleOnStartup(),
      builder: (BuildContext context, TodayViewModel viewModel, Widget _) {
        return SafeArea(
          child: ListView(
            children: [
              verticalSpaceSmall(context),
              HeaderTextWidget(lable: 'Challenges/Routines'),
              OneRowActiveChallengeWidget(),
              ActiveRoutinesStreamWidget(),
              // * Tap bar
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Container(
                  height: 50,
                  width: screenWidth(context),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonWidget(
                          onPressed: () => viewModel.toggleMode(),
                          text: 'Day',
                          width: screenWidth(context) * 0.44,
                          borderRadius: 5,
                          fontSize: 14,
                          backgroundColor: viewModel.isDayMode
                              ? Theme.of(context).accentColor
                              : Theme.of(context).accentColor.withAlpha(0),
                          textColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? (viewModel.isDayMode
                                      ? AppColors.white
                                      : AppColors.darkBackground.withAlpha(200))
                                  : (viewModel.isDayMode
                                      ? AppColors.white
                                      : AppColors.white.withAlpha(100)),
                        ),
                        ButtonWidget(
                          onPressed: () => viewModel.toggleMode(),
                          text: 'Up Coming',
                          width: screenWidth(context) * 0.44,
                          borderRadius: 5,
                          fontSize: 14,
                          backgroundColor: viewModel.isDayMode
                              ? Theme.of(context).accentColor.withAlpha(0)
                              : Theme.of(context).accentColor,
                          textColor:
                              Theme.of(context).brightness == Brightness.light
                                  ? (viewModel.isDayMode
                                      ? AppColors.darkBackground.withAlpha(200)
                                      : AppColors.white)
                                  : (viewModel.isDayMode
                                      ? AppColors.white.withAlpha(100)
                                      : AppColors.white),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              viewModel.isDayMode
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // * DatePicker widget
                        Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: 20, horizontal: 10),
                          child: DatepickerWidget(),
                        ),
                        // // * Chllanges/Routine list
                        // // challenges list
                        // HomeUcTasksWidget(),
                        // * Overdue list
                        OverdueTasksListWidget(),
                        // * Today's tasks
                        DateTime(
                                    viewModel.currentDate.year,
                                    viewModel.currentDate.month,
                                    viewModel.currentDate.day) ==
                                DateTime(DateTime.now().year,
                                    DateTime.now().month, DateTime.now().day)
                            ? HeaderTextWidget(lable: 'Today\'s Tasks')
                            : HeaderTextWidget(
                                lable:
                                    '${viewModel.dateFormat.format(viewModel.currentDate)}  Tasks'),
                        // * Tasks List
                        TodayTasksListWidget(),
                      ],
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // * Overdue list
                          OverdueTasksListWidget(),
                          // * Up Coming Tasks
                          HeaderTextWidget(lable: 'Up Coming Tasks'),
                          TaskListWidget(),
                        ],
                      ),
                    ),

              verticalSpaceLarge(context),
            ],
          ),
        );
      },
      viewModelBuilder: () => TodayViewModel(),
    );
  }
}
