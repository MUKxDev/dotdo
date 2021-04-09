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
    String challangeId = await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
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

  Future<bool> addUCTask(String challangeId, Task task, int noOfTasks) async {
    String _userId = await _authService.getCurrentUserId();

    bool added = await _firestoreService.users
        .doc(_userId)
        .collection('UChallanges')
        .doc(challangeId)
        .collection('UCTasks')
        .add(task.toMap())
        .then((value) {
      print('task with id: ${value.id} added');
      int _num = noOfTasks + 1;
      _firestoreService.users
          .doc(_userId)
          .collection('UChallanges')
          .doc(challangeId)
          .update({'noOfTasks': _num});
      return true;
    }).onError((error, stackTrace) {
      print('error with adding task: $error');
      return false;
    });

    return added;
  }

// *completed --------------------------------
  Future<bool> toggleCompletedUChalllange(
      String challangeId, bool completed) async {
    return await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('UChallanges')
        .doc(challangeId)
        .update({'completed': completed})
        .then((value) => true)
        .onError((error, stackTrace) => false);
  }

  Future<bool> toggleCompletedUCTask(String taskId, String challangeId,
      bool currentCompleted, int noOfCompletedTasks) async {
    String _userId = await _authService.getCurrentUserId();
    bool _isToggeled;
    _isToggeled = await _firestoreService.users
        .doc(_userId)
        .collection('UChallanges')
        .doc(challangeId)
        .collection('UCTasks')
        .doc(taskId)
        .update({'completed': !(currentCompleted)}).then((value) async {
      if (currentCompleted == false) {
        int _num = noOfCompletedTasks + 1;
        _firestoreService.users
            .doc(_userId)
            .collection('UChallanges')
            .doc(challangeId)
            .update({'noOfCompletedTasks': _num});
      } else {
        int _num = noOfCompletedTasks - 1;
        _firestoreService.users
            .doc(_userId)
            .collection('UChallanges')
            .doc(challangeId)
            .update({'noOfCompletedTasks': _num});
      }
      return true;
    }).onError((error, stackTrace) {
      print('error with adding task: $error');
      return false;
    });
    return _isToggeled;
  }

  // *update --------------------------------
  Future updateUChalllange(String challangeId, Challange challange) async {
    _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('UChallanges')
        .doc(challangeId)
        .update(challange.toMap());
  }

  Future updateUCTask(String challangeId, String taskId, Task task) async {
    _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('UChallanges')
        .doc(challangeId)
        .collection('UCTasks')
        .doc(taskId)
        .update(task.toMap());
  }

  // *get --------------------------------
  Stream<QuerySnapshot> getActiveUChallange() async* {
    DateTime date = DateTime.now();
    yield* _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('UChallanges')
        .orderBy('endDate')
        .where('endDate', isGreaterThanOrEqualTo: date.millisecondsSinceEpoch)
        .snapshots();
  }

  Stream<QuerySnapshot> getHistoryUChallange() async* {
    DateTime date = DateTime.now();
    yield* _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('UChallanges')
        .orderBy('endDate')
        .where('endDate', isLessThan: date.millisecondsSinceEpoch)
        .snapshots();
  }

  Future<Challange> getUChallange(String challangeId) async {
    return _firestoreService.users
        .doc(await _authService.getCurrentUserId())
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

  // * Get Date UCTasks
  Stream<QuerySnapshot> getDateUCTasksStream(
      String challangeId, DateTime date) async* {
    String _uid = await _authService.getCurrentUserId();
    yield* _firestoreService.users
        .doc(_uid)
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
    String _uid = await _authService.getCurrentUserId();
    yield* _firestoreService.users
        .doc(_uid)
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
}
