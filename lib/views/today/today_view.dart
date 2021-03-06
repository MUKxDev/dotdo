import 'package:dotdo/core/models/task.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/header_text/header_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:dotdo/widgets/smart_widgets/active_challange_card/active_challange_card_widget.dart';
import 'package:dotdo/widgets/smart_widgets/datepicker/datepicker_widget.dart';
import 'package:dotdo/widgets/smart_widgets/task/task_widget.dart';
import 'package:dotdo/widgets/smart_widgets/task_list/task_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'today_view_model.dart';

class TodayView extends StatelessWidget {
  // TodayView({@required this.args});
  // final Map args;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TodayViewModel>.reactive(
      builder: (BuildContext context, TodayViewModel viewModel, Widget _) {
        return SafeArea(
          child: ListView(
            children: [
              // * DatePicker widget
              Padding(
                padding: EdgeInsets.all(20),
                child: DatepickerWidget(),
              ),
              // * Challanges
              HeaderTextWidget(lable: 'challanges'),
              // * Active Challange card List
              // TODO: implement retreving (Active Challange card List) data from user.
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 20.0,
                  horizontal: 10,
                ),
                child: Container(
                  height: 100,
                  child: ListView(
                    clipBehavior: Clip.none,
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
              HeaderTextWidget(lable: 'Today\'s Tasks'),
              // * Tasks List
              // TODO: implement retreving (Tasks List) data from user.
              TaskListWidget(),
              // ListView(
              //   shrinkWrap: true,
              //   physics: ScrollPhysics(),
              //   children: [
              //     TaskWidget(
              //       id: '1',
              //       public: true,
              //       checked: true,
              //       lable: 'A task to do',
              //       category: 'Work',
              //       due: DateTime.now(),
              //       onTap: () => print('Task tapped'),
              //       toggleChecked: () => print('checked tapped'),
              //     ),
              //     TaskWidget(
              //       id: '2',
              //       public: false,
              //       checked: true,
              //       lable: 'A task to do',
              //       category: 'Work',
              //       due: DateTime.now(),
              //       onTap: () => print('Task tapped'),
              //       toggleChecked: () => print('checked tapped'),
              //     ),
              //     TaskWidget(
              //       id: '3',
              //       public: true,
              //       checked: true,
              //       lable: 'A task to do',
              //       category: 'Work',
              //       due: DateTime.now(),
              //       onTap: () => print('Task tapped'),
              //       toggleChecked: () => print('checked tapped'),
              //     ),
              //     TaskWidget(
              //       id: '4',
              //       public: false,
              //       checked: true,
              //       lable: 'A task to do',
              //       category: 'Work',
              //       due: DateTime.now(),
              //       onTap: () => print('Task tapped'),
              //       toggleChecked: () => print('checked tapped'),
              //     ),
              //     TaskWidget(
              //       id: '5',
              //       public: true,
              //       checked: true,
              //       lable: 'A task to do',
              //       category: 'Work',
              //       due: DateTime.now(),
              //       onTap: () => print('Task tapped'),
              //       toggleChecked: () => print('checked tapped'),
              //     ),
              //   ],
              // ),
            ],
          ),
        );
      },
      viewModelBuilder: () => TodayViewModel(),
    );
  }
}
