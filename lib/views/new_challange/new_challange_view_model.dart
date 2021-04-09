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

  TextEditingController nameController = TextEditingController(text: '');
  TextEditingController noteController = TextEditingController(text: '');

  String _type = 'Private';
  String get type => _type;

  List<String> _typeList = ['Private', 'PVP', 'Group'];
  List<String> get typeList => _typeList;

  final dateFormat = DateFormat('yyyy-MMM-dd');
  final timeFormat = DateFormat('hh:mm a');

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

  // List<IconData> iconDataList = [];
  // List<Color> iconColorList = [
  //   Color(value),
  // ];

  handelStartup() {
    _startDate = DateTime(currentDate.year, currentDate.month, currentDate.day);
    _endDate =
        DateTime(currentDate.year, currentDate.month, currentDate.day, 23, 59);
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

  cancel() {}
  next() async {
    String challangeID;
    Challange challange = Challange(
      name: nameController.text.trim(),
      note: noteController.text.trim(),
      iconData: _iconData,
      iconColor: _iconColor,
      startDate: _startDate,
      endDate: _endDate,
      completed: false,
      noOfTasks: 0,
      noOfCompletedTasks: 0,
    );
    challangeID = await _challangeService.addUChallange(challange);
    if (challangeID != null) {
      Map args = {
        'challangeId': challangeID,
        'isEdit': true,
      };
      _navigationService.navigateTo(challangeDetailsViewRoute, arguments: args);
    } else {}
    print(challangeID);
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
