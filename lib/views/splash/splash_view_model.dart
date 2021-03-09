import 'dart:async';
import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/router_constants.dart';
import 'package:dotdo/core/services/authService.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class SplashViewModel extends BaseViewModel {
  Logger log;

  SplashViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  NavigationService _navigationService = locator<NavigationService>();
  AuthService _authService = locator<AuthService>();

  Future navigateToAuthPage() async {
    _navigationService.pushNamedAndRemoveUntil(authpageViewRoute);
  }

  Future navigateToHome() async {
    _navigationService.pushNamedAndRemoveUntil(homeViewRoute);
  }

  Future handelStartup() async {
    if (await _authService.hasUser) {
      navigateToHome();
    } else {
      navigateToAuthPage();
    }
  }
}
