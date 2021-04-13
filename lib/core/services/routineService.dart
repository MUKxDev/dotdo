import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/models/Routine.dart';

import '../locator.dart';
import '../models/task.dart';
import 'authService.dart';
import 'firestoreService.dart';

class RoutineService {
  FirestoreService _firestoreService = locator<FirestoreService>();
  AuthService _authService = locator<AuthService>();

// *add - - - - - - - - - - - -
  Future<String> addRoutine(Routine routine) async {
    String routineId = await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutines')
        .add(routine.toMap())
        .then((value) {
      print('challenge with id ${value.id} added');
      return value.id;
    }).onError((error, stackTrace) {
      print('erorr with adding challenge: $error');
      return null;
    });
    startingpack(routineId);
    return routineId;
  }

  Future startingpack(String routineId) async {
    await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutines')
        .doc(routineId)
        .update({'noOfLikes': 0});

    await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutines')
        .doc(routineId)
        .update({'active': true});
  }

  Future<bool> activation(String routineId, bool currentStats) async {
    await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutiens')
        .doc(routineId)
        .update({'active': !(currentStats)});

    return !(currentStats);
  }

  Future<String> addURTask(String routineId, Task task) async {
    int _noOfTask = await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URotiens')
        .doc(routineId)
        .get()
        .then((value) => value.data()['noOfTask']);

    int _plusTask = _noOfTask + 1;

    String urtaskId = await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutiens')
        .doc(routineId)
        .collection('URTasks')
        .add(task.toMap())
        .then((value) async {
      _firestoreService.users
          .doc(await _authService.getCurrentUserId())
          .collection('URoutines')
          .doc(routineId)
          .update({'noOfTask': _plusTask});

      print('challenge with id ${value.id} added');
      return value.id;
    }).onError((error, stackTrace) {
      print('erorr with adding challenge: $error');
      return null;
    });
    return urtaskId;
  }

  Future toggleCompletedURTask(
      String taskId, String routineId, bool currentStat) async {
    int _noOfCompletedURTask = await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutines')
        .doc(routineId)
        .get()
        .then((value) => value.data()['noOfCompletedTask']);

    int _noOfTaskCompleted = await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('uGeneral')
        .doc('generalData')
        .get()
        .then((value) => value.data()['noOfTaskCompleted']);
//------------------------------
    int _plus = _noOfTaskCompleted + 1;
    int _minus = _noOfTaskCompleted - 1;
//------
    int _urtplus = _noOfCompletedURTask + 1;
    int _urtminus = _noOfCompletedURTask - 1;
//-------------------------------
    await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutines')
        .doc(routineId)
        .collection('URTasks')
        .doc(taskId)
        .update({'completed': !(currentStat)}).then((value) async {
      if (currentStat == false) {
        _firestoreService.users
            .doc(await _authService.getCurrentUserId())
            .collection("uGeneral")
            .doc('generalData')
            .update({'noOfTaskCompleted': _plus});
        _firestoreService.users
            .doc(await _authService.getCurrentUserId())
            .collection('URoutines')
            .doc(routineId)
            .update({'noOfCompletedTask': _urtplus});
      } else {
        _firestoreService.users
            .doc(await _authService.getCurrentUserId())
            .collection("uGeneral")
            .doc('generalData')
            .update({'noOfTaskCompleted': _minus});
        _firestoreService.users
            .doc(await _authService.getCurrentUserId())
            .collection('URoutines')
            .doc(routineId)
            .update({'noOfCompletedTask': _urtminus});
      }
    }).onError((error, stackTrace) {
      print('error with adding task: $error');
    });
  }

  Stream<QuerySnapshot> getURoutine() async* {
    yield* _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutiens')
        .snapshots();
  }

  Stream<QuerySnapshot> getURTask(String routineId) async* {
    yield* _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutiens')
        .doc(routineId)
        .collection('URTasks')
        .snapshots();
  }
}
