import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/models/Routine.dart';

import '../locator.dart';
import 'authService.dart';
import 'firestoreService.dart';

class GRoutine {
  FirestoreService _firestoreService = locator<FirestoreService>();
  AuthService _authService = locator<AuthService>();

  Stream<QuerySnapshot> getAllGRoutine() async* {
    yield* _firestoreService.groutiens
        .orderBy('noOfLikes', descending: true)
        .snapshots();
  }

  Future<Routine> getGRoutine(String gRoutineId) async {
    return await _firestoreService.groutiens
        .doc(gRoutineId)
        .get()
        .then((value) {
      Routine _routine = Routine.fromMap(value.data());
      return _routine;
    }).onError((error, stackTrace) {
      print('An error has occurred: $error');
      return null;
    });
  }

  Future<DocumentSnapshot> getGRoutineDoc(String gRoutineId) async {
    return await _firestoreService.groutiens.doc(gRoutineId).get();
  }

  Stream<DocumentSnapshot> getGRoutineStream(String gRoutineId) async* {
    yield* _firestoreService.groutiens.doc(gRoutineId).snapshots();
  }

  Stream<QuerySnapshot> getGRTasks(String gRoutineId) async* {
    yield* _firestoreService.groutiens
        .doc(gRoutineId)
        .collection('GRTasks')
        .snapshots();
  }

  Stream<QuerySnapshot> getUGRoutine() async* {
    String _userId = await _authService.getCurrentUserId();
    yield* _firestoreService.users
        .doc(_userId)
        .collection('URoutines')
        .where('publicRoutine', isEqualTo: true)
        .snapshots();
  }

  Future<QuerySnapshot> getLikedRoutiens(String uid) async {
    // String _userId = await _authService.getCurrentUserId();
    return await _firestoreService.users
        .doc(uid)
        .collection('likesRoutine')
        .get()
        .then((value) => value)
        .onError((error, stackTrace) => null);
  }

  Future toggleLike(String gRoutineId) async {
    String rID = await _firestoreService.groutiens
        .doc(gRoutineId)
        .get()
        .then((value) => value.data()['routineId']);
    String _userId = await _authService.getCurrentUserId();
    String creatorId = await _firestoreService.groutiens
        .doc(gRoutineId)
        .get()
        .then((value) => value.data()['creatorId']);
    int _noOfLikes = await _firestoreService.groutiens
        .doc(gRoutineId)
        .get()
        .then((value) => value.data()['noOfLikes']);
    int noOfLike = await _firestoreService.users
        .doc(_userId)
        .collection('likesRoutine')
        .where('gRoutineId', isEqualTo: gRoutineId)
        .get()
        .then((value) => value.size);
    bool status;
    if (noOfLike == 0 || noOfLike == null)
      status = false;
    else
      status = true;

    int _plus = _noOfLikes + 1;
    int _minus = _noOfLikes - 1;

    if (status == false) {
      _firestoreService.groutiens.doc(gRoutineId).update({'noOfLikes': _plus});
      _firestoreService.users
          .doc(creatorId)
          .collection('URoutines')
          .doc(rID)
          .update({'noOfLikes': _plus});
      _firestoreService.users
          .doc(_userId)
          .collection('likesRoutine')
          .add({'gRoutineId': gRoutineId});
    } else {
      _firestoreService.groutiens.doc(gRoutineId).update({'noOfLikes': _minus});
      _firestoreService.users
          .doc(creatorId)
          .collection('URoutines')
          .doc(rID)
          .update({'noOfLikes': _minus});
      String likeId = await _firestoreService.users
          .doc(_userId)
          .collection('likesRoutine')
          .where('gRoutineId', isEqualTo: gRoutineId)
          .get()
          .then((value) => value.docs.first.id);

      _firestoreService.users
          .doc(_userId)
          .collection('likesRoutine')
          .doc(likeId)
          .delete();
    }
  }

  Future<bool> isAddedGRoutine(String groutineId) async {
    bool status;
    int noOfFound = await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutines')
        .where('groutineId', isEqualTo: groutineId)
        .get()
        .then((value) => value.size);

    if (noOfFound == 0 || noOfFound == null)
      status = false;
    else
      status = true;

    return status;
  }

  Future saveGRoutine(String gRoutine) async {
    String _userId = await _authService.getCurrentUserId();
    Map _pRoutien = await _firestoreService.groutiens
        .doc(gRoutine)
        .get()
        .then((value) => value.data());

    String routineId = await _firestoreService.users
        .doc(_userId)
        .collection('URoutines')
        .add(_pRoutien)
        .then((value) => value.id);
    toggleRTask(routineId, gRoutine);

    await _firestoreService.users
        .doc(_userId)
        .collection('URoutines')
        .doc(routineId)
        .update(
            {'publicRoutine': false, 'noOfLikes': 0, 'noOfCompletedTasks': 0});

    return routineId;
  }

  Future toggleRTask(String routineId, String groutineId) async {
    String _userId = await _authService.getCurrentUserId();
    int _noOfTasks = await _firestoreService.groutiens
        .doc(groutineId)
        .get()
        .then((value) => value.data()['noOfTasks']);
    for (var i = 0; i < _noOfTasks; i++) {
      Map _pRTask = await _firestoreService.groutiens
          .doc(groutineId)
          .collection('GRTasks')
          .get()
          .then((value) => value.docs.elementAt(i).data());

      _pRTask['completed'] = false;

      await _firestoreService.users
          .doc(_userId)
          .collection('URoutines')
          .doc(routineId)
          .collection('URTasks')
          .add(_pRTask);
    }
  }

  Future<bool> getLikeStatus(String gRoutineId) async {
    String _userId = await _authService.getCurrentUserId();
    int noOfLike = await _firestoreService.users
        .doc(_userId)
        .collection('likesRoutine')
        .where('gRoutineId', isEqualTo: gRoutineId)
        .get()
        .then((value) => value.size);
    bool status;
    if (noOfLike == 0 || noOfLike == null)
      status = false;
    else
      status = true;

    return status;
  }

  Future<int> getNumberOfLikes(String uid) async {
    // String _userId = await _authService.getCurrentUserId();
    int noOfLike = await _firestoreService.users
        .doc(uid)
        .collection('likesRoutine')
        .get()
        .then((value) => value.size);

    return noOfLike;
  }
}
