import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/task.dart';
import 'package:dotdo/core/services/authService.dart';
import 'package:dotdo/core/services/firestoreService.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
// import 'package:uuid/uuid.dart';
import 'package:observable_ish/observable_ish.dart';

class TaskService with ReactiveServiceMixin {
  // This will generate a uniqe key use .v1() or .v4()
  // var uuid = Uuid();

  // DateTime _date = DateTime.now();
  RxValue<DateTime> _date = RxValue(initial: DateTime.now());
  RxValue<DateTime> get date => _date;

  TaskService() {
    listenToReactiveValues([_date]);
  }

  void updateDate(DateTime date) {
    _date.value = date;
  }

  FirestoreService _firestoreService = locator<FirestoreService>();
  AuthService _authService = locator<AuthService>();

  Stream<QuerySnapshot> getUTasksStream() async* {
    String _uid = await _authService.getCurrentUserId();
    yield* _firestoreService.users
        .doc(_uid)
        .collection('UTasks')
        .orderBy('completed')
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
    print(task.toString());
    return task;
  }

  Future addUTask(Task task) async {
    _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('UTasks')
        .add(task.toMap())
        .then((value) => print('task with id ${value.id} added'))
        .onError(
            (error, stackTrace) => print('error with adding task: $error'));
  }

  Future toggleCompletedUTask(String taskId, bool currentCompleted) async {
    _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('UTasks')
        .doc(taskId)
        .update({'completed': !(currentCompleted)})
        .then((value) => print('task with id $taskId updated'))
        .onError(
            (error, stackTrace) => print('error with adding task: $error'));
  }

  Future updateUTask(String taskId, Task task) async {
    _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('UTasks')
        .doc(taskId)
        .update(task.toMap());
  }

  void deleteUTask(String taskId) {}
}
