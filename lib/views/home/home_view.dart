import 'package:dotdo/shared/constant.dart';
import 'package:dotdo/views/discover/discover_view.dart';
import 'package:dotdo/views/profile/profile_view.dart';
import 'package:dotdo/views/social/social_view.dart';
import 'package:dotdo/views/today/today_view.dart';
import 'package:dotdo/widgets/dumb_widgets/bottom_nav_bar/bottom_nav_bar_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/header_text/header_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/logo/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'home_view_model.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
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
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextButton.icon(
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
                              TextButton.icon(
                                onPressed: () =>
                                    print('Implement navigation to setting'),
                                icon: Icon(
                                  Icons.settings,
                                  color: Theme.of(context).accentColor,
                                ),
                                label: HeaderTextWidget(
                                  lable: 'Settings',
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
            ),
          ),
          // * BottomNavigationBar
          bottomNavigationBar: BottomNavBarWidget(
            currentIndex: viewModel.selectedIndex,
            onTap: (index) {
              viewModel.updateSelectedNavbarItem(index);
            },
          ),
          // * FloatingActionButton
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              viewModel.addTask();
            },
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
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
