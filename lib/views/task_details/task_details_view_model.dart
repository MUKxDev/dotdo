import 'dart:core';
import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/task.dart';
import 'package:dotdo/core/services/taskService.dart';
import 'package:intl/intl.dart';

import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class TaskDetailsViewModel extends BaseViewModel {
  Logger log;

  TaskDetailsViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
  handelStartup() {
    _dueDate =
        DateTime(currentDate.year, currentDate.month, currentDate.day, 23, 59);
    notifyListeners();
  }

  DateTime get currentDate => _taskService.date.value;

  DateTime get today => DateTime.now();

  // variables
  TextEditingController labelController = TextEditingController(text: '');
  TextEditingController noteController = TextEditingController(text: '');

  String _category = 'Index';
  String get category => _category;

  DateTime _dueDate;
  DateTime get dueDate => _dueDate;

  bool _public = false;
  bool get public => _public;

  final dateFormat = DateFormat('yyyy-MMM-dd');
  final timeFormat = DateFormat('hh:mm a');

  List<String> _categoryList = ['Work', 'University', 'Developing', 'Index'];
  List<String> get categoryList => _categoryList;

  updateCategory(String category) {
    _category = category;
    notifyListeners();
  }

  updateDueDate(Future<DateTime> due) async {
    DateTime date = await due;
    if (date != null) {
      _dueDate = DateTime(date.year, date.month, date.day, 23, 59);
      notifyListeners();
    }
  }

  updateDueTime(Future<TimeOfDay> showTimePicker) async {
    TimeOfDay dueTime = await showTimePicker;
    _dueDate = DateTime(
        dueDate.year, dueDate.month, dueDate.day, dueTime.hour, dueTime.minute);
    notifyListeners();
  }

  void updatePublic(bool value) {
    _public = value;
    notifyListeners();
  }

  // addTask() {}
  TaskService _taskService = locator<TaskService>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  void addTask() async {
    if (labelController.text.trim() == '') {
      print('title is empty');
      _snackbarService.showSnackbar(
          message: 'Please provide a title for the task');
    } else {
      String id = UniqueKey().toString();
      // String id = uuid.v4();
      Task task = Task(
        public: public,
        checked: false,
        lable: labelController.text.trim(),
        due: dueDate,
        category: category,
        id: id,
      );
      _taskService.addTask(task);
      notifyListeners();
      print(_taskService.rxTaskList.length);
      print(id);
      _navigationService.back();
      _snackbarService.showSnackbar(message: 'Task added');
    }
  }

  NavigationService _navigationService = locator<NavigationService>();
  cancel() {
    _navigationService.back();
  }
}
