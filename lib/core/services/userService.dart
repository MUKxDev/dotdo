import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
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
// * user profile --------------------
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

  // * user following/followers ---------------------
  Future addFollowing(String userID) async {
    String _uid = await _authService.getCurrentUserId();
    _firestoreService.users
        .doc(_uid)
        .collection('Following')
        .add({'ID': userID});

    _firestoreService.users
        .doc(userID)
        .collection('Followers')
        .add({'ID': _uid});
  }

  Future removeFollowing(String userID) async {
    String _uid = await _authService.getCurrentUserId();
    QuerySnapshot following = await _firestoreService.users
        .doc(_uid)
        .collection('Following')
        .where('ID', isEqualTo: userID)
        .get();

    QuerySnapshot followers = await _firestoreService.users
        .doc(userID)
        .collection('Followers')
        .where('ID', isEqualTo: _uid)
        .get();

    if (following.size > 0) {
      for (var item in following.docs) {
        await item.reference.delete();
      }
    }

    if (followers.size > 0) {
      for (var item in followers.docs) {
        await item.reference.delete();
      }
    }
  }

  Future updateNoOfF(String userID) async {
    String _uid = await _authService.getCurrentUserId();
    int noOfFollowers = await _firestoreService.users
        .doc(_uid)
        .collection('Followers')
        .get()
        .then((value) => value.size);

    await _firestoreService.users
        .doc(_uid)
        .collection('uGeneral')
        .doc('generalData')
        .update({'noOfFollowers': noOfFollowers});

    int noOfFollowing = await _firestoreService.users
        .doc(_uid)
        .collection('Following')
        .get()
        .then((value) => value.size);

    await _firestoreService.users
        .doc(_uid)
        .collection('uGeneral')
        .doc('generalData')
        .update({'noOfFollowing': noOfFollowing});

    _uid = userID;
    noOfFollowers = await _firestoreService.users
        .doc(_uid)
        .collection('Followers')
        .get()
        .then((value) => value.size);

    await _firestoreService.users
        .doc(_uid)
        .collection('uGeneral')
        .doc('generalData')
        .update({'noOfFollowers': noOfFollowers});

    noOfFollowing = await _firestoreService.users
        .doc(_uid)
        .collection('Following')
        .get()
        .then((value) => value.size);

    await _firestoreService.users
        .doc(_uid)
        .collection('uGeneral')
        .doc('generalData')
        .update({'noOfFollowing': noOfFollowing});
  }

  Future<bool> isFollowing(String userID) async {
    String _uid = await _authService.getCurrentUserId();
    QuerySnapshot following = await _firestoreService.users
        .doc(_uid)
        .collection('Following')
        .where('ID', isEqualTo: userID)
        .get();

    if (following.size > 0) {
      return true;
    } else {
      return false;
    }
  }

  Future<QuerySnapshot> getFollowing(String userID) async {
    return await _firestoreService.users
        .doc(userID)
        .collection('Following')
        .get();
  }

  Future<QuerySnapshot> getFollowers(String userID) async {
    return await _firestoreService.users
        .doc(userID)
        .collection('Followers')
        .get();
  }
}
