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
}
