import 'package:dotdo/shared/constant.dart';
import 'package:dotdo/views/login/login_view.dart';
import 'package:dotdo/views/register/register_view.dart';
import 'package:flutter/material.dart';
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
          body: SafeArea(
            child: PageView(
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
          ),
        );
      },
      viewModelBuilder: () => AuthpageViewModel(),
    );
  }
}
