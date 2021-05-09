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

  RegisterViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  AuthService _authService = locator<AuthService>();

  TextEditingController userNameController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  TextEditingController confirmPasswordController =
      TextEditingController(text: '');

  bool isUsernameCorrect = false;
  bool isEmailCorrect = false;
  bool isPasswordCorrect = false;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String validateUsername(String value) {
    if (value.trim() == '') {
      isUsernameCorrect = false;
      return 'The userName is empty';
    } else {
      isUsernameCorrect = true;
      return null;
    }
  }

  String validateEmail(String value) {
    Pattern pattern =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]"
        r"{0,253}[a-zA-Z0-9])?)*$";
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value) ||
        value == null ||
        emailController.text == ''.trim()) {
      isEmailCorrect = false;
      return 'Enter a valid email address';
    } else {
      isEmailCorrect = true;
      return null;
    }
  }

  String validatePassword(String value) {
    if (passwordController.text != value || passwordController.text == '') {
      isPasswordCorrect = false;
      return 'The passwords are not matching';
    } else {
      isPasswordCorrect = true;
      return null;
    }
  }

  String replaceWhitespacesUsingRegex(String s, String replace) {
    if (s == null) {
      return null;
    }

    // This pattern means "at least one space, or more"
    // \\s : space
    // +   : one or more
    final pattern = RegExp('\\s+');
    return s.replaceAll(pattern, replace);
  }

  void toggleIsLodaing() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  void registerWithEmail() async {
    if (!(isUsernameCorrect) || !(isEmailCorrect) || !(isPasswordCorrect)) {
      _snackbarService.showSnackbar(message: 'Please fill the required fields');
    } else {
      if (!(isPasswordCorrect)) {
        _snackbarService.showSnackbar(message: 'Passwords does not match');
      } else {
        toggleIsLodaing();
        final result = await _authService.registerWithEmail(
            userName: replaceWhitespacesUsingRegex(
                userNameController.text.trim(), ''),
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
          print('Result uid: ${result.user.uid}');
          _navigationService.pushNamedAndRemoveUntil(homeViewRoute);
        }
      }
    }
  }
  // void registerWithEmail() async {
  //   if (userNameController.text.trim() == '' ||
  //       emailController.text == '' ||
  //       passwordController.text == '' ||
  //       confirmPasswordController.text == '') {
  //     _snackbarService.showSnackbar(message: 'Please fill the required fields');
  //   } else {
  //     if (passwordController.text != confirmPasswordController.text) {
  //       _snackbarService.showSnackbar(message: 'Passwords does not match');
  //     } else {
  //       toggleIsLodaing();
  //       final result = await _authService.registerWithEmail(
  //           userName: userNameController.text.trim(),
  //           email: emailController.text.trim(),
  //           password: passwordController.text.trim());

  //       if (result.hasError) {
  //         toggleIsLodaing();
  //         _dialogService.showDialog(
  //           barrierDismissible: true,
  //           title: 'Error',
  //           description: result.errorMessage,
  //         );
  //       } else {
  //         toggleIsLodaing();
  //         print('Auth create account with email');
  //         print('Result uid: ${result.uid}');
  //         _navigationService.pushNamedAndRemoveUntil(homeViewRoute);
  //       }
  //     }
  //   }
  // }

// TODO: Implement authWithGoogle
  void authWithGoogle() {}

  // TODO: Implement authWithApple
  void authWithApple() {}
}
