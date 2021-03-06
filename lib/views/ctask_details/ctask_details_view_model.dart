import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/task.dart';
import 'package:dotdo/core/services/challengeService.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:intl/intl.dart';
import 'package:stacked_services/stacked_services.dart';

class CtaskDetailsViewModel extends BaseViewModel {
  Logger log;

  CtaskDetailsViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  String _taskId;
  String _challengeId;
  handelStartup(String taskId, String challengeId, DateTime date, IconData icon,
      Color color) async {
    _challengeId = challengeId;
    _taskId = taskId;
    _currentDate = date;
    if (isTaskIdNull == false) {
      _isBusy = true;
      _task = await _challengeService.getUCTask(_challengeId, _taskId);
      labelController.text = _task.taskName;
      noteController.text = _task.taskNote;
      _iconColor = _task.iconColor;
      _iconData = _task.iconData;
      _dueDate = _task.dueDate;
      _complated = _task.completed;

      _isBusy = false;
      notifyListeners();
    } else {
      _iconColor = color;
      _iconData = icon;
      _dueDate = DateTime(
          currentDate.year, currentDate.month, currentDate.day, 23, 59);
      notifyListeners();
    }
  }

  bool _isBusy = false;
  bool get isBusy => _isBusy;
  bool get isTaskIdNull => _taskId == null;
  Task _task;

  DateTime _currentDate;
  DateTime get currentDate => _currentDate;

  DateTime get today => DateTime.now();
  DateTime get firstDate => DateTime(2021);

  // variables
  TextEditingController labelController = TextEditingController(text: '');
  TextEditingController noteController = TextEditingController(text: '');

  DateTime _dueDate;
  DateTime get dueDate => _dueDate;

  bool _complated = false;
  bool get complated => _complated;

  final dateFormat = DateFormat('yyyy-MMM-dd');
  final timeFormat = DateFormat('hh:mm a');

  IconData _iconData = FontAwesomeIcons.tasks;
  IconData get iconData => _iconData;

  Color _iconColor = AppColors.iconColors[2];
  Color get iconColor => _iconColor;

  updateDueDate(Future<DateTime> due) async {
    DateTime date = await due;
    if (date != null) {
      _dueDate = DateTime(date.year, date.month, date.day, 23, 59);
      notifyListeners();
    }
  }

  updateDueTime(Future<TimeOfDay> showTimePicker) async {
    TimeOfDay dueTime = await showTimePicker;
    if (dueTime != null) {
      _dueDate = DateTime(dueDate.year, dueDate.month, dueDate.day,
          dueTime.hour, dueTime.minute);
      notifyListeners();
    }
  }

  colorTapped(Color iconColor) {
    _iconColor = iconColor;
    notifyListeners();
  }

  void iconTapped(IconData iconData) {
    _iconData = iconData;
    notifyListeners();
  }

  ChallengeService _challengeService = locator<ChallengeService>();
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
      bool added = await _challengeService.addUCTask(_challengeId, task);
      notifyListeners();
      _navigationService.back();
      if (added) {
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
          await _challengeService.updateUCTask(_challengeId, _taskId, task);
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
    _challengeService.deleteUCTask(_taskId, _challengeId);
    _navigationService.back();
    _snackbarService.showSnackbar(message: 'Task deleted');
  }

  NavigationService _navigationService = locator<NavigationService>();
  cancel() {
    _navigationService.back();
  }
}
