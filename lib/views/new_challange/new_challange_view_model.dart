import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/challange.dart';
import 'package:dotdo/core/router_constants.dart';
import 'package:dotdo/core/services/challangeService.dart';
import 'package:dotdo/core/services/taskService.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:intl/intl.dart';
import 'package:stacked_services/stacked_services.dart';

class NewChallangeViewModel extends BaseViewModel {
  Logger log;

  NewChallangeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  TaskService _taskService = locator<TaskService>();
  ChallangeService _challangeService = locator<ChallangeService>();
  NavigationService _navigationService = locator<NavigationService>();
  SnackbarService _snackbarService = locator<SnackbarService>();

  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController noteController = TextEditingController(text: '');

  final dateFormat = DateFormat('yyyy-MMM-dd');
  final timeFormat = DateFormat('hh:mm a');

  String _challangeId;
  bool get ischallangeIdNull => _challangeId == null;

  Challange _challange;

  bool _isBusy = false;
  bool get isBusy => _isBusy;

  bool _completed = false;

  int _noOfTasks = 0;
  int _noOfCompletedTasks = 0;

  DateTime _startDate;
  DateTime get startDate => _startDate;

  DateTime _endDate;
  DateTime get endDate => _endDate;

  DateTime get currentDate => _taskService.date.value;
  DateTime get today => DateTime.now();
  DateTime get firstDate => DateTime(2021);

  IconData _iconData = FontAwesomeIcons.crosshairs;
  IconData get iconData => _iconData;

  Color _iconColor = AppColors.darkPurple;
  Color get iconColor => _iconColor;

  handelStartup(String challangeId) async {
    _challangeId = challangeId;
    if (ischallangeIdNull == false) {
      _isBusy = true;
      _challange = await _challangeService.getUChallange(_challangeId);
      nameController.text = _challange.name;
      noteController.text = _challange.note;
      _iconColor = _challange.iconColor;
      _iconData = IconDataSolid(_challange.iconData.codePoint);
      _startDate = _challange.startDate;
      _endDate = _challange.endDate;

      _completed = _challange.completed;
      _noOfTasks = _challange.noOfTasks;
      _noOfCompletedTasks = _challange.noOfCompletedTasks;

      _isBusy = false;
      notifyListeners();
    } else {
      _startDate =
          DateTime(currentDate.year, currentDate.month, currentDate.day);
      _endDate = DateTime(
          currentDate.year, currentDate.month, currentDate.day, 23, 59);
      notifyListeners();
    }
  }

  updateStartDate(Future<DateTime> startDate) async {
    DateTime date = await startDate;
    if (date != null) {
      _startDate = DateTime(date.year, date.month, date.day);
      notifyListeners();
    }
  }

  updateEndDate(Future<DateTime> endDate) async {
    DateTime date = await endDate;
    if (date != null) {
      _endDate = DateTime(date.year, date.month, date.day, 23, 59);
      notifyListeners();
    }
  }

  cancel() {
    _navigationService.back();
  }

  next() async {
    String challangeID;
    Challange challange = Challange(
      name: nameController.text.trim(),
      note: noteController.text.trim(),
      iconData: _iconData,
      iconColor: _iconColor,
      startDate: _startDate,
      endDate: _endDate,
      completed: _completed,
      noOfTasks: _noOfTasks,
      noOfCompletedTasks: _noOfCompletedTasks,
    );
    if (nameController.text.trim() != '') {
      challangeID = await _challangeService.addUChallange(challange);
      print(challangeID);
      if (challangeID != null) {
        Map<String, dynamic> args = {
          'challangeId': challangeID,
          'isEdit': true,
        };
        _navigationService.navigateTo(challangeDetailsViewRoute,
            arguments: args);
      }
    } else {
      _snackbarService.showSnackbar(message: 'Challange name is empty');
    }
  }

  save() async {
    Challange challange = Challange(
      name: nameController.text.trim(),
      note: noteController.text.trim(),
      iconData: _iconData,
      iconColor: _iconColor,
      startDate: _startDate,
      endDate: _endDate,
      completed: _completed,
      noOfTasks: _noOfTasks,
      noOfCompletedTasks: _noOfCompletedTasks,
    );

    if (nameController.text.trim() != '') {
      await _challangeService.updateUChalllange(_challangeId, challange);
      // Map args = {
      //   'challangeId': _challangeId,
      //   'isEdit': true,
      // };
      // _navigationService.navigateTo(challangeDetailsViewRoute, arguments: args);
      _navigationService.back();
    } else {
      _snackbarService.showSnackbar(message: 'Challange name is empty');
    }
  }

  delete() {
    _challangeService.deleteUChallange(_challangeId);
    _navigationService.pushNamedAndRemoveUntil(homeViewRoute);
  }

  colorTapped(Color iconColor) {
    _iconColor = iconColor;
    notifyListeners();
  }

  void iconTapped(IconData iconData) {
    _iconData = iconData;
    notifyListeners();
  }
}
