import 'package:dotdo/widgets/dumb_widgets/header_text/header_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/textfield/textfield_widget.dart';
import 'package:dotdo/widgets/smart_widgets/inactive_challange_card/inactive_challange_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'discover_view_model.dart';

class DiscoverView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DiscoverViewModel>.reactive(
      builder: (BuildContext context, DiscoverViewModel viewModel, Widget _) {
        return GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // * Search Textfield
              TextfieldWidget(
                controller: viewModel.searchController,
                obscureText: false,
                labelText: 'Search',
                hintText: 'search...',
              ),
              // * Routines Header
              HeaderTextWidget(lable: 'Routines'),
              // * Routines list
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 200,
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    scrollDirection: Axis.horizontal,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                    children: [
                      InactiveChallangeCardWidget(
                        public: true,
                        iconData: FontAwesomeIcons.glassWhiskey,
                        iconColor: Colors.indigo,
                        lable: 'Drink water in the bathroom',
                        onTap: () => print('Challenge Tapped'),
                      ),
                      InactiveChallangeCardWidget(
                        public: false,
                        iconData: FontAwesomeIcons.book,
                        iconColor: Colors.orangeAccent,
                        lable: 'Read',
                        onTap: () => print('Challenge Tapped'),
                      ),
                      InactiveChallangeCardWidget(
                        public: true,
                        iconData: FontAwesomeIcons.solidKissWinkHeart,
                        iconColor: Colors.red,
                        lable: 'T-bag',
                        onTap: () => print('Challenge Tapped'),
                      ),
                      InactiveChallangeCardWidget(
                        public: true,
                        iconData: FontAwesomeIcons.glassWhiskey,
                        iconColor: Colors.indigo,
                        lable: 'Drink water in the bathroom',
                        onTap: () => print('Challenge Tapped'),
                      ),
                      InactiveChallangeCardWidget(
                        public: false,
                        iconData: FontAwesomeIcons.book,
                        iconColor: Colors.orangeAccent,
                        lable: 'Read',
                        onTap: () => print('Challenge Tapped'),
                      ),
                      InactiveChallangeCardWidget(
                        public: true,
                        iconData: FontAwesomeIcons.solidKissWinkHeart,
                        iconColor: Colors.red,
                        lable: 'T-bag',
                        onTap: () => print('Challenge Tapped'),
                      ),
                      InactiveChallangeCardWidget(
                        public: true,
                        iconData: FontAwesomeIcons.glassWhiskey,
                        iconColor: Colors.indigo,
                        lable: 'Drink water in the bathroom',
                        onTap: () => print('Challenge Tapped'),
                      ),
                      InactiveChallangeCardWidget(
                        public: false,
                        iconData: FontAwesomeIcons.book,
                        iconColor: Colors.orangeAccent,
                        lable: 'Read',
                        onTap: () => print('Challenge Tapped'),
                      ),
                      InactiveChallangeCardWidget(
                        public: true,
                        iconData: FontAwesomeIcons.solidKissWinkHeart,
                        iconColor: Colors.red,
                        lable: 'T-bag',
                        onTap: () => print('Challenge Tapped'),
                      ),
                    ],
                  ),
                ),
              ),
              // * Challanges Header
              HeaderTextWidget(lable: 'Challanges'),
              // * Challanges list
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  height: 200,
                  child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 0.6,
                    scrollDirection: Axis.horizontal,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                    children: [
                      InactiveChallangeCardWidget(
                        public: true,
                        iconData: FontAwesomeIcons.glassWhiskey,
                        iconColor: Colors.indigo,
                        lable: 'Drink water in the bathroom',
                        onTap: () => print('Challenge Tapped'),
                      ),
                      InactiveChallangeCardWidget(
                        public: false,
                        iconData: FontAwesomeIcons.book,
                        iconColor: Colors.orangeAccent,
                        lable: 'Read',
                        onTap: () => print('Challenge Tapped'),
                      ),
                      InactiveChallangeCardWidget(
                        public: true,
                        iconData: FontAwesomeIcons.solidKissWinkHeart,
                        iconColor: Colors.red,
                        lable: 'T-bag',
                        onTap: () => print('Challenge Tapped'),
                      ),
                      InactiveChallangeCardWidget(
                        public: true,
                        iconData: FontAwesomeIcons.glassWhiskey,
                        iconColor: Colors.indigo,
                        lable: 'Drink water in the bathroom',
                        onTap: () => print('Challenge Tapped'),
                      ),
                      InactiveChallangeCardWidget(
                        public: false,
                        iconData: FontAwesomeIcons.book,
                        iconColor: Colors.orangeAccent,
                        lable: 'Read',
                        onTap: () => print('Challenge Tapped'),
                      ),
                      InactiveChallangeCardWidget(
                        public: true,
                        iconData: FontAwesomeIcons.solidKissWinkHeart,
                        iconColor: Colors.red,
                        lable: 'T-bag',
                        onTap: () => print('Challenge Tapped'),
                      ),
                      InactiveChallangeCardWidget(
                        public: true,
                        iconData: FontAwesomeIcons.glassWhiskey,
                        iconColor: Colors.indigo,
                        lable: 'Drink water in the bathroom',
                        onTap: () => print('Challenge Tapped'),
                      ),
                      InactiveChallangeCardWidget(
                        public: false,
                        iconData: FontAwesomeIcons.book,
                        iconColor: Colors.orangeAccent,
                        lable: 'Read',
                        onTap: () => print('Challenge Tapped'),
                      ),
                      InactiveChallangeCardWidget(
                        public: true,
                        iconData: FontAwesomeIcons.solidKissWinkHeart,
                        iconColor: Colors.red,
                        lable: 'T-bag',
                        onTap: () => print('Challenge Tapped'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => DiscoverViewModel(),
    );
  }
}
