import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/task.dart';
import 'package:dotdo/core/services/routineService.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class RtaskDetailsViewModel extends BaseViewModel {
  Logger log;

  RtaskDetailsViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  String _taskId;
  String _routineId;
  handelStartup(
      String taskId, String routineId, IconData icon, Color color) async {
    _routineId = routineId;
    _taskId = taskId;
    if (isTaskIdNull == false) {
      _isBusy = true;
      _task = await _routineService.getURTask(_routineId, _taskId);
      labelController.text = _task.taskName;
      noteController.text = _task.taskNote;
      _iconColor = _task.iconColor;
      _iconData = _task.iconData;
      _dueDate = _task.dueDate;
      _complated = _task.completed;

      _isBusy = false;
      notifyListeners();
    } else {
      _dueDate = DateTime.now();
      _iconColor = color;
      _iconData = icon;
      notifyListeners();
    }
  }

  bool _isBusy = false;
  bool get isBusy => _isBusy;
  bool get isTaskIdNull => _taskId == null;
  Task _task;

  // variables
  TextEditingController labelController = TextEditingController(text: '');
  TextEditingController noteController = TextEditingController(text: '');

  DateTime _dueDate;
  DateTime get dueDate => _dueDate;

  bool _complated = false;
  bool get complated => _complated;

  IconData _iconData = FontAwesomeIcons.tasks;
  IconData get iconData => _iconData;

  Color _iconColor = AppColors.iconColors[2];
  Color get iconColor => _iconColor;

  colorTapped(Color iconColor) {
    _iconColor = iconColor;
    notifyListeners();
  }

  void iconTapped(IconData iconData) {
    _iconData = iconData;
    notifyListeners();
  }

  RoutineService _routineService = locator<RoutineService>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  void addTask() async {
    if (labelController.text.trim() == '') {
      print('title is empty');
      _snackbarService.showSnackbar(
          message: 'Please provide a title for the task');
    } else {
      Task task = Task(
        taskName: labelController.text.trim(),
        taskNote: noteController.text.trim(),
        dueDate: dueDate,
        completed: false,
        iconColor: iconColor,
        iconData: iconData,
      );
      String _addedId = await _routineService.addURTask(_routineId, task);
      notifyListeners();
      _navigationService.back();
      if (_addedId != null) {
        _snackbarService.showSnackbar(message: 'Task added successfully');
      } else {
        _snackbarService.showSnackbar(
            message: 'Something went wrong. Task not added');
      }
    }
  }

  void updateUTask() async {
    if (labelController.text.trim() == '') {
      print('title is empty');
      _snackbarService.showSnackbar(
          message: 'Please provide a title for the task');
    } else {
      Task task = Task(
        taskName: labelController.text.trim(),
        taskNote: noteController.text.trim(),
        dueDate: dueDate,
        completed: false,
        iconColor: iconColor,
        iconData: iconData,
      );

      bool _updated =
          await _routineService.updateRTask(task, _routineId, _taskId);
      notifyListeners();
      _navigationService.back();
      if (_updated) {
        _snackbarService.showSnackbar(message: 'Task updated successfully');
      } else {
        _snackbarService.showSnackbar(
            message: 'Something went wrong. Task not updated');
      }
    }
  }

  void deleteUTask() {
    _routineService.deleteRTask(_routineId, _taskId);
    _navigationService.back();
    _snackbarService.showSnackbar(message: 'Task deleted');
  }

  NavigationService _navigationService = locator<NavigationService>();
  cancel() {
    _navigationService.back();
  }
}
