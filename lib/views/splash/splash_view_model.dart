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

  final NavigationService _navigationService = locator<NavigationService>();

  Future navigateToLogin() async {
    _navigationService.pushNamedAndRemoveUntil(loginViewRoute);
  }

  Future navigateToToday() async {
    _navigationService.pushNamedAndRemoveUntil(todayViewRoute);
  }

  Future handelStartup() async {
    Timer(
      Duration(seconds: 2),
      () {
        if (FirebaseAuthenticationService().hasUser) {
          navigateToToday();
        } else {
          navigateToLogin();
        }
      },
    );
  }
}
