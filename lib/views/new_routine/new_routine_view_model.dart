import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/Routine.dart';
import 'package:dotdo/core/router_constants.dart';
import 'package:dotdo/core/services/routineService.dart';
import 'package:dotdo/theme/colors.dart';
import 'package:dotdo/views/routine_details/routine_details_view.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class NewRoutineViewModel extends BaseViewModel {
  Logger log;

  NewRoutineViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  RoutineService _routineService = locator<RoutineService>();
  NavigationService _navigationService = locator<NavigationService>();
  SnackbarService _snackbarService = locator<SnackbarService>();

  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController noteController = TextEditingController(text: '');

  String _routineId;
  bool get isroutineIdNull => _routineId == null;

  Routine _routine;

  bool _isBusy = false;
  bool get isBusy => _isBusy;

  bool _active = true;
  bool get active => _active;

  int _noOfTasks = 0;
  int _noOfCompletedTasks = 0;
  int _noOfLikes = 0;

  IconData _iconData = FontAwesomeIcons.crosshairs;
  IconData get iconData => _iconData;

  Color _iconColor = AppColors.darkPurple;
  Color get iconColor => _iconColor;

  handelStartup(String routineId) async {
    _routineId = routineId;
    if (isroutineIdNull == false) {
      _isBusy = true;
      _routine = await _routineService.getURoutine(_routineId);
      nameController.text = _routine.name;
      noteController.text = _routine.note;
      _iconColor = _routine.iconColor;
      _iconData = IconDataSolid(_routine.iconData.codePoint);

      _active = _routine.active;
      _noOfTasks = _routine.noOfTasks;
      _noOfCompletedTasks = _routine.noOfCompletedTasks;
      _noOfLikes = _routine.noOfLikes;

      _isBusy = false;
      notifyListeners();
    }
  }

  cancel() {
    _navigationService.back();
  }

  next() async {
    String routineID;
    Routine routine = Routine(
      name: nameController.text.trim(),
      note: noteController.text.trim(),
      iconData: _iconData,
      iconColor: _iconColor,
      active: _active,
      noOfTasks: _noOfTasks,
      noOfCompletedTasks: _noOfCompletedTasks,
      noOfLikes: _noOfLikes,
    );
    if (nameController.text.trim() != '') {
      routineID = await _routineService.addRoutine(routine);
      print(routineID);
      if (routineID != null) {
        Map<String, dynamic> args = {
          'routineId': routineID,
          'isEdit': true,
        };
        _navigationService.navigateToView(RoutineDetailsView(args: args));
      }
    } else {
      _snackbarService.showSnackbar(message: 'Routine name is empty');
    }
  }

  save() async {
    Routine routine = Routine(
      name: nameController.text.trim(),
      note: noteController.text.trim(),
      iconData: _iconData,
      iconColor: _iconColor,
      active: _active,
      noOfTasks: _noOfTasks,
      noOfCompletedTasks: _noOfCompletedTasks,
      noOfLikes: _noOfLikes,
    );

    if (nameController.text.trim() != '') {
      await _routineService.updateRotine(routine, _routineId);
      _navigationService.back();
    } else {
      _snackbarService.showSnackbar(message: 'Routine name is empty');
    }
  }

  delete() {
    _routineService.deleteRoutine(_routineId);
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

  void updateActive(bool isActive) {
    _active = isActive;
    _routineService.activation(_routineId, !isActive);
    notifyListeners();
  }
}
