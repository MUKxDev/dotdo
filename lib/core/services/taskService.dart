import 'package:dotdo/core/models/task.dart';
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

  RxList<Task> _rxList = RxList();
  RxList<Task> get rxTaskList => _rxList;

  TaskService() {
    listenToReactiveValues([_rxList, _date]);
  }

  void updateDate(DateTime date) {
    _date.value = date;
  }

  void updateRxListFromFirebase() {
    _rxList.assignAll(_taskList);
    // notifyListeners();
  }

  List<Task> get taskList => _taskList;
  List<Task> get doneTaskList =>
      _taskList.where((task) => task.checked == true).toList();
  List<Task> get unDoneTaskList =>
      _taskList.where((task) => task.checked == false).toList();

  void removeTask(id) {
    // taskList.removeWhere((task) => task.id == id);
    _rxList.removeWhere((task) => task.id == id);
    // notifyListeners();
  }

  // * This will update the today Task list
  void addTask(Task task) {
    // taskList.add(task);
    _rxList.add(task);
    notifyListeners();
    // todayTaskListKey.currentState.insertItem(0);s
  }

  void toggleCheckedTask(Task task) {
    bool checked = task.checked;
    Task newTask = task.copyWith(checked: !checked);
    _rxList.add(newTask);
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
