import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/router_constants.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterViewModel extends BaseViewModel {
  Logger log;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController confirmPasswordController =
      TextEditingController(text: '');

  NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  FirebaseAuthenticationService _authenticationService =
      locator<FirebaseAuthenticationService>();

  RegisterViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  void toggleIsLodaing() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  void registerWithEmail() async {
    if (emailController.text == '' ||
        passwordController.text == '' ||
        confirmPasswordController.text == '') {
      _snackbarService.showSnackbar(message: 'Please fill the required fields');
    } else {
      if (passwordController.text != confirmPasswordController.text) {
        _snackbarService.showSnackbar(message: 'Passwords does not match');
      } else {
        toggleIsLodaing();
        final result = await _authenticationService.createAccountWithEmail(
            email: emailController.text, password: passwordController.text);

        if (result.hasError) {
          toggleIsLodaing();
          _dialogService.showDialog(
            barrierDismissible: true,
            title: 'Error',
            description: result.errorMessage,
          );
        } else {
          toggleIsLodaing();
          print('Auth create account with email');
          print('Result uid: ${result.uid}');
          _navigationService.pushNamedAndRemoveUntil(homeViewRoute);
        }
      }
    }
  }
}
