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
    DateTime date =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutines')
        .doc(routineId)
        .update({
      'noOfLikes': 0,
      'publicRoutine': false,
      'lastSeen': date.millisecondsSinceEpoch
    });

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

  // toggle -------------------
  Future togglePublicR(String routineId) async {
    String _userId = await _authService.getCurrentUserId();
    await _firestoreService.users
        .doc(_userId)
        .collection('URoutines')
        .doc(routineId)
        .update({'publicRoutine': true});
    Map _pRoutien = await _firestoreService.users
        .doc(_userId)
        .collection('URoutines')
        .doc(routineId)
        .get()
        .then((value) => value.data());

    String groutineId = await _firestoreService.groutiens
        .add(_pRoutien)
        .then((value) => value.id);

    await _firestoreService.groutiens
        .doc(groutineId)
        .update({'routineId': routineId, 'creatorId': _userId});

    await updateRoutine(groutineId, routineId);

    togglePublicRTask(routineId, groutineId);
  }

  Future togglePublicROFF(String routineId) async {
    String _userId = await _authService.getCurrentUserId();
    String rID = await _firestoreService.groutiens
        .where('routineId', isEqualTo: routineId)
        .get()
        .then((value) => value.docs.first.id);

    await _firestoreService.groutiens.doc(rID).delete();

    await _firestoreService.users
        .doc(_userId)
        .collection('URoutines')
        .doc(routineId)
        .update({'publicRoutine': false, 'noOfLikes': 0});
  }

  Future togglePublicRTask(String routineId, String groutineId) async {
    String _userId = await _authService.getCurrentUserId();
    int _noOfTasks = await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutines')
        .doc(routineId)
        .get()
        .then((value) => value.data()['noOfTasks']);
    for (var i = 0; i < _noOfTasks; i++) {
      Map _pRTask = await _firestoreService.users
          .doc(_userId)
          .collection('URoutines')
          .doc(routineId)
          .collection('URTasks')
          .get()
          .then((value) => value.docs.elementAt(i).data());

      await _firestoreService.groutiens
          .doc(groutineId)
          .collection('GRTasks')
          .add(_pRTask);
    }
  }

// update -------------------
  Future updateRoutine(String groutineId, String routineId) async {
    await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutines')
        .doc(routineId)
        .update({'groutineId': groutineId});
  }

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
        await _firestoreService.users
            .doc(await _authService.getCurrentUserId())
            .collection("uGeneral")
            .doc('generalData')
            .update({'noOfTaskCompleted': _plus});
        await _firestoreService.users
            .doc(await _authService.getCurrentUserId())
            .collection('URoutines')
            .doc(routineId)
            .update({'noOfCompletedTasks': _urtplus});
        await dotsPlus();
      } else {
        await _firestoreService.users
            .doc(await _authService.getCurrentUserId())
            .collection("uGeneral")
            .doc('generalData')
            .update({'noOfTaskCompleted': _minus});
        await _firestoreService.users
            .doc(await _authService.getCurrentUserId())
            .collection('URoutines')
            .doc(routineId)
            .update({'noOfCompletedTasks': _urtminus});
        await dotsMinus();
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

  Future routineReset(String routineId) async {
    DateTime date =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);

    DateTime dateTest = DateTime(
        DateTime.now().year, DateTime.now().month, DateTime.now().day - 1);
    print(dateTest.millisecondsSinceEpoch);

    int lastDate = await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutines')
        .doc(routineId)
        .get()
        .then((value) => value.data()['lastSeen']);
    int noOfTask = await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('URoutines')
        .doc(routineId)
        .get()
        .then((value) => value.data()['noOfTasks']);
    int result =
        date.difference(DateTime.fromMillisecondsSinceEpoch(lastDate)).inDays;

    if (result >= 1) {
      for (var i = 0; i < noOfTask; i++) {
        String id = await _firestoreService.users
            .doc(await _authService.getCurrentUserId())
            .collection('URoutines')
            .doc(routineId)
            .collection('URTasks')
            .get()
            .then((value) => value.docs.elementAt(i).id);

        await _firestoreService.users
            .doc(await _authService.getCurrentUserId())
            .collection('URoutines')
            .doc(routineId)
            .collection('URTasks')
            .doc(id)
            .update({
          'completed': false,
        });
      }
      await _firestoreService.users
          .doc(await _authService.getCurrentUserId())
          .collection('URoutines')
          .doc(routineId)
          .update({
        'noOfCompletedTasks': 0,
        'lastSeen': date.millisecondsSinceEpoch
      });
    }
  }

  Future dotsPlus() async {
    String _userId = await _authService.getCurrentUserId();
    int dots = await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .get()
        .then((value) => value.data()['dots']);
    int _dplus = dots + 2;
    await _firestoreService.users.doc(_userId).update({'dots': _dplus});
  }

  Future dotsMinus() async {
    String _userId = await _authService.getCurrentUserId();
    int dots = await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .get()
        .then((value) => value.data()['dots']);
    int _dMinus = dots - 2;
    await _firestoreService.users.doc(_userId).update({'dots': _dMinus});
  }
}
