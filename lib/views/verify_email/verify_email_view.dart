import 'package:dotdo/shared/constant.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/widgets/dumb_widgets/button/button_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/description_text/description_text_widget.dart';
import 'package:dotdo/widgets/dumb_widgets/logo/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'verify_email_view_model.dart';

class VerifyEmailView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<VerifyEmailViewModel>.reactive(
      onModelReady: (VerifyEmailViewModel viewModel) =>
          viewModel.handleOnStartup(),
      builder:
          (BuildContext context, VerifyEmailViewModel viewModel, Widget _) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Verify Email'),
            shape: appBarShapeBorder,
          ),
          body: SafeArea(
            child: Center(
              child: viewModel.isBusy
                  ? CircularProgressIndicator()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // * LogoWidget
                        LogoWidget(
                          height: 80,
                          width: 80,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('Please verify your email'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('A verification email has been sent to:'),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: DescriptionTextWidget(
                              description: viewModel.currentUser.email),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: ButtonWidget(
                              onPressed: viewModel.checkVerification,
                              text: 'Check Verification'),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: ButtonWidget(
                            onPressed: viewModel.logout,
                            text: 'Logout',
                            backgroundColor: Theme.of(context).primaryColor,
                            textColor:
                                Theme.of(context).brightness == Brightness.light
                                    ? AppColors.darkBackground
                                    : null,
                          ),
                        ),
                      ],
                    ),
            ),
          ),
        );
      },
      viewModelBuilder: () => VerifyEmailViewModel(),
    );
  }
}
