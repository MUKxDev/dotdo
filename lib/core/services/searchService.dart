import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/services/firestoreService.dart';

class SearchService {
  FirestoreService _firestoreService = locator<FirestoreService>();

  Stream<QuerySnapshot> searchBar(String text) async* {
    yield* _firestoreService.users
        .where('userName', isEqualTo: text)
        .snapshots();
  }

  Stream<QuerySnapshot> usersStream(String text) async* {
    yield* _firestoreService.users
        .where('userName', isGreaterThanOrEqualTo: text)
        .snapshots();
  }

  Future<String> searchBarF(String text) async {
    return _firestoreService.users
        .where('userName', isEqualTo: text)
        .get()
        .then((value) {
      String id;
      if (value.docs.isNotEmpty) {
        if (value.docs.first.exists) {
          id = value.docs.first.id;
        }
      }
      return id;
    });
  }
}
