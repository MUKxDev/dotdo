import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/router_constants.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class LoginViewModel extends BaseViewModel {
  Logger log;
  String _email = '';
  String get email => _email;
  String _password = '';
  String get password => _password;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // AuthService _authService = locator<AuthService>();
  DialogService _dialogService = locator<DialogService>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  NavigationService _navigationService = locator<NavigationService>();

  LoginViewModel() {
    log = getLogger(this.runtimeType.toString());
  }

  void updateEmail(String value) {
    _email = value;
    notifyListeners();
  }

  void updatePassword(String value) {
    _password = value;
    notifyListeners();
  }

  void toggleIsLodaing() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  // ! Make sure which one is better from AuthService or directly
  // TODO: try putting FirebaseAuthenticationService in the locator to make the third option.
  // ? This is directly from FirebaseAuthenticationService() package.
  void signinWithEmail() async {
    if (_email == '' || _password == '') {
      _snackbarService.showSnackbar(message: 'Please fill the required fields');
    } else {
      toggleIsLodaing();
      final result = await FirebaseAuthenticationService()
          .loginWithEmail(email: email, password: password);

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
        print('Result uid: ${result.uid}');
        _navigationService.pushNamedAndRemoveUntil(
          todayViewRoute,
          // arguments: {1: result.uid},
        );
      }
    }
  }

  // ? old sign in from AuthService
  // void signinWithEmail() {
  //   _authService.signInWithEmail(email: email, password: password);
  // }

  // void signupWithEmail() {
  //   _authService.createNewAccount(email: email, password: password);
  // }

  void navigateToRegister() {
    _navigationService.navigateTo(registerViewRoute);
  }
}
