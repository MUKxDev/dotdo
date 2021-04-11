import 'package:cloud_firestore/cloud_firestore.dart';

import '../locator.dart';
import '../models/challange.dart';
import '../models/task.dart';
import 'authService.dart';
import 'firestoreService.dart';

class ChallangeService {
  FirestoreService _firestoreService = locator<FirestoreService>();
  AuthService _authService = locator<AuthService>();
// *ADD --------------------------------
  Future<String> addUChallange(Challange challange) async {
    String _userId = await _authService.getCurrentUserId();
    String challangeId = await _firestoreService.users
        .doc(_userId)
        .collection('UChallanges')
        .add(challange.toMap())
        .then((value) {
      print('challange with id ${value.id} added');
      return value.id;
    }).onError((error, stackTrace) {
      print('erorr with adding challange: $error');
      return null;
    });
    return challangeId;
  }

  Future<bool> addUCTask(String challangeId, Task task) async {
    String _userId = await _authService.getCurrentUserId();
    int _totalUCTask = await _firestoreService.users
        .doc(_userId)
        .collection('UChallanges')
        .doc(challangeId)
        .get()
        .then((value) => value.data()['noOfTasks']);

    bool added = await _firestoreService.users
        .doc(_userId)
        .collection('UChallanges')
        .doc(challangeId)
        .collection('UCTasks')
        .add(task.toMap())
        .then((value) {
      print('task with id: ${value.id} added');
      int _tplus = _totalUCTask + 1;
      _firestoreService.users
          .doc(_userId)
          .collection('UChallanges')
          .doc(challangeId)
          .update({'noOfTasks': _tplus});
      toggleCompletedUChalllange(challangeId);
      return true;
    }).onError((error, stackTrace) {
      print('error with adding task: $error');
      return false;
    });

    return added;
  }

// *completed --------------------------------
  Future toggleCompletedUChalllange(String challangeId) async {
    String _userId = await _authService.getCurrentUserId();
    int _totalUCTask = await _firestoreService.users
        .doc(_userId)
        .collection('UChallanges')
        .doc(challangeId)
        .get()
        .then((value) => value.data()['noOfTasks']);

    int _totalCompletedUCTask = await _firestoreService.users
        .doc(_userId)
        .collection('UChallanges')
        .doc(challangeId)
        .get()
        .then((value) => value.data()['noOfCompletedTasks']);
//-----------------------------------
    if (_totalUCTask == _totalCompletedUCTask && _totalUCTask != 0) {
      await _firestoreService.users
          .doc(_userId)
          .collection('UChallanges')
          .doc(challangeId)
          .update({'completed': true});
    } else {
      await _firestoreService.users
          .doc(_userId)
          .collection('UChallanges')
          .doc(challangeId)
          .update({'completed': false});
    }
    noOfChallangeCompleted();
  }

  Future toggleCompletedUCTask(
      String taskId, String challangeId, bool currentCompleted) async {
    String _userId = await _authService.getCurrentUserId();
    int _noOfTaskCompleted = await _firestoreService.users
        .doc(_userId)
        .collection('uGeneral')
        .doc('generalData')
        .get()
        .then((value) => value.data()['noOfTaskCompleted']);

    int _noOfCTaskCompleted = await _firestoreService.users
        .doc(_userId)
        .collection('UChallanges')
        .doc(challangeId)
        .get()
        .then((value) => value.data()['noOfCompletedTasks']);
//------------------------
    int _plus = _noOfTaskCompleted + 1;
    int _minus = _noOfTaskCompleted - 1;
//-----------------------------------------
    int _tplus = _noOfCTaskCompleted + 1;
    int _tminus = _noOfCTaskCompleted - 1;
//
    await _firestoreService.users
        .doc(_userId)
        .collection('UChallanges')
        .doc(challangeId)
        .collection('UCTasks')
        .doc(taskId)
        .update({'completed': !(currentCompleted)}).then((value) async {
      if (currentCompleted == false) {
        _firestoreService.users
            .doc(_userId)
            .collection("uGeneral")
            .doc('generalData')
            .update({'noOfTaskCompleted': _plus});
        _firestoreService.users
            .doc(_userId)
            .collection('UChallanges')
            .doc(challangeId)
            .update({'noOfCompletedTasks': _tplus});
      } else {
        _firestoreService.users
            .doc(_userId)
            .collection("uGeneral")
            .doc('generalData')
            .update({'noOfTaskCompleted': _minus});
        _firestoreService.users
            .doc(_userId)
            .collection('UChallanges')
            .doc(challangeId)
            .update({'noOfCompletedTasks': _tminus});
      }
      toggleCompletedUChalllange(challangeId);
    }).onError((error, stackTrace) {
      print('error with adding task: $error');
    });
  }

  // *update --------------------------------
  Future updateUChalllange(String challangeId, Challange challange) async {
    String _userId = await _authService.getCurrentUserId();
    _firestoreService.users
        .doc(_userId)
        .collection('UChallanges')
        .doc(challangeId)
        .update(challange.toMap());
  }

  Future updateUCTask(String challangeId, String taskId, Task task) async {
    String _userId = await _authService.getCurrentUserId();
    _firestoreService.users
        .doc(_userId)
        .collection('UChallanges')
        .doc(challangeId)
        .collection('UCTasks')
        .doc(taskId)
        .update(task.toMap());
  }

