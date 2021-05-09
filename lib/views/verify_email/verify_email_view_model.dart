import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/router_constants.dart';
import 'package:dotdo/core/services/authService.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:firebase_auth/firebase_auth.dart';

class VerifyEmailViewModel extends BaseViewModel {
  Logger log;

  VerifyEmailViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  AuthService _authService = locator<AuthService>();
  NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();
  SnackbarService _snackbarService = locator<SnackbarService>();

  User _currentUser;
  User get currentUser => _currentUser;

  bool _isBusy;
  bool get isBusy => _isBusy;

  handleOnStartup() async {
    _isBusy = true;
    _currentUser = await _authService.getCurrentUser();
    await _currentUser.sendEmailVerification();
    _isBusy = false;
    notifyListeners();
  }

  checkVerification() async {
    await _currentUser.reload();
    _currentUser = await _authService.getCurrentUser();
    notifyListeners();
    if (_currentUser.emailVerified) {
      _navigationService.pushNamedAndRemoveUntil(homeViewRoute);
    } else {
      DialogResponse _dialogResponse =
          await _dialogService.showConfirmationDialog(
              title:
                  'Your email is not verified. Send verification email again?');
      if (_dialogResponse.confirmed) {
        _currentUser.sendEmailVerification();
        _snackbarService.showSnackbar(
            message: 'Email verification sent to: ${_currentUser.email}');
      }
    }
  }

  logout() {
    _authService.logout();
    _navigationService.pushNamedAndRemoveUntil(authpageViewRoute);
  }
}
