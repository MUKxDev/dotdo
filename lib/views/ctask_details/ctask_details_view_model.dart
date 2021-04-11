import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/task.dart';
import 'package:dotdo/core/services/challangeService.dart';
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
  String _challangeId;
  handelStartup(String taskId, String challangeId, DateTime date, IconData icon,
      Color color) async {
    _challangeId = challangeId;
    _taskId = taskId;
    _currentDate = date;
    if (isTaskIdNull == false) {
      _isBusy = true;
      _task = await _challangeService.getUCTask(_challangeId, _taskId);
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

  ChallangeService _challangeService = locator<ChallangeService>();
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
      // TODO: implement show the snackbar with the real result Sucsses or failure
      _challangeService.addUCTask(_challangeId, task);
      notifyListeners();
      _navigationService.back();
      _snackbarService.showSnackbar(message: 'Task added');
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
      // TODO: implement show the snackbar with the real result Sucsses or failure
      _challangeService.updateUCTask(_challangeId, _taskId, task);
      notifyListeners();
      _navigationService.back();
      _snackbarService.showSnackbar(message: 'Task updated');
    }
  }

  void deleteUTask() {
    _challangeService.deleteUCTask(_taskId, _challangeId);
    _navigationService.back();
    _snackbarService.showSnackbar(message: 'Task deleted');
  }

  NavigationService _navigationService = locator<NavigationService>();
  cancel() {
    _navigationService.back();
  }
}
