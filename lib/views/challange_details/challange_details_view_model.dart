import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/challange.dart';
import 'package:dotdo/core/models/task.dart';
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

  int _numberOfDays;
  int get numberOfDays => _numberOfDays;

  double _prograssBarValue = 0;
  double get prograssBarValue => _prograssBarValue;

  bool _isEdit = false;
  bool get isEdit => _isEdit;

  bool _isBusy = true;
  bool get isBusy => _isBusy;

  DateTime _selectedDate;
  DateTime get selectedDate => _selectedDate;
  // Map _args;

  handelStartup(Map args) async {
    _challangeId = args['challangeId'];
    _isEdit = args['isEdit'];
    _selectedDate = _challange.startDate;
    _isBusy = false;
    notifyListeners();
  }

  void updateSelectedValue({DateTime date}) {
    _selectedDate = date;
    notifyListeners();
  }

  addNewTask() async {
    await _challangeService.addUCTask(
        _challangeId,
        Task(
            taskName: 'hi: $_selectedDate',
            dueDate: DateTime(_selectedDate.year, _selectedDate.month,
                _selectedDate.day, 23, 59, 59),
            completed: false,
            iconColor: _challange.iconColor,
            iconData: _challange.iconData,
            taskNote: 'note'),
        _challange.noOfTasks);
    // _challange = await _challangeService.getUChallange(_challangeId);
    toggleCompleteedChallange();
    notifyListeners();
  }

  NavigationService _navigationService = locator<NavigationService>();

  final dateFormat = DateFormat('MMM-dd');

  Stream<DocumentSnapshot> get challangeStream =>
      _challangeService.getUChallangeStream(challangeId);

  Stream<QuerySnapshot> get tasksStream =>
      _challangeService.getDateUCTasksStream(_challangeId, _selectedDate);

  Future<void> toggleCompletedUTask(
      String taskId, bool currentCompleted) async {
    await _challangeService.toggleCompletedUCTask(
        taskId, _challangeId, currentCompleted, _challange.noOfCompletedTasks);
    toggleCompleteedChallange();
    notifyListeners();
  }

  taskTapped(String taskId) async {
    // _navigationService.navigateTo(taskDetailsViewRoute, arguments: taskId);
  }

  void deleteUTask(String taskId) {
    // _challangeService.(taskId);
  }

  updateChallange(Challange newChallange) {
    _challange = newChallange;
  }

  toggleCompleteedChallange() {
    if (_challange.noOfTasks != _challange.noOfCompletedTasks ||
        _challange.noOfTasks == 0) {
      _challangeService.toggleCompletedUChalllange(challangeId, false);
    } else {
      _challangeService.toggleCompletedUChalllange(challangeId, true);
    }
  }
}
