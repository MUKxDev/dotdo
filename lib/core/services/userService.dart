import 'dart:io';

import 'package:dotdo/core/models/User.dart';
import 'package:dotdo/core/models/uGeneral.dart';
import 'package:dotdo/core/services/authService.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

import '../locator.dart';
import 'firestoreService.dart';

class UserService {
  FirestoreService _firestoreService = locator<FirestoreService>();
  AuthService _authService = locator<AuthService>();
  firebase_storage.Reference ref =
      firebase_storage.FirebaseStorage.instance.ref('/userImage');

  Future<String> uploadAnImage(
      {@required File image, @required String uid}) async {
    firebase_storage.Reference reference = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('usersImages/$uid/userImage.png');

    firebase_storage.UploadTask uploadTask = reference.putFile(image);

    firebase_storage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(
        () => print('Image has been uploded to firebase Storage'));

    String _imageUrl = await taskSnapshot.ref.getDownloadURL();
    print(_imageUrl);
    return _imageUrl;
  }

  Future<User> getUserProfile(String userId) async {
    User user;
    await _firestoreService.users
        .doc(userId)
        .get()
        .then((value) => user = User.fromMap(value.data()));
    return user;
  }

  Future<UGeneral> getUserGeneral(String userId) async {
    UGeneral uGeneral;
    await _firestoreService.users
        .doc(userId)
        .collection('uGeneral')
        .doc('generalData')
        .get()
        .then((value) => uGeneral = UGeneral.fromMap(value.data()));

    return uGeneral;
  }

  Future updateUserProfilePicture(String userId, String imageUrl) async {
    await _firestoreService.users.doc(userId).update({'profilePic': imageUrl});
  }

  Future updateUserName(String userId, String userName) async {
    String _userNameWithHash;
    _userNameWithHash = await _authService.checkUsername(userName);

    await _firestoreService.users
        .doc(userId)
        .update({'userName': _userNameWithHash});
  }
}
