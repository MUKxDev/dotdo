import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/widgets/dumb_widgets/card/card_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/header_text/header_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:dotdo/widgets/smart_widgets/active_challange_card/active_challange_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'profile_view_model.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      builder: (BuildContext context, ProfileViewModel viewModel, Widget _) {
        return SingleChildScrollView(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // * profile picture
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Center(
                  child: Container(
                    height: 120,
                    width: 120,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: DecorationImage(
                        image: AssetImage('assets/pp.png'),
                      ),
                    ),
                  ),
                ),
              ),
              // * profile name
              Padding(
                padding: const EdgeInsets.only(
                  top: 20,
                  bottom: 10,
                ),
                child: LableTextWidget(lable: 'Mohamed Mukhtar'),
              ),
              // * profile karma
              DescriptionTextWidget(description: 'Karma: 135'),
              // * profile points
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  width: screenWidth(context) * 0.9,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: screenWidth(context) * 0.45,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    width: screenWidth(context) * 0.28,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Tasks',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            'Completed',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  DescriptionTextWidget(description: '999999')
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: screenWidth(context) * 0.28,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Challanges',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              'Completed',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    DescriptionTextWidget(description: '999999')
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // the right column
                      Container(
                        width: screenWidth(context) * 0.45,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Container(
                                    width: screenWidth(context) * 0.28,
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 20),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Badges',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            'Collected',
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  DescriptionTextWidget(description: '13')
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                      width: screenWidth(context) * 0.28,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Latest',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            Text(
                                              'Badges',
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      height: 42,
                                      width: 42,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: AssetImage('assets/Icon.png'),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // * profile categories
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderTextWidget(lable: 'categories'),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 205,
                      child: GridView.count(
                        crossAxisCount: 2,
                        childAspectRatio: 0.65,
                        scrollDirection: Axis.horizontal,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20,
                        children: [
                          ActiveChallangeCardWidget(
                            lable: 'Index',
                            onTap: () => print('Challenge Tapped'),
                            progressValue: 0.5,
                            description: '13 Tasks',
                          ),
                          ActiveChallangeCardWidget(
                            iconData: FontAwesomeIcons.book,
                            iconColor: Colors.orangeAccent,
                            lable: 'Reading',
                            onTap: () => print('Challenge Tapped'),
                            progressValue: 0.8,
                            description: '13 Tasks',
                          ),
                          ActiveChallangeCardWidget(
                            public: true,
                            iconData: FontAwesomeIcons.artstation,
                            lable: 'Draw',
                            onTap: () => print('Challenge Tapped'),
                            progressValue: 0.5,
                            description: '13 Tasks',
                          ),
                          ActiveChallangeCardWidget(
                            public: true,
                            iconData: FontAwesomeIcons.pen,
                            iconColor: Colors.indigo,
                            lable: 'Work',
                            onTap: () => print('Challenge Tapped'),
                            progressValue: 0.2,
                            description: '13 Tasks',
                          ),
                          ActiveChallangeCardWidget(
                            iconData: FontAwesomeIcons.book,
                            iconColor: Colors.orangeAccent,
                            lable: 'University',
                            onTap: () => print('Challenge Tapped'),
                            progressValue: 0.2,
                            description: '13 Tasks',
                          ),
                          ActiveChallangeCardWidget(
                            public: true,
                            iconData: FontAwesomeIcons.solidKissWinkHeart,
                            iconColor: Colors.red,
                            lable: 'Workout',
                            onTap: () => print('Challenge Tapped'),
                            progressValue: 0.5,
                            description: '13 Tasks',
                          ),
                          ActiveChallangeCardWidget(
                            public: true,
                            iconData: FontAwesomeIcons.glassWhiskey,
                            iconColor: Colors.indigo,
                            lable: 'Developing',
                            onTap: () => print('Challenge Tapped'),
                            progressValue: 0.2,
                            description: '13 Tasks',
                          ),
                          ActiveChallangeCardWidget(
                            iconData: FontAwesomeIcons.book,
                            iconColor: Colors.orangeAccent,
                            lable: 'Cleaning',
                            onTap: () => print('Challenge Tapped'),
                            progressValue: 0.2,
                            description: '13 Tasks',
                          ),
                          ActiveChallangeCardWidget(
                            public: true,
                            iconData: FontAwesomeIcons.solidKissWinkHeart,
                            iconColor: Colors.red,
                            lable: 'Photography',
                            onTap: () => print('Challenge Tapped'),
                            progressValue: 0.2,
                            description: '13 Tasks',
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              // * profile Badges
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderTextWidget(lable: 'Badges'),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      height: 235,
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      width: screenWidth(context),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GridView.count(
                          crossAxisCount: 6,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          children: [
                            Container(
                              height: 42,
                              width: 42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage('assets/Icon.png'),
                                ),
                              ),
                            ),
                            Container(
                              height: 42,
                              width: 42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage('assets/Icon.png'),
                                ),
                              ),
                            ),
                            Container(
                              height: 42,
                              width: 42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage('assets/Icon.png'),
                                ),
                              ),
                            ),
                            Container(
                              height: 42,
                              width: 42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage('assets/Icon.png'),
                                ),
                              ),
                            ),
                            Container(
                              height: 42,
                              width: 42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage('assets/Icon.png'),
                                ),
                              ),
                            ),
                            Container(
                              height: 42,
                              width: 42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage('assets/Icon.png'),
                                ),
                              ),
                            ),
                            Container(
                              height: 42,
                              width: 42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage('assets/Icon.png'),
                                ),
                              ),
                            ),
                            Container(
                              height: 42,
                              width: 42,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                  image: AssetImage('assets/Icon.png'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              ),
              // * profile status (following - followers etc...)
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 40,
                  horizontal: 10,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CardWidget(
                          onTap: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DescriptionTextWidget(
                                description: '13',
                                bold: true,
                                fontSize: 24,
                              ),
                              LableTextWidget(lable: 'Following'),
                            ],
                          ),
                          height: 100,
                          width: screenWidth(context) * 0.45,
                        ),
                        CardWidget(
                          onTap: () {},
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              DescriptionTextWidget(
                                description: '13',
                                bold: true,
                                fontSize: 24,
                              ),
                              LableTextWidget(lable: 'Following'),
                            ],
                          ),
                          height: 100,
                          width: screenWidth(context) * 0.45,
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CardWidget(
                            onTap: () {},
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DescriptionTextWidget(
                                  description: '2',
                                  bold: true,
                                  fontSize: 24,
                                ),
                                LableTextWidget(lable: 'Groups'),
                              ],
                            ),
                            height: 100,
                            width: screenWidth(context) * 0.45,
                          ),
                          CardWidget(
                            onTap: () {},
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                DescriptionTextWidget(
                                  description: '18',
                                  bold: true,
                                  fontSize: 24,
                                ),
                                LableTextWidget(lable: 'Likes'),
                              ],
                            ),
                            height: 100,
                            width: screenWidth(context) * 0.45,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
      viewModelBuilder: () => ProfileViewModel(),
    );
  }
}
