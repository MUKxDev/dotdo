import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/challange.dart';
import 'package:dotdo/core/models/task.dart';
import 'package:dotdo/core/router_constants.dart';
import 'package:dotdo/core/services/challangeService.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:intl/intl.dart';

class ChallangeDetailsViewModel extends BaseViewModel {
  Logger log;

  ChallangeDetailsViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
  ChallangeService _challangeService = locator<ChallangeService>();

  String _challangeId;
  String get challangeId => _challangeId;

  Challange _challange;
  Challange get challange => _challange;

  bool _isEdit = false;
  bool get isEdit => _isEdit;

  bool _isBusy = true;
  bool get isBusy => _isBusy;

  DateTime _selectedDate;
  DateTime get selectedDate => _selectedDate;
  // Map _args;

  NavigationService _navigationService = locator<NavigationService>();

  final dateFormat = DateFormat('MMM-dd');

  Stream<DocumentSnapshot> get challangeStream =>
      _challangeService.getUChallangeStream(challangeId);

  Stream<QuerySnapshot> get tasksStream =>
      _challangeService.getDateUCTasksStream(_challangeId, _selectedDate);

  handelStartup(Map args) async {
    print(args);
    _challangeId = args['challangeId'];
    _isEdit = args['isEdit'];

    _challange = await _challangeService.getUChallange(_challangeId);

    _selectedDate = _challange.startDate;

    _isBusy = false;
    notifyListeners();
  }

  Future<void> toggleCompletedUTask(
      String taskId, bool currentCompleted) async {
    await _challangeService.toggleCompletedUCTask(
        taskId, _challangeId, currentCompleted);
    notifyListeners();
  }

  void updateSelectedValue({DateTime date}) {
    _selectedDate = date;
    notifyListeners();
  }

  addNewTask() {
    Map args = {
      'taskId': null,
      'challangeId': _challangeId,
      'date': _selectedDate,
      'icon': _challange.iconData,
      'color': _challange.iconColor,
    };
    _navigationService.navigateTo(ctaskDetailsViewRoute, arguments: args);
  }

  taskTapped(String taskId) async {
    Map args = {
      'taskId': taskId,
      'challangeId': _challangeId,
      'date': _selectedDate,
      'icon': null,
      'color': null,
    };
    _navigationService.navigateTo(ctaskDetailsViewRoute, arguments: args);
  }

  deleteUTask(String taskId) {
    _challangeService.deleteUCTask(taskId, _challangeId);
  }

  updateChallange(Challange newChallange) {
    _challange = newChallange;
  }

  challangeTapped(String id) {
    _navigationService.navigateTo(newChallangeViewRoute, arguments: id);
  }
}
