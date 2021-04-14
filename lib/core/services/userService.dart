import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';

class UserService {
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
}
