import 'package:dotdo/core/models/task.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class TaskService {
  // This will generate a uniqe key use .v1() or .v4()
  var uuid = Uuid();

  List<Task> get taskList => _taskList;
  List<Task> get doneTaskList =>
      _taskList.where((task) => task.checked == true).toList();
  List<Task> get unDoneTaskList =>
      _taskList.where((task) => task.checked == false).toList();

  void removeTask(id) {
    taskList.removeWhere((task) => task.id == id);
  }

  void addTask(Task task) {
    taskList.add(task);
  }

  // TODO: implement retreving (Tasks List) data from user.
  List<Task> _taskList = [
    Task(
        public: true,
        checked: true,
        lable: 'A task is done',
        due: DateTime.now(),
        category: 'Work',
        id: UniqueKey().toString()),
    Task(
        public: false,
        checked: false,
        lable: 'A task to be done',
        due: DateTime.now(),
        category: 'Work',
        id: UniqueKey().toString()),
    Task(
        public: true,
        checked: true,
        lable: 'A task is done',
        due: DateTime.now(),
        category: 'Work',
        id: UniqueKey().toString()),
    Task(
        public: true,
        checked: false,
        lable: 'A task to be done',
        due: DateTime.now(),
        category: 'Work',
        id: UniqueKey().toString()),
    Task(
        public: false,
        checked: false,
        lable: 'A task to be done',
        due: DateTime.now(),
        category: 'Work',
        id: UniqueKey().toString()),
    Task(
        public: false,
        checked: false,
        lable: 'A task to be done',
        due: DateTime.utc(2021, 3, 8),
        category: 'Work',
        id: UniqueKey().toString()),
  ];
}
