import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/button/button_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/card/card_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/header_text/header_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/icon_button/icon_button_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/lable_text/lable_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/textfield/textfield_widget.dart';
import 'package:dotdo/widgets/smart_widgets/routines_stream/routines_stream_widget.dart';
import 'package:dotdo/widgets/smart_widgets/upcoming_challenge_stream/upcoming_challenge_stream_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'profile_view_model.dart';

class ProfileView extends StatelessWidget {
  final String uid;

  const ProfileView({Key key, this.uid}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<ProfileViewModel>.reactive(
      onModelReady: (ProfileViewModel viewModel) =>
          viewModel.handleOnStartup(uid),
      builder: (BuildContext context, ProfileViewModel viewModel, Widget _) {
        return viewModel.isBusy
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
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
                              fit: BoxFit.cover,
                              // image: AssetImage('assets/pp.png'),
                              image: NetworkImage(viewModel.user.profilePic),
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
                      child: LableTextWidget(lable: viewModel.user.userName),
                    ),
                    // * profile dots
                    DescriptionTextWidget(
                        description: 'Dots: ${viewModel.user.dots.toString()}'),
                    viewModel.isCurrentUser
                        ? Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ButtonWidget(
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          contentPadding: EdgeInsets.all(10),
                                          scrollable: true,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          backgroundColor:
                                              Theme.of(context).primaryColor,
                                          content: Container(
                                            child: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  children: [
                                                    // Avatar
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: LableTextWidget(
                                                              lable:
                                                                  'Change profile picture'),
                                                        ),
                                                        verticalSpaceXSmall(
                                                            context),
                                                        Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            10),
                                                                color: Theme.of(
                                                                        context)
                                                                    .scaffoldBackgroundColor),
                                                            width: 300,
                                                            child: Column(
                                                              children: [
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(8),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      DescriptionTextWidget(
                                                                          description:
                                                                              'Take a picture'),
                                                                      IconButtonWidget(
                                                                          iconSize:
                                                                              22,
                                                                          height:
                                                                              40,
                                                                          width:
                                                                              40,
                                                                          onTap:
                                                                              () {
                                                                            viewModel.selectImageFromCamera();
                                                                          },
                                                                          iconData:
                                                                              FontAwesomeIcons.camera)
                                                                    ],
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(8),
                                                                  child: Row(
                                                                    mainAxisAlignment:
                                                                        MainAxisAlignment
                                                                            .spaceBetween,
                                                                    children: [
                                                                      DescriptionTextWidget(
                                                                          description:
                                                                              'Choose from Gallery'),
                                                                      IconButtonWidget(
                                                                          iconSize:
                                                                              22,
                                                                          height:
                                                                              40,
                                                                          width:
                                                                              40,
                                                                          onTap:
                                                                              () {
                                                                            viewModel.selectImageFromGallery();
                                                                          },
                                                                          iconData:
                                                                              FontAwesomeIcons.image)
                                                                    ],
                                                                  ),
                                                                ),
                                                              ],
                                                            )),
                                                      ],
                                                    ),
                                                    // UserName
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: LableTextWidget(
                                                              lable:
                                                                  'Change username'),
                                                        ),
                                                        verticalSpaceXSmall(
                                                            context),
                                                        Container(
                                                          decoration: BoxDecoration(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10),
                                                              color: Theme.of(
                                                                      context)
                                                                  .scaffoldBackgroundColor),
                                                          width: 300,
                                                          child: Column(
                                                            children: [
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(8),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    LableTextWidget(
                                                                        lable:
                                                                            'From: '),
                                                                    DescriptionTextWidget(
                                                                        description: viewModel
                                                                            .user
                                                                            .userName),
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(8),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .spaceBetween,
                                                                  children: [
                                                                    LableTextWidget(
                                                                        lable:
                                                                            'To: '),
                                                                    Expanded(
                                                                      child:
                                                                          Container(
                                                                        child:
                                                                            TextField(
                                                                          controller:
                                                                              viewModel.usernameController,
                                                                          decoration:
                                                                              InputDecoration(
                                                                            suffixText:
                                                                                '#XXX000',
                                                                            hintText:
                                                                                'username',
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(10),
                                                                child: Row(
                                                                  children: [
                                                                    Expanded(
                                                                      child:
                                                                          Container(
                                                                        child: ButtonWidget(
                                                                            borderRadius:
                                                                                10,
                                                                            onPressed:
                                                                                viewModel.updateUsername,
                                                                            text: 'Update Username'),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                },
                                text: 'Edit Profile'),
                          )
                        : Container(),

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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: screenWidth(context) * 0.28,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Tasks',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  'Completed',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        DescriptionTextWidget(
                                            description: viewModel
                                                .userGeneral.noOfTaskCompleted
                                                .toString())
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: screenWidth(context) * 0.28,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Challenges',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    'Completed',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          DescriptionTextWidget(
                                              description: viewModel.userGeneral
                                                  .noOfChallengeCompleted
                                                  .toString())
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
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          width: screenWidth(context) * 0.28,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 20),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Badges',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                                Text(
                                                  'Collected',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        DescriptionTextWidget(
                                            description: viewModel
                                                .userGeneral.noOfBadges
                                                .toString())
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            width: screenWidth(context) * 0.28,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    'Latest',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                  Text(
                                                    'Badges',
                                                    maxLines: 1,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          viewModel.haveLastBadge
                                              ? Container(
                                                  height: 42,
                                                  width: 42,
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          viewModel.userGeneral
                                                              .lastBadge
                                                              .toString()),
                                                    ),
                                                  ),
                                                )
                                              : Container(
                                                  height: 42,
                                                  width: 42,
                                                  decoration: BoxDecoration(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                )
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
                    viewModel.isCurrentUser
                        ?
                        // * challenges list
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeaderTextWidget(lable: 'challenges'),
                              UpcomingChallengeStreamWidget(
                                stream: viewModel.getActiveUChallenge,
                              ),
                            ],
                          )
                        : Container(),
                    viewModel.isCurrentUser
                        ?
                        // * routines list
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              HeaderTextWidget(lable: 'routines'),
                              RoutinesStreamWidget(
                                stream: viewModel.getURoutines,
                              ),
                            ],
                          )
                        : Container(),
                    viewModel.isCurrentUser
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(10),
                            child: ButtonWidget(
                                onPressed: viewModel.pvpTapped, text: 'PvP'),
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
                                      description: viewModel
                                          .userGeneral.noOfFollowing
                                          .toString(),
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
                                      description: viewModel
                                          .userGeneral.noOfFollowers
                                          .toString(),
                                      bold: true,
                                      fontSize: 24,
                                    ),
                                    LableTextWidget(lable: 'Followers'),
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
                                // CardWidget(
                                //   onTap: () {},
                                //   child: Column(
                                //     mainAxisAlignment: MainAxisAlignment.end,
                                //     crossAxisAlignment:
                                //         CrossAxisAlignment.start,
                                //     children: [
                                //       DescriptionTextWidget(
                                //         description: viewModel
                                //             .userGeneral.noOfGroups
                                //             .toString(),
                                //         bold: true,
                                //         fontSize: 24,
                                //       ),
                                //       LableTextWidget(lable: 'Groups'),
                                //     ],
                                //   ),
                                //   height: 100,
                                //   width: screenWidth(context) * 0.45,
                                // ),
                                CardWidget(
                                  onTap: viewModel.likesTapped,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // DescriptionTextWidget(
                                      //   description: viewModel
                                      //       .userGeneral.noOfLikes
                                      //       .toString(),
                                      //   bold: true,
                                      //   fontSize: 24,
                                      // ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 5),
                                        child: Icon(
                                          FontAwesomeIcons.solidHeart,
                                          color: Theme.of(context).brightness ==
                                                  Brightness.light
                                              ? AppColors.lightGreen
                                              : AppColors.darkGreen,
                                        ),
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
                          verticalSpaceMedium(context),
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
