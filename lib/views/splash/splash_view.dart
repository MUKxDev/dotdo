import 'package:dotdo/svg/svg.dart';
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
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Theme.of(context).brightness == Brightness.light
                    ? Hero(
                        tag: '_logoSvgLight',
                        child: Container(
                          child: logoSvgLight,
                          height: 130,
                          width: 130,
                        ),
                      )
                    : Hero(
                        tag: '_logoSvgDark',
                        child: Container(
                          child: logoSvgDark,
                          height: 130,
                          width: 130,
                        ),
                      ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '.Do',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).accentColor,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => SplashViewModel(),
    );
  }
}
