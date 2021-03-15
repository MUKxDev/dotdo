import 'package:dotdo/widgets/dumb_widgets/card/card_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/header_text/header_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/prograss_bar/prograss_bar_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/pvp_profile/pvp_profile_widget.dart';
import 'package:dotdo/widgets/smart_widgets/active_challange_card/active_challange_card_widget.dart';
import 'package:dotdo/widgets/smart_widgets/group_challange/group_challange_widget.dart';
import 'package:dotdo/widgets/smart_widgets/inactive_challange_card/inactive_challange_card_widget.dart';
import 'package:dotdo/widgets/smart_widgets/pvpchallange/pvpchallange_widget.dart';
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
            // * PVP challange Header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: HeaderTextWidget(lable: 'PvP challanges'),
            ),
            // * PVP challange list
            Container(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  // * PVP challange widget
                  PvpchallangeWidget(
                    onTap: () {},
                    lable: 'Drinking water challange',
                    profile1Named: 'mukxdev',
                    profile1ProgressValue: 0.5,
                    profile1Image: AssetImage('assets/pp.png'),
                    profile2Named: 'dotdo',
                    profile2ProgressValue: 0.3,
                    profile2Image: AssetImage('assets/Icon.png'),
                  ),
                  // * PVP challange widget
                  PvpchallangeWidget(
                    onTap: () {},
                    lable: 'Reading challange',
                    profile1Named: 'mukxdev',
                    profile1ProgressValue: 0.9,
                    profile1Image: AssetImage('assets/pp.png'),
                    profile2Named: 'dotdo',
                    profile2ProgressValue: 0.77,
                    profile2Image: AssetImage('assets/Icon.png'),
                  ),
                ],
              ),
            ),
            // * Group Challange Header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: HeaderTextWidget(lable: 'Group challanges'),
            ),
            // * Group challange list
            Container(
              height: 140,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  // * Group challange Widget
                  GroupChallangeWidget(
                    onTap: () {},
                    lable: 'Workout challange',
                    groupName: 'AutoVita',
                    rank: 2,
                    image: AssetImage('assets/pp.png'),
                  ),
                  GroupChallangeWidget(
                    onTap: () {},
                    lable: 'Fuck challange',
                    groupName: 'FuckSchool',
                    rank: 2,
                    image: AssetImage('assets/Icon.png'),
                  ),
                  GroupChallangeWidget(
                    onTap: () {},
                    lable: 'LOL challange',
                    groupName: 'Leage of Leagends',
                    rank: 2,
                    image: AssetImage('assets/Icon.png'),
                  ),
                ],
              ),
            ),
            // * Global challange Header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: HeaderTextWidget(lable: 'Global challanges'),
            ),
            // * Global challange List
            Container(
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
                    child: InactiveChallangeCardWidget(
                      public: true,
                      iconData: FontAwesomeIcons.glassWhiskey,
                      iconColor: Colors.indigo,
                      lable: 'Drink water in the bathroom',
                      onTap: () => print('Challenge Tapped'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InactiveChallangeCardWidget(
                      public: false,
                      iconData: FontAwesomeIcons.book,
                      iconColor: Colors.orangeAccent,
                      lable: 'Read',
                      onTap: () => print('Challenge Tapped'),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: InactiveChallangeCardWidget(
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
            // * Top liked challange header
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: HeaderTextWidget(lable: 'Top liked challange'),
            ),
            // * Top liked challange list
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
                      child: InactiveChallangeCardWidget(
                        public: true,
                        iconData: FontAwesomeIcons.glassWhiskey,
                        iconColor: Colors.indigo,
                        lable: 'Drink water in the bathroom',
                        onTap: () => print('Challenge Tapped'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InactiveChallangeCardWidget(
                        public: false,
                        iconData: FontAwesomeIcons.book,
                        iconColor: Colors.orangeAccent,
                        lable: 'Read',
                        onTap: () => print('Challenge Tapped'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: InactiveChallangeCardWidget(
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
