import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/models/PChallenge.dart';
import 'package:dotdo/core/models/Routine.dart';
import 'package:dotdo/core/models/User.dart';
import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/header_text/header_text_widget.dart';
import 'package:dotdo/widgets/smart_widgets/inactive_challenge_card/inactive_challenge_card_widget.dart';
import 'package:dotdo/widgets/smart_widgets/pvpchallenge/pvpchallenge_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'social_view_model.dart';

class SocialView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SocialViewModel>.reactive(
      onModelReady: (SocialViewModel viewModel) => viewModel.handleOnStartUp(),
      builder: (BuildContext context, SocialViewModel viewModel, Widget _) {
        return viewModel.isbusy
            ? Container(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              )
            : ListView(
                children: [
                  // * PVP challenge Header
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: HeaderTextWidget(lable: 'PvP challenges'),
                  ),
                  // * PVP challenge list
                  viewModel.pvpChallanges.isEmpty
                      ? Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Container(
                            width: screenWidth(context),
                            height: 140,
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: DescriptionTextWidget(
                                  description: 'You don\'t have active Pvps!'),
                            ),
                          ),
                        )
                      : Container(
                          height: 143,
                          // width: 200,
                          child: ListView.builder(
                              clipBehavior: Clip.hardEdge,
                              scrollDirection: Axis.horizontal,
                              itemCount: viewModel.pvpChallanges.length,
                              itemBuilder: (context, index) {
                                PChallenge _pChallenge =
                                    viewModel.pvpChallanges[index];
                                User _userA =
                                    viewModel.pvpChallangeUsers[index][0];
                                User _userB =
                                    viewModel.pvpChallangeUsers[index][1];
                                return PvpchallengeWidget(
                                    width: screenWidth(context) * 0.85,
                                    onTap: () => viewModel.challengeTapped(
                                        pvpId: viewModel.pvpPath[index][0],
                                        challengeID: viewModel.pvpPath[index]
                                            [1]),
                                    lable: _pChallenge.name,
                                    profile1Named: _userA.userName,
                                    profile1ProgressValue:
                                        _pChallenge.aCTask == 0
                                            ? 0
                                            : (_pChallenge.aCTask /
                                                _pChallenge.noOfTasks),
                                    profile1Image:
                                        NetworkImage(_userA.profilePic),
                                    profile2Named: _userB.userName,
                                    profile2ProgressValue: _pChallenge.bCTask ==
                                            0
                                        ? 0
                                        : (_pChallenge.bCTask /
                                            _pChallenge.noOfTasks),
                                    profile2Image:
                                        NetworkImage(_userB.profilePic));
                              }),
                        ),
                  // * Top liked routiens header
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: HeaderTextWidget(lable: 'Top liked routiens'),
                  ),
                  // * Top liked routiens list
                  StreamBuilder(
                      stream: viewModel.topLikedRoutinesStream,
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshots) {
                        return snapshots.hasData == false
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  width: screenWidth(context),
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: DescriptionTextWidget(
                                        description:
                                            'There are no public routines yet'),
                                  ),
                                ),
                              )
                            : (snapshots.data.size == 0
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Container(
                                      width: screenWidth(context),
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: DescriptionTextWidget(
                                            description:
                                                'There are no public routines yet'),
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 110,
                                    child: ListView.builder(
                                      clipBehavior: Clip.hardEdge,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshots.data.size,
                                      itemBuilder: (context, index) {
                                        Routine _routine = Routine.fromMap(
                                            snapshots.data.docs[index].data());
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: InactiveChallengeCardWidget(
                                            backgroundcolor:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? AppColors.lightRoutine
                                                    : AppColors.darkRoutine,
                                            public: _routine.publicRoutine,
                                            iconData: _routine.iconData,
                                            iconColor: _routine.iconColor,
                                            lable: _routine.name,
                                            likes: _routine.noOfLikes,
                                            onTap: () => viewModel
                                                .routineTapped(snapshots
                                                    .data.docs[index].id),
                                          ),
                                        );
                                      },
                                    ),
                                  ));
                      }),
                  // * Your public routiens header
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: HeaderTextWidget(lable: 'Your public routiens'),
                  ),
                  //  * Your public routiens Stream
                  StreamBuilder(
                      stream: viewModel.yourPublicRoutinesStream,
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshots) {
                        return snapshots.hasData == false
                            ? Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Container(
                                  width: screenWidth(context),
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Theme.of(context).primaryColor,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Center(
                                    child: DescriptionTextWidget(
                                        description:
                                            'You don\'t have any public routines yet'),
                                  ),
                                ),
                              )
                            : (snapshots.data.size == 0
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Container(
                                      width: screenWidth(context),
                                      height: 120,
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).primaryColor,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Center(
                                        child: DescriptionTextWidget(
                                            description:
                                                'You don\'t have any public routines yet'),
                                      ),
                                    ),
                                  )
                                : Container(
                                    height: 110,
                                    child: ListView.builder(
                                      clipBehavior: Clip.hardEdge,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: snapshots.data.size,
                                      itemBuilder: (context, index) {
                                        Routine _routine = Routine.fromMap(
                                            snapshots.data.docs[index].data());
                                        return Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10),
                                          child: InactiveChallengeCardWidget(
                                            backgroundcolor:
                                                Theme.of(context).brightness ==
                                                        Brightness.light
                                                    ? AppColors.lightRoutine
                                                    : AppColors.darkRoutine,
                                            public: _routine.publicRoutine,
                                            iconData: _routine.iconData,
                                            iconColor: _routine.iconColor,
                                            lable: _routine.name,
                                            likes: _routine.noOfLikes,
                                            onTap: () => viewModel
                                                .yourPublicRoutineTapped(
                                                    snapshots
                                                        .data.docs[index].id),
                                          ),
                                        );
                                      },
                                    ),
                                  ));
                      }),

                  // // * Group Challenge Header
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 20),
                  //   child: HeaderTextWidget(lable: 'Group challenges'),
                  // ),
                  // // * Group challenge list
                  // Container(
                  //   height: 140,
                  //   child: ListView(
                  //     scrollDirection: Axis.horizontal,
                  //     children: [
                  //       // * Group challenge Widget
                  //       GroupChallengeWidget(
                  //         onTap: () {},
                  //         lable: 'Workout challenge',
                  //         groupName: 'AutoVita',
                  //         rank: 2,
                  //         image: AssetImage('assets/pp.png'),
                  //       ),
                  //       GroupChallengeWidget(
                  //         onTap: () {},
                  //         lable: 'Developing challenge',
                  //         groupName: 'DevSchool',
                  //         rank: 2,
                  //         image: AssetImage('assets/Icon.png'),
                  //       ),
                  //       GroupChallengeWidget(
                  //         onTap: () {},
                  //         lable: 'LOL challenge',
                  //         groupName: 'Leage of Leagends',
                  //         rank: 2,
                  //         image: AssetImage('assets/Icon.png'),
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // // * Global challenge Header
                  // Padding(
                  //   padding: const EdgeInsets.symmetric(vertical: 20),
                  //   child: HeaderTextWidget(lable: 'Global challenges'),
                  // ),
                  // // * Global challenge List
                  // Container(
                  //   height: 105,
                  //   child: ListView(
                  //     clipBehavior: Clip.hardEdge,
                  //     scrollDirection: Axis.horizontal,
                  //     children: [
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 10),
                  //         child: ActiveChallengeCardWidget(
                  //           public: true,
                  //           iconData: FontAwesomeIcons.glassWhiskey,
                  //           iconColor: Colors.indigo,
                  //           lable: 'Drink water',
                  //           description: '5 cups a day',
                  //           progressValue: 0.2,
                  //           onTap: () => print('Challenge Tapped'),
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 10),
                  //         child: ActiveChallengeCardWidget(
                  //           public: false,
                  //           iconData: FontAwesomeIcons.book,
                  //           iconColor: Colors.orangeAccent,
                  //           lable: 'Read',
                  //           description: '20 pages a day',
                  //           progressValue: 0.5,
                  //           onTap: () => print('Challenge Tapped'),
                  //         ),
                  //       ),
                  //       Padding(
                  //         padding: const EdgeInsets.symmetric(horizontal: 10),
                  //         child: ActiveChallengeCardWidget(
                  //           public: true,
                  //           iconData: FontAwesomeIcons.solidKissWinkHeart,
                  //           iconColor: Colors.red,
                  //           lable: 'T-bag',
                  //           description: '3 T-bag a day',
                  //           progressValue: 0.3,
                  //           onTap: () => print('Challenge Tapped'),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // ),

                  //   // * Top liked challenge header
                  //   Padding(
                  //     padding: const EdgeInsets.symmetric(vertical: 20),
                  //     child: HeaderTextWidget(lable: 'Top liked challenge'),
                  //   ),
                  //   // * Top liked challenge list
                  //   Padding(
                  //     padding: const EdgeInsets.only(bottom: 30),
                  //     child: Container(
                  //       height: 100,
                  //       child: ListView(
                  //         clipBehavior: Clip.hardEdge,
                  //         scrollDirection: Axis.horizontal,
                  //         children: [
                  //           Padding(
                  //             padding: const EdgeInsets.symmetric(horizontal: 10),
                  //             child: InactiveChallengeCardWidget(
                  //               public: true,
                  //               iconData: FontAwesomeIcons.glassWhiskey,
                  //               iconColor: Colors.indigo,
                  //               lable: 'Drink water in the bathroom',
                  //               onTap: () => print('Challenge Tapped'),
                  //             ),
                  //           ),
                  //           Padding(
                  //             padding: const EdgeInsets.symmetric(horizontal: 10),
                  //             child: InactiveChallengeCardWidget(
                  //               public: false,
                  //               iconData: FontAwesomeIcons.book,
                  //               iconColor: Colors.orangeAccent,
                  //               lable: 'Read',
                  //               onTap: () => print('Challenge Tapped'),
                  //             ),
                  //           ),
                  //           Padding(
                  //             padding: const EdgeInsets.symmetric(horizontal: 10),
                  //             child: InactiveChallengeCardWidget(
                  //               public: true,
                  //               iconData: FontAwesomeIcons.solidKissWinkHeart,
                  //               iconColor: Colors.red,
                  //               lable: 'T-bag',
                  //               onTap: () => print('Challenge Tapped'),
                  //             ),
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  verticalSpaceMedium(context),
                ],
              );
      },
      viewModelBuilder: () => SocialViewModel(),
    );
  }
}
