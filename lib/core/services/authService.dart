import 'dart:math';

import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/services/firestoreService.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';

import '../locator.dart';

class AuthService {
  User _user;
  User get user => _user;
  GoogleSignIn _googleSignIn = GoogleSignIn();

  final FirebaseAuthenticationService _firebaseAuthenticationService =
      locator<FirebaseAuthenticationService>();

  final FirestoreService _firestoreService = locator<FirestoreService>();

  final _firebaseAuth = FirebaseAuth.instance;

  Future<User> getCurrentUser() async {
    _user = _firebaseAuth.currentUser;
    return _user;
  }

  Future<String> getCurrentUserId() async {
    String _uid = _firebaseAuth.currentUser.uid;
    return _uid;
  }

  Future<bool> userExist() async {
    String _uid = _firebaseAuth.currentUser.uid;
    bool _isExists = await _firestoreService.users
        .doc(_uid)
        .get()
        .then((value) => value.exists);
    return _isExists;
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

  String generateHash() {
    String letters = 'abcdefghijklmnopqrstuvwxyz';
    String numbers = '0123456789';
    String hash = '#';

    final _rndL1 = Random();
    hash += letters[_rndL1.nextInt(letters.length)];
    final _rndL2 = Random();
    hash += letters[_rndL2.nextInt(letters.length)];
    final _rndL3 = Random();
    hash += letters[_rndL3.nextInt(letters.length)];

    final _rndN1 = Random();
    hash += numbers[_rndN1.nextInt(numbers.length)];
    final _rndN2 = Random();
    hash += numbers[_rndN2.nextInt(numbers.length)];
    final _rndN3 = Random();
    hash += numbers[_rndN3.nextInt(numbers.length)];
    print(hash);
    return hash;
  }

  Future<String> checkUsername(String username) async {
    String userNameWithHash = '';
    bool _available = false;

    while (_available == false) {
      userNameWithHash = username.toLowerCase() + generateHash();
      _available = await _firestoreService.userNameAvailable(userNameWithHash);
      _available = true;
    }

    return userNameWithHash;
  }

  Future<FirebaseAuthenticationResult> registerWithEmail(
      {String userName, String email, String password}) async {
    final result = await _firebaseAuthenticationService.createAccountWithEmail(
        email: email, password: password);
    String userNameWithHash = await checkUsername(userName);
    print(userNameWithHash);
    if (result.hasError == false) {
      _firestoreService.createUser(
          uid: result.user.uid, userName: userNameWithHash, email: email);
    }

    return result;
  }

  void logout() {
    _firebaseAuthenticationService.logout();
  }

  Future<bool> passwordReset(String email) async {
    return await _firebaseAuthenticationService.sendResetPasswordLink(email);
  }

  continueWithApple() {}

  Future<User> continueWithGoogle() async {
    GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: _googleAuth.accessToken, idToken: _googleAuth.idToken);

    UserCredential userCredential =
        await _firebaseAuth.signInWithCredential(credential);

    // final result = await _firebaseAuthenticationService.signInWithGoogle();
    bool isSignedIn = await _googleSignIn.isSignedIn();
    if (isSignedIn) {
      User user = userCredential.user;
      String userNameWithHash = await checkUsername(user.displayName);
      print(userNameWithHash);
      _firestoreService.createUser(
          uid: user.uid,
          email: user.email,
          userName: userNameWithHash,
          avatar: user.photoURL);
    }
    return userCredential.user;
  }
}