  // *get --------------------------------
  Stream<QuerySnapshot> getActiveUChallange() async* {
    String _userId = await _authService.getCurrentUserId();
    DateTime date = DateTime.now();
    yield* _firestoreService.users
        .doc(_userId)
        .collection('UChallanges')
        .orderBy('endDate')
        .where('endDate', isGreaterThanOrEqualTo: date.millisecondsSinceEpoch)
        .snapshots();
  }

  Stream<QuerySnapshot> getHistoryUChallange() async* {
    String _userId = await _authService.getCurrentUserId();
    DateTime date = DateTime.now();
    yield* _firestoreService.users
        .doc(_userId)
        .collection('UChallanges')
        .orderBy('endDate')
        .where('endDate', isLessThan: date.millisecondsSinceEpoch)
        .snapshots();
  }

  Future<Challange> getUChallange(String challangeId) async {
    String _userId = await _authService.getCurrentUserId();
    return _firestoreService.users
        .doc(_userId)
        .collection('UChallanges')
        .doc(challangeId)
        .get()
        .then((value) {
      Challange _challange = Challange.fromMap(value.data());
      return _challange;
    }).onError((error, stackTrace) {
      print('An error has occurred: $error');
      return null;
    });
  }

  Future<Task> getUCTask(String challangeId, String taskId) async {
    String _userId = await _authService.getCurrentUserId();
    return _firestoreService.users
        .doc(_userId)
        .collection('UChallanges')
        .doc(challangeId)
        .collection('UCTasks')
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

  Stream<DocumentSnapshot> getUChallangeStream(String challangeId) async* {
    String _userId = await _authService.getCurrentUserId();
    yield* _firestoreService.users
        .doc(_userId)
        .collection('UChallanges')
        .doc(challangeId)
        .snapshots();
  }

  // * Get Date UCTasks
  Stream<QuerySnapshot> getDateUCTasksStream(
      String challangeId, DateTime date) async* {
    String _userId = await _authService.getCurrentUserId();
    yield* _firestoreService.users
        .doc(_userId)
        .collection('UChallanges')
        .doc(challangeId)
        .collection('UCTasks')
        .where('dueDate',
            isLessThanOrEqualTo:
                DateTime(date.year, date.month, date.day, 23, 59, 59)
                    .millisecondsSinceEpoch)
        .where('dueDate', isGreaterThanOrEqualTo: date.millisecondsSinceEpoch)
        .orderBy('dueDate')
        .snapshots();
  }

  Stream<QuerySnapshot> getDateUCTasksStreamHome(DateTime date) async* {
    String _userId = await _authService.getCurrentUserId();
    yield* _firestoreService.users
        .doc(_userId)
        .collection('UChallanges')
        .doc()
        .collection('UCTasks')
        .where('dueDate',
            isLessThanOrEqualTo:
                DateTime(date.year, date.month, date.day, 23, 59, 59)
                    .millisecondsSinceEpoch)
        .where('dueDate', isGreaterThanOrEqualTo: date.millisecondsSinceEpoch)
        .orderBy('dueDate')
        .snapshots();
  }

  Future<int> noOfChallangeCompleted() async {
    String _userId = await _authService.getCurrentUserId();
    int _noOfcompletedChallange = await _firestoreService.users
        .doc(_userId)
        .collection('UChallanges')
        .where('completed', isEqualTo: true)
        .get()
        .then((value) => value.size);
    print(_noOfcompletedChallange);
    return _firestoreService.users
        .doc(_userId)
        .collection('uGeneral')
        .doc('generalData')
        .update({'noOfChallangeCompleted': _noOfcompletedChallange}).then(
            (value) => _noOfcompletedChallange);
  }

  Future deleteUChallange(String challangeId) async {
    String _userId = await _authService.getCurrentUserId();
    _firestoreService.users
        .doc(_userId)
        .collection('UChallanges')
        .doc(challangeId)
        .delete();
  }

  Future deleteUCTask(String taskId, String challangeId) async {
    String _userId = await _authService.getCurrentUserId();
    int _totalUCTask = await _firestoreService.users
        .doc(_userId)
        .collection('UChallanges')
        .doc(challangeId)
        .get()
        .then((value) => value.data()['noOfTasks']);

    int _totalCompletedUCTask = await _firestoreService.users
        .doc(_userId)
        .collection('UChallanges')
        .doc(challangeId)
        .get()
        .then((value) => value.data()['noOfCompletedTasks']);

    bool currentStats = await _firestoreService.users
        .doc(_userId)
        .collection('UChallanges')
        .doc(challangeId)
        .collection('UCTasks')
        .doc(taskId)
        .get()
        .then((value) => value.data()['completed']);

    int _cminus = _totalCompletedUCTask - 1;
    int _tminus = _totalUCTask - 1;

    if (currentStats == true) {
      _firestoreService.users
          .doc(_userId)
          .collection('UChallanges')
          .doc(challangeId)
          .update({'noOfCompletedTasks': _cminus});
    }
    _firestoreService.users
        .doc(_userId)
        .collection('UChallanges')
        .doc(challangeId)
        .update({'noOfTasks': _tminus});
    _firestoreService.users
        .doc(_userId)
        .collection('UChallanges')
        .doc(challangeId)
        .collection('UCTasks')
        .doc(taskId)
        .delete();
  }
}
