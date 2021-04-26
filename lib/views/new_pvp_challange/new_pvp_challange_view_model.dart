import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/PChallenge.dart';
import 'package:dotdo/core/services/pvpService.dart';
import 'package:dotdo/core/services/taskService.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/views/pvp_challenge_details/pvp_challenge_details_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:intl/intl.dart';

class NewPvpChallangeViewModel extends BaseViewModel {
  Logger log;

  NewPvpChallangeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  TaskService _taskService = locator<TaskService>();
  PvpService _pvpService = locator<PvpService>();
  NavigationService _navigationService = locator<NavigationService>();
  SnackbarService _snackbarService = locator<SnackbarService>();

  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController noteController = TextEditingController(text: '');

  final dateFormat = DateFormat('yyyy-MMM-dd');
  final timeFormat = DateFormat('hh:mm a');

  String _pvpId;
  String _challengeId;
  bool get ischallengeIdNull => _challengeId == null;

  PChallenge _pChallenge;

  bool _isBusy = false;
  bool get isBusy => _isBusy;

  // bool _completed = false;

  int _noOfTasks = 0;
  // int _noOfCompletedTasks = 0;

  DateTime _startDate;
  DateTime get startDate => _startDate;

  DateTime _endDate;
  DateTime get endDate => _endDate;

  DateTime get currentDate => _taskService.date.value;
  DateTime get today => DateTime.now();
  DateTime get firstDate => DateTime(
      DateTime.now().year, DateTime.now().month, (DateTime.now().day + 2));

  IconData _iconData = FontAwesomeIcons.crosshairs;
  IconData get iconData => _iconData;

  Color _iconColor = AppColors.darkPurple;
  Color get iconColor => _iconColor;

  handelStartup(String challengeId, String pvpId) async {
    _pvpId = pvpId;
    _challengeId = challengeId;
    if (ischallengeIdNull == false) {
      _isBusy = true;
      _pChallenge = await _pvpService
          .getActiveChallenge(_pvpId)
          .first
          .then((value) => PChallenge.fromMap(value.docs.first.data()));
      nameController.text = _pChallenge.name;
      noteController.text = _pChallenge.note;
      _iconColor = _pChallenge.iconColor;
      _iconData = IconDataSolid(_pChallenge.iconData.codePoint);
      _startDate = _pChallenge.startDate;
      _endDate = _pChallenge.endDate;
      _noOfTasks = _pChallenge.noOfTasks;

      _isBusy = false;
      notifyListeners();
    } else {
      _startDate = DateTime(DateTime.now().year, DateTime.now().month,
          (DateTime.now().day + 2), 0, 0, 1);
      _endDate = DateTime(DateTime.now().year, DateTime.now().month,
          (DateTime.now().day + 2), 23, 59);
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
    PChallenge pChallenge = PChallenge(
      name: nameController.text.trim(),
      note: noteController.text.trim(),
      iconData: _iconData,
      iconColor: _iconColor,
      startDate: _startDate,
      endDate: _endDate,
      noOfTasks: _noOfTasks,
    );
    if (nameController.text.trim() != '') {
      challengeID = await _pvpService.newChallenge(_pvpId, pChallenge);
      print(challengeID);
      if (challengeID != null) {
        Map<String, dynamic> args = {
          'pvpId': _pvpId,
          'challengeId': challengeID,
          'isEdit': true,
        };
        _navigationService.navigateToView(PvpChallengeDetailsView(args: args));
      }
    } else {
      _snackbarService.showSnackbar(message: 'Challenge name is empty');
    }
  }

  save() async {
    //  PChallenge pChallenge = PChallenge(
    //   name: nameController.text.trim(),
    //   note: noteController.text.trim(),
    //   iconData: _iconData,
    //   iconColor: _iconColor,
    //   startDate: _startDate,
    //   endDate: _endDate,
    //   noOfTasks: _noOfTasks,
    // );

    // if (nameController.text.trim() != '') {
    //   await _pvpService.c(_challengeId, challenge);
    //   // Map args = {
    //   //   'challengeId': _challengeId,
    //   //   'isEdit': true,
    //   // };
    //   // _navigationService.navigateToView(challengeDetailsViewRoute, arguments: args);
    //   _navigationService.back();
    // } else {
    //   _snackbarService.showSnackbar(message: 'Challenge name is empty');
    // }
  }

  delete() {
    // _challengeService.deleteUChallenge(_challengeId);
    // _navigationService.pushNamedAndRemoveUntil(homeViewRoute);
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
