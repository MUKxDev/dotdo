import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/widgets/dumb_widgets/card/card_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/header_text/header_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:dotdo/widgets/smart_widgets/two_row_grid_active_challenge_stream/two_row_grid_active_challenge_stream_widget.dart';
import 'package:flutter/material.dart';
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
              // * profile dots
              DescriptionTextWidget(description: 'Dots: 135'),
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
                                              'Challenges',
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
              // * challenges grid
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HeaderTextWidget(lable: 'challenges'),
                  TwoRowGridActiveChallengeStreamWidget(
                    stream: viewModel.getActiveUChallenge,
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
