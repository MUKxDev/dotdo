import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/pcTask.dart';
import 'package:dotdo/core/services/pvpService.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:intl/intl.dart';
import 'package:stacked_services/stacked_services.dart';

class PCTaskDetailsViewModel extends BaseViewModel {
  Logger log;

  PCTaskDetailsViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  String _taskId;
  String _challengeId;
  String _pvpId;
  handelStartup(Map args) async {
    _pvpId = args['pvpId'];
    _challengeId = args['challengeId'];
    _taskId = args['taskId'];
    _currentDate = args['date'];
    if (isTaskIdNull == false) {
      _isBusy = true;
      _task = await _pvpService.getTask(_pvpId, _challengeId, _taskId);
      labelController.text = _task.taskName;
      noteController.text = _task.taskNote;
      _iconColor = _task.iconColor;
      _iconData = _task.iconData;
      _dueDate = _task.dueDate;
      _aCompleted = _task.aCompleted;
      _bCompleted = _task.bCompleted;

      _isBusy = false;
      notifyListeners();
    } else {
      _iconColor = args['color'];
      _iconData = args['icon'];
      _dueDate = DateTime(
          currentDate.year, currentDate.month, currentDate.day, 23, 59);
      notifyListeners();
    }
  }

  bool _isBusy = false;
  bool get isBusy => _isBusy;
  bool get isTaskIdNull => _taskId == null;
  PCTask _task;

  DateTime _currentDate;
  DateTime get currentDate => _currentDate;

  DateTime get today => DateTime.now();
  DateTime get firstDate => DateTime(2021);

  // variables
  TextEditingController labelController = TextEditingController(text: '');
  TextEditingController noteController = TextEditingController(text: '');

  DateTime _dueDate;
  DateTime get dueDate => _dueDate;

  bool _aCompleted = false;
  bool get aCompleted => _aCompleted;

  bool _bCompleted = false;
  bool get bCompleted => _bCompleted;

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

  PvpService _pvpService = locator<PvpService>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  void addTask() async {
    if (labelController.text.trim() == '') {
      print('title is empty');
      _snackbarService.showSnackbar(
          message: 'Please provide a title for the task');
    } else {
      PCTask task = PCTask(
        taskName: labelController.text.trim(),
        taskNote: noteController.text.trim(),
        dueDate: dueDate,
        aCompleted: false,
        bCompleted: false,
        iconColor: iconColor,
        iconData: iconData,
      );

      bool added = await _pvpService.addPCtask(_pvpId, _challengeId, task);
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

  NavigationService _navigationService = locator<NavigationService>();
  cancel() {
    _navigationService.back();
  }
}
