import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/services/firestoreService.dart';

class SearchService {
  FirestoreService _firestoreService = locator<FirestoreService>();

  Stream<QuerySnapshot> usersStream(String text) async* {
    yield* _firestoreService.users
        .where('userName', isGreaterThanOrEqualTo: text)
        .where('userName', isLessThanOrEqualTo: text + '\uf8ff')
        .snapshots();
  }

  Stream<QuerySnapshot> gRoutineStream(String text) async* {
    yield* _firestoreService.groutiens
        .where('name', isGreaterThanOrEqualTo: text)
        .where('name', isLessThanOrEqualTo: text + '\uf8ff')
        .snapshots();
  }
}
