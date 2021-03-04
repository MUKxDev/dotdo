import 'package:dotdo/constant.dart';
import 'package:dotdo/views/login/login_view.dart';
import 'package:dotdo/views/register/register_view.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:stacked/stacked.dart';
import 'authpage_view_model.dart';

class AuthpageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<AuthpageViewModel>.reactive(
      builder: (BuildContext context, AuthpageViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(
            shape: appBarShapeBorder,
            title: Text(viewModel.title),
          ),
          body: PageView(
            controller: viewModel.pageController,
            onPageChanged: (index) => viewModel.updatePageIndex(index),
            children: [
              LoginView(
                navigateToIndex: () => viewModel.navigateToIndex(1),
              ),
              RegisterView(
                navigateToIndex: () => viewModel.navigateToIndex(0),
              ),
            ],
          ),
          // * SmoothPageIndicator
          bottomNavigationBar: Container(
            width: double.infinity,
            height: 80,
            color: Theme.of(context).scaffoldBackgroundColor,
            child: Column(
              children: [
                Center(
                  child: SmoothPageIndicator(
                    onDotClicked: (index) => viewModel.navigateToIndex(index),
                    controller: viewModel.pageController,
                    count: 2,
                    effect: WormEffect(
                      dotHeight: 15,
                      dotWidth: 15,
                      dotColor: Theme.of(context).primaryColor,
                      activeDotColor: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => AuthpageViewModel(),
    );
  }
}
