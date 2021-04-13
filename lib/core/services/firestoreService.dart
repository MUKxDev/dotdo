import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/models/User.dart';
import 'package:dotdo/core/models/uGeneral.dart';

class FirestoreService {
  // * References
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  // ? methods
  Future<void> createUser({String uid, String userName, String email}) {
    User user = User(
      userName: userName,
      email: email,
      dots: 0,
      profilePic:
          'https://cdn.business2community.com/wp-content/uploads/2017/08/blank-profile-picture-973460_640.png',
    );
    // Call the user's CollectionReference to add a new user
    return users.doc(uid).set(user.toMap()).then((value) => setUGeneral(uid)
        .catchError((error) => print("Failed to add user: $error")));
  }

  Future setUGeneral(String uid) async {
    UGeneral uGeneral = UGeneral(
        noOfFollowers: 0,
        noOfFollowing: 0,
        noOfGroups: 0,
        noOfBadges: 0,
        noOfTaskCompleted: 0,
        noOfLikes: 0,
        noOfChallengeCompleted: 0,
        lastBadge: "");
    users
        .doc(uid)
        .collection('uGeneral')
        .doc('generalData')
        .set(uGeneral.toMap());
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
