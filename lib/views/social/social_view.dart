import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/widgets/dumb_widgets/header_text/header_text_widget.dart';
import 'package:dotdo/widgets/smart_widgets/active_challenge_card/active_challenge_card_widget.dart';
import 'package:dotdo/widgets/smart_widgets/group_challenge/group_challenge_widget.dart';
import 'package:dotdo/widgets/smart_widgets/inactive_challenge_card/inactive_challenge_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'social_view_model.dart';

class SocialView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SocialViewModel>.reactive(
      builder: (BuildContext context, SocialViewModel viewModel, Widget _) {
        return ListView(
          children: [
            // * PVP challenge Header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: HeaderTextWidget(lable: 'PvP challenges'),
            ),
            // * PVP challenge list
            StreamBuilder(
              stream: viewModel.pvpsAStream,
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshots) {
                return Container(
                  height: 20,
                  width: 20,
                  color: Colors.red,
                );
              },
            ),
            // * Group Challenge Header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: HeaderTextWidget(lable: 'Group challenges'),
            ),
            // * Group challenge list
            Container(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  // * Group challenge Widget
                  GroupChallengeWidget(
                    onTap: () {},
                    lable: 'Workout challenge',
                    groupName: 'AutoVita',
                    rank: 2,
                    image: AssetImage('assets/pp.png'),
                  ),
                  GroupChallengeWidget(
                    onTap: () {},
                    lable: 'Developing challenge',
                    groupName: 'DevSchool',
                    rank: 2,
                    image: AssetImage('assets/Icon.png'),
                  ),
                  GroupChallengeWidget(
                    onTap: () {},
                    lable: 'LOL challenge',
                    groupName: 'Leage of Leagends',
                    rank: 2,
                    image: AssetImage('assets/Icon.png'),
                  ),
                ],
              ),
            ),
            // * Global challenge Header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: HeaderTextWidget(lable: 'Global challenges'),
            ),
            // * Global challenge List
            Container(
              height: 105,
              child: ListView(
                clipBehavior: Clip.hardEdge,
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: ActiveChallengeCardWidget(
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
                    child: ActiveChallengeCardWidget(
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
                    child: ActiveChallengeCardWidget(
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
            // * Top liked routiens header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: HeaderTextWidget(lable: 'Top liked routiens'),
            ),
            // * Top liked routiens list
            Container(
              height: 100,
              child: ListView(
                clipBehavior: Clip.hardEdge,
                scrollDirection: Axis.horizontal,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InactiveChallengeCardWidget(
                      public: true,
                      iconData: FontAwesomeIcons.glassWhiskey,
                      iconColor: Colors.indigo,
                      lable: 'Drink water in the bathroom',
                      onTap: () => print('Challenge Tapped'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InactiveChallengeCardWidget(
                      public: false,
                      iconData: FontAwesomeIcons.book,
                      iconColor: Colors.orangeAccent,
                      lable: 'Read',
                      onTap: () => print('Challenge Tapped'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InactiveChallengeCardWidget(
                      public: true,
                      iconData: FontAwesomeIcons.solidKissWinkHeart,
                      iconColor: Colors.red,
                      lable: 'T-bag',
                      onTap: () => print('Challenge Tapped'),
                    ),
                  ),
                ],
              ),
            ),
            // * Top liked challenge header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: HeaderTextWidget(lable: 'Top liked challenge'),
            ),
            // * Top liked challenge list
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Container(
                height: 100,
                child: ListView(
                  clipBehavior: Clip.hardEdge,
                  scrollDirection: Axis.horizontal,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InactiveChallengeCardWidget(
                        public: true,
                        iconData: FontAwesomeIcons.glassWhiskey,
                        iconColor: Colors.indigo,
                        lable: 'Drink water in the bathroom',
                        onTap: () => print('Challenge Tapped'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InactiveChallengeCardWidget(
                        public: false,
                        iconData: FontAwesomeIcons.book,
                        iconColor: Colors.orangeAccent,
                        lable: 'Read',
                        onTap: () => print('Challenge Tapped'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InactiveChallengeCardWidget(
                        public: true,
                        iconData: FontAwesomeIcons.solidKissWinkHeart,
                        iconColor: Colors.red,
                        lable: 'T-bag',
                        onTap: () => print('Challenge Tapped'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
      viewModelBuilder: () => SocialViewModel(),
    );
  }
}
