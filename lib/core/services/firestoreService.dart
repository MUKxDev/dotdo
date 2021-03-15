import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // * References
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser({String uid, String fullName, String email}) {
    // Call the user's CollectionReference to add a new user
    return users
        .doc(uid)
        .set({
          'full_name': fullName,
          'email': email,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
