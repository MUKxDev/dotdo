import 'package:dotdo/widgets/dumb_widgets/header_text/header_text_widget.dart';
import 'package:dotdo/widgets/smart_widgets/active_challange_card/active_challange_card_widget.dart';
import 'package:dotdo/widgets/smart_widgets/datepicker/datepicker_widget.dart';
import 'package:dotdo/widgets/smart_widgets/task_list/task_list_widget.dart';
import 'package:dotdo/widgets/smart_widgets/today_task/today_task_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'today_view_model.dart';

class TodayView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TodayViewModel>.reactive(
      onModelReady: (TodayViewModel viewModel) => viewModel.handelStartup(),
      builder: (BuildContext context, TodayViewModel viewModel, Widget _) {
        return SafeArea(
          child: RefreshIndicator(
            onRefresh: viewModel.refreshData,
            child: ListView(
              children: [
                // * DatePicker widget
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: DatepickerWidget(),
                ),
                // * Challanges
                HeaderTextWidget(lable: 'challanges'),
                // * Active Challange card List
                // TODO: implement retreving (Active Challange card List) data from user.
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 20.0,
                    horizontal: 0,
                  ),
                  child: Container(
                    height: 100,
                    child: ListView(
                      clipBehavior: Clip.hardEdge,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ActiveChallangeCardWidget(
                            public: true,
                            iconData: FontAwesomeIcons.glassWhiskey,
                            iconColor: Colors.indigo,
                            lable: 'Drink water',
                            description: '5 cups a day',
                            progressValue: 0.2,
                            onTap: () => print('Challenge Tapped'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ActiveChallangeCardWidget(
                            public: false,
                            iconData: FontAwesomeIcons.book,
                            iconColor: Colors.orangeAccent,
                            lable: 'Read',
                            description: '20 pages a day',
                            progressValue: 0.5,
                            onTap: () => print('Challenge Tapped'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ActiveChallangeCardWidget(
                            public: true,
                            iconData: FontAwesomeIcons.solidKissWinkHeart,
                            iconColor: Colors.red,
                            lable: 'T-bag',
                            description: '3 T-bag a day',
                            progressValue: 0.3,
                            onTap: () => print('Challenge Tapped'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // * Today's tasks
                DateTime(
                            viewModel.currentDate.year,
                            viewModel.currentDate.month,
                            viewModel.currentDate.day) ==
                        DateTime(DateTime.now().year, DateTime.now().month,
                            DateTime.now().day)
                    ? HeaderTextWidget(lable: 'Today\'s Tasks')
                    : HeaderTextWidget(
                        lable:
                            '${viewModel.dateFormat.format(viewModel.currentDate)}  Tasks'),
                // * Tasks List
                // ! change this to not animated
                TodayTaskWidget(),
                // TaskListWidget(list: viewModel.getTodayTaskList())
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => TodayViewModel(),
    );
  }
}
