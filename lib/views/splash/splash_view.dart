import 'package:dotdo/widgets/dumb_widgets/logo/logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'splash_view_model.dart';

class SplashView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<SplashViewModel>.reactive(
      onModelReady: (SplashViewModel viewmodel) => viewmodel.handelStartup(),
      builder: (BuildContext context, SplashViewModel viewModel, Widget _) {
        return Scaffold(
          body: Center(
            child: LogoWidget(
              height: 80,
              width: 80,
            ),
          ),
        );
      },
      viewModelBuilder: () => SplashViewModel(),
    );
  }
}
