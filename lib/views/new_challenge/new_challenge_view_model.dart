import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/challenge.dart';
import 'package:dotdo/core/router_constants.dart';
import 'package:dotdo/core/services/challengeService.dart';
import 'package:dotdo/core/services/taskService.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/views/challenge_details/challenge_details_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:intl/intl.dart';
import 'package:stacked_services/stacked_services.dart';

class NewChallengeViewModel extends BaseViewModel {
  Logger log;

  NewChallengeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  TaskService _taskService = locator<TaskService>();
  ChallengeService _challengeService = locator<ChallengeService>();
  NavigationService _navigationService = locator<NavigationService>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  DialogService _dialogService = locator<DialogService>();

  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController noteController = TextEditingController(text: '');

  final dateFormat = DateFormat('yyyy-MMM-dd');
  final timeFormat = DateFormat('hh:mm a');

  String _challengeId;
  bool get ischallengeIdNull => _challengeId == null;

  Challenge _challenge;

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

  handelStartup(String challengeId) async {
    _challengeId = challengeId;
    if (ischallengeIdNull == false) {
      _isBusy = true;
      _challenge = await _challengeService.getUChallenge(_challengeId);
      nameController.text = _challenge.name;
      noteController.text = _challenge.note;
      _iconColor = _challenge.iconColor;
      _iconData = IconDataSolid(_challenge.iconData.codePoint);
      _startDate = _challenge.startDate;
      _endDate = _challenge.endDate;

      _completed = _challenge.completed;
      _noOfTasks = _challenge.noOfTasks;
      _noOfCompletedTasks = _challenge.noOfCompletedTasks;

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
      if (_endDate.difference(_startDate).isNegative) {
        _endDate =
            DateTime(_startDate.year, _startDate.month, _startDate.day, 23, 59);
      }
      notifyListeners();
    }
  }

  updateEndDate(Future<DateTime> endDate) async {
    DateTime date = await endDate;
    if (date != null) {
      _endDate = DateTime(date.year, date.month, date.day, 23, 59);
      if (_startDate.difference(_endDate).isNegative == false) {
        _startDate =
            DateTime(_endDate.year, _endDate.month, _endDate.day, 23, 59);
      }
      notifyListeners();
    }
  }

  cancel() {
    _navigationService.back();
  }

  next() async {
    String challengeID;
    Challenge challenge = Challenge(
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
      challengeID = await _challengeService.addUChallenge(challenge);
      print(challengeID);
      if (challengeID != null) {
        Map<String, dynamic> args = {
          'challengeId': challengeID,
          'isEdit': true,
        };
        _navigationService.navigateToView(ChallengeDetailsView(args: args));
      }
    } else {
      _snackbarService.showSnackbar(message: 'Challenge name is empty');
    }
  }

  save() async {
    Challenge challenge = Challenge(
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
      await _challengeService.updateUChalllange(_challengeId, challenge);
      // Map args = {
      //   'challengeId': _challengeId,
      //   'isEdit': true,
      // };
      // _navigationService.navigateToView(challengeDetailsViewRoute, arguments: args);
      _navigationService.back();
    } else {
      _snackbarService.showSnackbar(message: 'Challenge name is empty');
    }
  }

  delete() async {
    DialogResponse _dialogResponse =
        await _dialogService.showConfirmationDialog(
            title: 'Are you sure you want to delete the challenge?');
    if (_dialogResponse.confirmed) {
      _challengeService.deleteUChallenge(_challengeId);
      _navigationService.pushNamedAndRemoveUntil(homeViewRoute);
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
}
