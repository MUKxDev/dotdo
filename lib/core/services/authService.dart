import 'package:dotdo/core/locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

class AuthService {
  User _user;
  User get user => _user;

  final FirebaseAuthenticationService _firebaseAuthenticationService =
      locator<FirebaseAuthenticationService>();

  final _firebaseAuth = FirebaseAuth.instance;

  Future getCurrentUser() async {
    _user = _firebaseAuth.currentUser;
  }

  Future<String> getCurrentUserId() async {
    String _uid = _firebaseAuth.currentUser.uid;
    return _uid;
  }

  Future<bool> get hasUser async {
    // Future<bool> has = await _firebaseAuthenticationService.hasUser;
    // return _firebaseAuthenticationService.hasUser;
    bool hasUser = _firebaseAuth.currentUser != null;
    return hasUser;
  }

  Future<FirebaseAuthenticationResult> signinWithEmail(
      {String email, String password}) async {
    return _firebaseAuthenticationService.loginWithEmail(
        email: email, password: password);
  }

  // TODO: Implement using fullName
  Future<FirebaseAuthenticationResult> registerWithEmail(
      {String fullName, String email, String password}) async {
    return _firebaseAuthenticationService.createAccountWithEmail(
        email: email, password: password);
  }

  void logout() {
    _firebaseAuthenticationService.logout();
  }
}
