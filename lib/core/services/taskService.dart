import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/task.dart';
import 'package:dotdo/core/services/authService.dart';
import 'package:dotdo/core/services/firestoreService.dart';
import 'package:stacked/stacked.dart';

import 'package:observable_ish/observable_ish.dart';

class TaskService with ReactiveServiceMixin {
  // DateTime _date = DateTime.now();
  RxValue<DateTime> _date = RxValue(
      initial: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day));
  RxValue<DateTime> get date => _date;

  TaskService() {
    listenToReactiveValues([_date]);
  }

  void updateDate(DateTime date) {
    _date.value = date;
  }

  FirestoreService _firestoreService = locator<FirestoreService>();
  AuthService _authService = locator<AuthService>();

  // * Get All UTasks
  Stream<QuerySnapshot> getUTasksStream() async* {
    String _uid = await _authService.getCurrentUserId();
    yield* _firestoreService.users
        .doc(_uid)
        .collection('UTasks')
        .orderBy('completed')
        .orderBy('dueDate')
        .snapshots();
  }

  // * Get Up Coming UTasks
  Stream<QuerySnapshot> getUpComingUTasksStream() async* {
    String _uid = await _authService.getCurrentUserId();
    DateTime date = DateTime.now();
    yield* _firestoreService.users
        .doc(_uid)
        .collection('UTasks')
        .orderBy('dueDate')
        .where('dueDate', isGreaterThanOrEqualTo: date.millisecondsSinceEpoch)
        .snapshots();
  }

  // * Get Date UTasks
  Stream<QuerySnapshot> getDateUTasksStream(DateTime date) async* {
    String _uid = await _authService.getCurrentUserId();
    yield* _firestoreService.users
        .doc(_uid)
        .collection('UTasks')
        .where('dueDate',
            isLessThanOrEqualTo:
                DateTime(date.year, date.month, date.day, 23, 59, 59)
                    .millisecondsSinceEpoch)
        .where('dueDate', isGreaterThanOrEqualTo: date.millisecondsSinceEpoch)
        .orderBy('dueDate')
        .snapshots();
  }

  // * Get All Overdue UTasks
  Stream<QuerySnapshot> getOverdueUTasksStream() async* {
    int todayMillisecondsSinceEpoch = DateTime.now().millisecondsSinceEpoch;
    String _uid = await _authService.getCurrentUserId();
    yield* _firestoreService.users
        .doc(_uid)
        .collection('UTasks')
        .where('dueDate', isLessThanOrEqualTo: todayMillisecondsSinceEpoch)
        .where('completed', isEqualTo: false)
        .orderBy('dueDate')
        .snapshots();
  }

  Future<Task> getUTask(String taskId) async {
    Task task;
    await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('UTasks')
        .doc(taskId)
        .get()
        .then((value) => task = Task.fromMap(value.data()));
    return task;
  }

  Future<bool> addUTask(Task task) async {
    bool added = await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('UTasks')
        .add(task.toMap())
        .then((value) {
      print('task with id: ${value.id} added');
      return true;
    }).onError((error, stackTrace) {
      print('error with adding task: $error');
      return false;
    });

    return added;
  }

  Future toggleCompletedUTask(String taskId, bool currentCompleted) async {
    int _noOfTaskCompleted = await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('uGeneral')
        .doc('generalData')
        .get()
        .then((value) => value.data()['noOfTaskCompleted']);
    int dots = await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .get()
        .then((value) => value.data()['dots']);
//-----------------------------------------
    int _plus = _noOfTaskCompleted + 1;
    int _minus = _noOfTaskCompleted - 1;
    int _dplus = dots + 2;
    int _dminus = dots - 2;
//-----------------------------------------
    _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('UTasks')
        .doc(taskId)
        .update({'completed': !(currentCompleted)}).then((value) async {
      if (currentCompleted == false) {
        _firestoreService.users
            .doc(await _authService.getCurrentUserId())
            .collection("uGeneral")
            .doc('generalData')
            .update({'noOfTaskCompleted': _plus});
        _firestoreService.users
            .doc(await _authService.getCurrentUserId())
            .update({'dots': _dplus});
      } else {
        _firestoreService.users
            .doc(await _authService.getCurrentUserId())
            .collection("uGeneral")
            .doc('generalData')
            .update({'noOfTaskCompleted': _minus});
        _firestoreService.users
            .doc(await _authService.getCurrentUserId())
            .update({'dots': _dminus});
      }
    }).onError((error, stackTrace) {
      print('error with adding task: $error');
    });
  }

  Future updateUTask(String taskId, Task task) async {
    _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('UTasks')
        .doc(taskId)
        .update(task.toMap());
  }

  Future deleteUTask(String taskId) async {
    _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('UTasks')
        .doc(taskId)
        .delete();
  }
}
