import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/models/Routine.dart';

import '../locator.dart';
import '../models/task.dart';
import 'authService.dart';
import 'firestoreService.dart';

class RoutineService {
  FirestoreService _firestoreService = locator<FirestoreService>();
  AuthService _authService = locator<AuthService>();

  // add -----------------
  Future<String> addRoutine(Routine routine) async {
    String routineId = await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutines')
        .add(routine.toMap())
        .then((value) {
      print('routine with id ${value.id} added');
      return value.id;
    }).onError((error, stackTrace) {
      print('erorr with adding routine: $error');
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

  // Get -----------------
  Future<bool> activation(String routineId, bool currentStats) async {
    await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutines')
        .doc(routineId)
        .update({'active': !(currentStats)});

    return !(currentStats);
  }

  Future<String> addURTask(String routineId, Task task) async {
    int _noOfTasks = await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutines')
        .doc(routineId)
        .get()
        .then((value) => value.data()['noOfTasks']);

    int _plusTask = _noOfTasks + 1;

    String urtaskId = await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutines')
        .doc(routineId)
        .collection('URTasks')
        .add(task.toMap())
        .then((value) async {
      _firestoreService.users
          .doc(await _authService.getCurrentUserId())
          .collection('URoutines')
          .doc(routineId)
          .update({'noOfTasks': _plusTask});

      print('routine with id ${value.id} added');
      return value.id;
    }).onError((error, stackTrace) {
      print('erorr with adding routine: $error');
      return null;
    });
    return urtaskId;
  }

  Stream<QuerySnapshot> getAllURoutines() async* {
    yield* _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutines')
        .snapshots();
  }

  Stream<QuerySnapshot> getActiveURoutines() async* {
    yield* _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutines')
        .where('active', isEqualTo: true)
        .snapshots();
  }

  Stream<DocumentSnapshot> getURoutineStream(String routineId) async* {
    yield* _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutines')
        .doc(routineId)
        .snapshots();
  }

  Future<Routine> getURoutine(String routineId) async {
    return await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutines')
        .doc(routineId)
        .get()
        .then((value) {
      Routine _routine = Routine.fromMap(value.data());
      return _routine;
    }).onError((error, stackTrace) {
      print('An error has occurred: $error');
      return null;
    });
  }

  Stream<QuerySnapshot> getURTasks(String routineId) async* {
    yield* _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutines')
        .doc(routineId)
        .collection('URTasks')
        .snapshots();
  }

  Future<Task> getURTask(String routineId, String taskId) async {
    String _userId = await _authService.getCurrentUserId();
    return _firestoreService.users
        .doc(_userId)
        .collection('URoutines')
        .doc(routineId)
        .collection('URTasks')
        .doc(taskId)
        .get()
        .then((value) {
      Task _task = Task.fromMap(value.data());
      return _task;
    }).onError((error, stackTrace) {
      print('An error has occurred: $error');
      return null;
    });
  }

  // Delete -------------------
  Future deleteRTask(String routineId, String taskId) async {
    bool currentSatuts = await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutines')
        .doc(routineId)
        .collection('URTasks')
        .doc(taskId)
        .get()
        .then((value) => value.data()['completed']);

    int _noOfTask = await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutines')
        .doc(routineId)
        .get()
        .then((value) => value.data()['noOfTasks']);
    int _noOfCompletedURTask = await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutines')
        .doc(routineId)
        .get()
        .then((value) => value.data()['noOfCompletedTasks']);
    int _minusTask = _noOfTask + -1;
    int _urtminus = _noOfCompletedURTask - 1;
    _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutines')
        .doc(routineId)
        .collection('URTasks')
        .doc(taskId)
        .delete();

    _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection("uGeneral")
        .doc('generalData')
        .update({'noOfTaskCompleted': _minusTask});
    if (currentSatuts == true) {
      _firestoreService.users
          .doc(await _authService.getCurrentUserId())
          .collection('URoutines')
          .doc(routineId)
          .update({'noOfCompletedTasks': _urtminus});
    }
  }

  Future deleteRoutine(String routineId) async {
    _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutines')
        .doc(routineId)
        .delete();
  }

// update -------------------
  Future toggleCompletedURTask(
      String taskId, String routineId, bool currentStat) async {
    int _noOfCompletedURTask = await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutines')
        .doc(routineId)
        .get()
        .then((value) => value.data()['noOfCompletedTasks']);

    int _noOfCTaskCompleted = await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('uGeneral')
        .doc('generalData')
        .get()
        .then((value) => value.data()['noOfTaskCompleted']);
//------------------------------
    int _plus = _noOfCTaskCompleted + 1;
    int _minus = _noOfCTaskCompleted - 1;
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
            .update({'noOfCompletedTasks': _urtplus});
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
            .update({'noOfCompletedTasks': _urtminus});
      }
    }).onError((error, stackTrace) {
      print('error with adding task: $error');
    });
  }

  Future updateRotine(Routine routine, String routineId) async {
    await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutines')
        .doc(routineId)
        .update(routine.toMap());
  }

  Future updateRTask(Task task, String routineId, String taskId) async {
    await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutines')
        .doc(routineId)
        .collection('URTasks')
        .doc(taskId)
        .update(task.toMap());
  }
}
