import 'package:dotdo/shared/constant.dart';
import 'package:dotdo/shared/ui_helpers.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/views/discover/discover_view.dart';
import 'package:dotdo/views/profile/profile_view.dart';
import 'package:dotdo/views/social/social_view.dart';
import 'package:dotdo/views/today/today_view.dart';
import 'package:dotdo/widgets/dumb_widgets/bottom_nav_bar/bottom_nav_bar_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/header_text/header_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/logo/logo_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/user_card/user_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:stacked/stacked.dart';
import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      onModelReady: (HomeViewModel viewModel) => viewModel.handleOnStartup(),
      builder: (BuildContext context, HomeViewModel viewModel, Widget _) {
        return Scaffold(
          // * AppBar
          appBar:
              AppBar(shape: appBarShapeBorder, title: Text(viewModel.title)),
          // * Drawer
          drawer: SafeArea(
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(40),
                bottomRight: Radius.circular(40),
              ),
              child: Drawer(
                child: Container(
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LogoWidget(
                        height: 80,
                        width: 80,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 10, bottom: 10),
                          child: Container(
                            width: screenWidth(context),
                            decoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(30),
                                  bottomRight: Radius.circular(30),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: DescriptionTextWidget(
                                              description:
                                                  'You are signed in as')),
                                      UserCardWidget(
                                        user: viewModel.user,
                                      ),
                                    ],
                                  ),
                                  verticalSpaceMedium(context),
                                  TextButton.icon(
                                    style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Theme.of(context).primaryColor),
                                      minimumSize:
                                          MaterialStateProperty.all<Size>(
                                              Size.fromHeight(50)),
                                    ),
                                    onPressed: viewModel.logout,
                                    icon: Icon(
                                      Icons.logout,
                                      color: Theme.of(context).accentColor,
                                    ),
                                    label: HeaderTextWidget(
                                      lable: 'Logout',
                                    ),
                                  ),
                                  // TODO: Implement navigation to setting
                                  // TextButton.icon(
                                  //   onPressed: () =>
                                  //       print('Implement navigation to setting'),
                                  //   icon: Icon(
                                  //     Icons.settings,
                                  //     color: Theme.of(context).accentColor,
                                  //   ),
                                  //   label: HeaderTextWidget(
                                  //     lable: 'Settings',
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          // * BottomNavigationBar
          bottomNavigationBar: BottomNavBarWidget(
            userProfile: viewModel.userProfilePic,
            currentIndex: viewModel.selectedIndex,
            onTap: (index) {
              viewModel.updateSelectedNavbarItem(index);
            },
          ),
          floatingActionButton: SpeedDial(
            icon: Icons.add,
            foregroundColor: AppColors.white,
            backgroundColor: Theme.of(context).accentColor,
            children: [
              SpeedDialChild(
                label: 'Add Task',
                onTap: viewModel.addTask,
                backgroundColor: Theme.of(context).primaryColor,
                foregroundColor:
                    Theme.of(context).brightness == Brightness.light
                        ? AppColors.darkBackground.withAlpha(170)
                        : AppColors.white.withAlpha(200),
                child: Icon(
                  FontAwesomeIcons.clipboardCheck,
                  size: 20,
                ),
              ),
              SpeedDialChild(
                label: 'Add Routine',
                onTap: viewModel.addRoutine,
                backgroundColor:
                    Theme.of(context).brightness == Brightness.light
                        ? AppColors.lightRoutine
                        : AppColors.darkRoutine,
                foregroundColor:
                    Theme.of(context).brightness == Brightness.light
                        ? AppColors.darkBackground.withAlpha(170)
                        : AppColors.white.withAlpha(200),
                child: Icon(
                  FontAwesomeIcons.redoAlt,
                  size: 20,
                ),
              ),
              SpeedDialChild(
                label: 'Add Challenge',
                onTap: viewModel.addChallenge,
                backgroundColor:
                    Theme.of(context).brightness == Brightness.light
                        ? AppColors.lightChallenge
                        : AppColors.darkChallenge,
                foregroundColor:
                    Theme.of(context).brightness == Brightness.light
                        ? AppColors.darkBackground.withAlpha(170)
                        : AppColors.white.withAlpha(200),
                child: Icon(
                  FontAwesomeIcons.crosshairs,
                  size: 20,
                ),
              ),
            ],
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,

          // * PageView
          body: PageView(
            onPageChanged: (index) => viewModel.updateSelectedIndex(index),
            controller: viewModel.pageController,
            children: [
              TodayView(),
              SocialView(),
              DiscoverView(),
              ProfileView(),
            ],
          ),
        );
      },
      viewModelBuilder: () => HomeViewModel(),
    );
  }
}
