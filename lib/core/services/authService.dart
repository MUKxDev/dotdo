import 'package:cloud_firestore/cloud_firestore.dart';
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
    final result = await _firebaseAuthenticationService.createAccountWithEmail(
        email: email, password: password);

    if (result.hasError == false) {
      addUser(fullName: fullName, email: email);
    }

    return result;
  }

  // * to be moved
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser({String fullName, String email}) {
    // Call the user's CollectionReference to add a new user
    return users
        .add({
          'full_name': fullName,
          'email': email,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  void logout() {
    _firebaseAuthenticationService.logout();
  }
}
