import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

class AuthService {
  User _user;
  User get user => _user;
  Future createNewAccount(
      {@required String email, @required String password}) async {
    final result = await FirebaseAuthenticationService().createAccountWithEmail(
      email: email,
      password: password,
    );
    if (result.hasError) {
      print(result.errorMessage);
      return result.errorMessage;
    }
    print('Auth create account with email');
    print('Result uid: ${result.uid}');
    return result;
  }

  Future signInWithEmail(
      {@required String email, @required String password}) async {
    final result = await FirebaseAuthenticationService().loginWithEmail(
      email: email,
      password: password,
    );
    if (result.hasError) {
      print(result.errorMessage);
      return result;
      // return result.errorMessage;
    }
    print('Auth sign in with email');
    print('Result uid: ${result.uid}');
    return result;
  }

  final _firebaseAuth = FirebaseAuth.instance;

  Future getCurrentUser() async {
    _user = _firebaseAuth.currentUser;
  }
}
