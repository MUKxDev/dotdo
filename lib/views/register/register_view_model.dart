import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/router_constants.dart';
import 'package:dotdo/core/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class RegisterViewModel extends BaseViewModel {
  Logger log;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) || value == null)
      return 'Enter a valid email address';
    else
      return null;
  }

  String validatePassword(String value) {
    if (passwordController.text != value)
      return 'The passwords are not matching';
    else
      return null;
  }

  TextEditingController userNameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController confirmPasswordController =
      TextEditingController(text: '');

  NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  AuthService _authService = locator<AuthService>();

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
        final result = await _authService.registerWithEmail(
            userName: userNameController.text.trim(),
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
          print('Auth create account with email');
          print('Result uid: ${result.uid}');
          _navigationService.pushNamedAndRemoveUntil(homeViewRoute);
        }
      }
    }
  }

// TODO: Implement authWithGoogle
  void authWithGoogle() {}

  // TODO: Implement authWithApple
  void authWithApple() {}
}
