import 'package:dotdo/widgets/dumb_widgets/header_text/header_text_widget.dart';
import 'package:dotdo/widgets/smart_widgets/active_challange_card/active_challange_card_widget.dart';
import 'package:dotdo/widgets/smart_widgets/datepicker/datepicker_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import '../../constant.dart';
import 'today_view_model.dart';

class TodayView extends StatelessWidget {
  // TodayView({@required this.args});
  // final Map args;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TodayViewModel>.reactive(
      builder: (BuildContext context, TodayViewModel viewModel, Widget _) {
        return Scaffold(
            // * appbar
            appBar: AppBar(
              shape: appBarShapeBorder,
              title: Text(
                viewModel.title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(Icons.logout),
                  onPressed: viewModel.logout,
                )
              ],
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // * DatePicker widget
                    Padding(
                      padding: EdgeInsets.all(20),
                      child: DatepickerWidget(),
                    ),
                    // * Challanges
                    HeaderTextWidget(lable: 'challanges'),
                    // * Active Challange card
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 20.0,
                        // horizontal: 10,
                      ),
                      child: Container(
                        height: 100,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          // TODO: This is just for testing, should implement retreving data from user.
                          children: [
                            ActiveChallangeCardWidget(
                              public: true,
                              iconData: FontAwesomeIcons.glassWhiskey,
                              iconColor: Colors.indigo,
                              lable: 'Drink water',
                              description: '5 cups a day',
                              progressValue: 0.7,
                              onTap: () => print('Challenge Tapped'),
                            ),
                            ActiveChallangeCardWidget(
                              public: false,
                              iconData: FontAwesomeIcons.book,
                              iconColor: Colors.orangeAccent,
                              lable: 'Read',
                              description: '20 pages a day',
                              progressValue: 0.5,
                              onTap: () => print('Challenge Tapped'),
                            ),
                            ActiveChallangeCardWidget(
                              public: true,
                              iconData: FontAwesomeIcons.solidKissWinkHeart,
                              iconColor: Colors.red,
                              lable: 'T-bag',
                              description: '3 T-bag a day',
                              progressValue: 0.3,
                              onTap: () => print('Challenge Tapped'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
      },
      viewModelBuilder: () => TodayViewModel(),
    );
  }
}
