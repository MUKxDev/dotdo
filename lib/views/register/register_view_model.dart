import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/router_constants.dart';
import 'package:dotdo/core/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterViewModel extends BaseViewModel {
  Logger log;
  String _email = '';
  String get email => _email;
  String _password = '';
  String get password => _password;
  String _confirmPassword = '';
  String get confirmPassword => _password;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  TextEditingController emailController = TextEditingController(text: '');

  AuthService _authService = locator<AuthService>();
  NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();
  SnackbarService _snackbarService = locator<SnackbarService>();

  RegisterViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  void updateEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    _password = value;
    notifyListeners();
  }

  void updateConfirmPassword(String value) {
    _confirmPassword = value;
    notifyListeners();
  }

  void toggleIsLodaing() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  // ! Make sure which one is better from AuthService or directly
  // ? This is directly from FirebaseAuthenticationService() package.
  void navigateToLogin() async {
    _navigationService.back();
  }

  // ? old sign in from AuthService
  // void signinWithEmail() {
  //   _authService.signInWithEmail(email: email, password: password);
  // }

  void signupWithEmail() async {
    if (_password == _confirmPassword) {
      final result = await FirebaseAuthenticationService()
          .createAccountWithEmail(
              email: emailController.text, password: password);

      print(emailController.text);
      print(result.uid);
    } else {
      print('The password not Matched');
    }
  }

  void registerWithEmail() async {
    if (_email == '' || _password == '' || _confirmPassword == '') {
      _snackbarService.showSnackbar(message: 'Please fill the required fields');
    } else {
      if (_password != _confirmPassword) {
        _snackbarService.showSnackbar(message: 'Passwords does not match');
      } else {
        toggleIsLodaing();
        final result = await FirebaseAuthenticationService()
            .createAccountWithEmail(email: email, password: password);

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
          _navigationService.pushNamedAndRemoveUntil(
            todayViewRoute,
            // arguments: {1: result.uid},
          );
        }
      }
    }
  }
}
