import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // * References
  CollectionReference users = FirebaseFirestore.instance.collection('users');
  // ? methods
  Future<void> createUser({String uid, String userName, String email}) {
    // Call the user's CollectionReference to add a new user
    return users
        .doc(uid)
        .set({
          'userName': userName,
          'email': email,
          'karma': 0,
          'profilePic': ''
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<bool> userNameAvailable(String userName) async {
    bool available =
        await users.where('userName', isEqualTo: userName).get().then((value) {
      if (value.docs.isEmpty) {
        return true;
      } else {
        return false;
      }
    });
    return available;
  }
}
