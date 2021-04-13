import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/widgets/dumb_widgets/header_text/header_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/textfield/textfield_widget.dart';
import 'package:dotdo/widgets/smart_widgets/inactive_challenge_card/inactive_challenge_card_widget.dart';
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                verticalSpaceXSmall(context),
                // * Search Textfield
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    height: 60,
                    child: TextField(
                      autocorrect: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        fillColor: Theme.of(context).primaryColor,
                      ),
                      controller: viewModel.searchController,
                      onSubmitted: (searchValue) => print(searchValue),
                    ),
                  ),
                ),
                // * Routines Header
                HeaderTextWidget(lable: 'Routines'),
                // * Routines list
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 220,
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      scrollDirection: Axis.horizontal,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20,
                      children: [
                        InactiveChallengeCardWidget(
                          public: true,
                          iconData: FontAwesomeIcons.glassWhiskey,
                          iconColor: Colors.indigo,
                          lable: 'Drink water in the bathroom',
                          onTap: () => print('Challenge Tapped'),
                        ),
                        InactiveChallengeCardWidget(
                          public: false,
                          iconData: FontAwesomeIcons.book,
                          iconColor: Colors.orangeAccent,
                          lable: 'Read',
                          onTap: () => print('Challenge Tapped'),
                        ),
                        InactiveChallengeCardWidget(
                          public: true,
                          iconData: FontAwesomeIcons.solidKissWinkHeart,
                          iconColor: Colors.red,
                          lable: 'T-bag',
                          onTap: () => print('Challenge Tapped'),
                        ),
                        InactiveChallengeCardWidget(
                          public: true,
                          iconData: FontAwesomeIcons.glassWhiskey,
                          iconColor: Colors.indigo,
                          lable: 'Drink water in the bathroom',
                          onTap: () => print('Challenge Tapped'),
                        ),
                        InactiveChallengeCardWidget(
                          public: false,
                          iconData: FontAwesomeIcons.book,
                          iconColor: Colors.orangeAccent,
                          lable: 'Read',
                          onTap: () => print('Challenge Tapped'),
                        ),
                        InactiveChallengeCardWidget(
                          public: true,
                          iconData: FontAwesomeIcons.solidKissWinkHeart,
                          iconColor: Colors.red,
                          lable: 'T-bag',
                          onTap: () => print('Challenge Tapped'),
                        ),
                        InactiveChallengeCardWidget(
                          public: true,
                          iconData: FontAwesomeIcons.glassWhiskey,
                          iconColor: Colors.indigo,
                          lable: 'Drink water in the bathroom',
                          onTap: () => print('Challenge Tapped'),
                        ),
                        InactiveChallengeCardWidget(
                          public: false,
                          iconData: FontAwesomeIcons.book,
                          iconColor: Colors.orangeAccent,
                          lable: 'Read',
                          onTap: () => print('Challenge Tapped'),
                        ),
                        InactiveChallengeCardWidget(
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
                // * Challenges Header
                HeaderTextWidget(lable: 'Challenges'),
                // * Challenges list
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    height: 220,
                    child: GridView.count(
                      crossAxisCount: 2,
                      childAspectRatio: 0.65,
                      scrollDirection: Axis.horizontal,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 20,
                      children: [
                        InactiveChallengeCardWidget(
                          public: true,
                          iconData: FontAwesomeIcons.glassWhiskey,
                          iconColor: Colors.indigo,
                          lable: 'Drink water in the bathroom',
                          onTap: () => print('Challenge Tapped'),
                        ),
                        InactiveChallengeCardWidget(
                          public: false,
                          iconData: FontAwesomeIcons.book,
                          iconColor: Colors.orangeAccent,
                          lable: 'Read',
                          onTap: () => print('Challenge Tapped'),
                        ),
                        InactiveChallengeCardWidget(
                          public: true,
                          iconData: FontAwesomeIcons.solidKissWinkHeart,
                          iconColor: Colors.red,
                          lable: 'T-bag',
                          onTap: () => print('Challenge Tapped'),
                        ),
                        InactiveChallengeCardWidget(
                          public: true,
                          iconData: FontAwesomeIcons.glassWhiskey,
                          iconColor: Colors.indigo,
                          lable: 'Drink water in the bathroom',
                          onTap: () => print('Challenge Tapped'),
                        ),
                        InactiveChallengeCardWidget(
                          public: false,
                          iconData: FontAwesomeIcons.book,
                          iconColor: Colors.orangeAccent,
                          lable: 'Read',
                          onTap: () => print('Challenge Tapped'),
                        ),
                        InactiveChallengeCardWidget(
                          public: true,
                          iconData: FontAwesomeIcons.solidKissWinkHeart,
                          iconColor: Colors.red,
                          lable: 'T-bag',
                          onTap: () => print('Challenge Tapped'),
                        ),
                        InactiveChallengeCardWidget(
                          public: true,
                          iconData: FontAwesomeIcons.glassWhiskey,
                          iconColor: Colors.indigo,
                          lable: 'Drink water in the bathroom',
                          onTap: () => print('Challenge Tapped'),
                        ),
                        InactiveChallengeCardWidget(
                          public: false,
                          iconData: FontAwesomeIcons.book,
                          iconColor: Colors.orangeAccent,
                          lable: 'Read',
                          onTap: () => print('Challenge Tapped'),
                        ),
                        InactiveChallengeCardWidget(
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
          ),
        );
      },
      viewModelBuilder: () => DiscoverViewModel(),
    );
  }
}
