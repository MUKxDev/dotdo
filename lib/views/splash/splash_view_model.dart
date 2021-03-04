import 'dart:async';

import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/router_constants.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends BaseViewModel {
  Logger log;

  SplashViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  NavigationService _navigationService = locator<NavigationService>();
  FirebaseAuthenticationService _authenticationService =
      locator<FirebaseAuthenticationService>();

  Future navigateToAuthPage() async {
    _navigationService.pushNamedAndRemoveUntil(authpageViewRoute);
  }

  Future navigateToHome() async {
    _navigationService.pushNamedAndRemoveUntil(homeViewRoute);
  }

  Future handelStartup() async {
    // TODO: Remove this timer after you implement the proper splash screen
    Timer(
      Duration(seconds: 2),
      () {
        if (_authenticationService.hasUser) {
          navigateToHome();
        } else {
          navigateToAuthPage();
        }
      },
    );
  }
}
