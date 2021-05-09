import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/router_constants.dart';
import 'package:dotdo/core/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  Logger log;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool isEmailCorrect = false;
  bool isResetEmailCorrect = false;
  bool isPasswordCorrect = false;

  // TextEditingController resetPasswordEmail = TextEditingController(text: '');

  String validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) ||
        value == null ||
        emailController.text.trim() == '') {
      isEmailCorrect = false;
      return 'Enter a valid email address';
    } else {
      isEmailCorrect = true;
      return null;
    }
  }

  String validateResetEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) ||
        value == null ||
        restEmailController.text.trim() == '') {
      isResetEmailCorrect = false;
      return 'Enter a valid email address';
    } else {
      isResetEmailCorrect = true;
      return null;
    }
  }

  String validatePassword(String value) {
    if (passwordController.text.trim() == '') {
      isPasswordCorrect = false;
      return 'The passwords is empty';
    } else {
      isPasswordCorrect = true;
      return null;
    }
  }

  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController restEmailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');

  DialogService _dialogService = locator<DialogService>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  NavigationService _navigationService = locator<NavigationService>();
  AuthService _authService = locator<AuthService>();

  LoginViewModel() {
    log = getLogger(this.runtimeType.toString());
  }
  void toggleIsLodaing() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  void signinWithEmail() async {
    if (!(isEmailCorrect) || !(isPasswordCorrect)) {
      _snackbarService.showSnackbar(message: 'Please fill the required fields');
    } else {
      toggleIsLodaing();

      final result = await _authService.signinWithEmail(
          email: emailController.text.trim(),
          password: passwordController.text.trim());

      if (result.hasError) {
        toggleIsLodaing();
        _dialogService.showDialog(
          barrierDismissible: true,
          title: 'Error',
          description: result.errorMessage,
        );
      } else {
        toggleIsLodaing();
        print('Auth sign in with email');
        print('Result uid: ${result.user.uid}');

        _navigationService.pushNamedAndRemoveUntil(homeViewRoute);
      }
    }
  }

  Future<void> forgotPassword() async {
    if (!(isResetEmailCorrect)) {
      _snackbarService.showSnackbar(message: 'Please fill the required fields');
    } else {
      bool isSent = await _authService.passwordReset(restEmailController.text);
      if (isSent) {
        _snackbarService.showSnackbar(
            message: 'A password reset email has been sent.');
      } else {
        _snackbarService.showSnackbar(
            message: 'Could not send email with reset password link.');
      }
    }
  }

  // TODO: Implement authWithGoogle
  Future authWithGoogle() async {
    toggleIsLodaing();

    final result = await _authService.continueWithGoogle();

    if (result != null) {
      toggleIsLodaing();
      print('Auth continue with Google');
      print('Result uid: ${result.uid}');

      _navigationService.pushNamedAndRemoveUntil(homeViewRoute);
    } else {
      toggleIsLodaing();
      _dialogService.showDialog(
        barrierDismissible: true,
        title: 'Error',
        description: 'An Error happend',
      );
    }
  }

  // TODO: Implement authWithApple
  void authWithApple() {}
}
