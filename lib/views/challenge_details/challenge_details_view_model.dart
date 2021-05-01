import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/challenge.dart';
import 'package:dotdo/core/services/challengeService.dart';
import 'package:dotdo/views/ctask_details/ctask_details_view.dart';
import 'package:dotdo/views/new_challenge/new_challenge_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:intl/intl.dart';

class ChallengeDetailsViewModel extends BaseViewModel {
  Logger log;

  ChallengeDetailsViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
  ChallengeService _challengeService = locator<ChallengeService>();

  String _challengeId;
  String get challengeId => _challengeId;

  Challenge _challenge;
  Challenge get challenge => _challenge;

  bool _isEdit = false;
  bool get isEdit => _isEdit;

  bool _isBusy = true;
  bool get isBusy => _isBusy;

  DateTime _selectedDate;
  DateTime get selectedDate => _selectedDate;
  // Map _args;

  NavigationService _navigationService = locator<NavigationService>();

  final dateFormat = DateFormat('MMM-dd');

  Stream<DocumentSnapshot> get challengeStream =>
      _challengeService.getUChallengeStream(challengeId);

  Stream<QuerySnapshot> get tasksStream =>
      _challengeService.getDateUCTasksStream(_challengeId, _selectedDate);

  handelStartup(Map args) async {
    print(args);
    _challengeId = args['challengeId'];
    _isEdit = args['isEdit'];

    _challenge = await _challengeService.getUChallenge(_challengeId);

    if (_isEdit) {
      _selectedDate = _challenge.startDate;
    } else {
      _selectedDate = DateTime.now();
    }

    _isBusy = false;
    notifyListeners();
  }

  Future<void> toggleCompletedUTask(
      String taskId, bool currentCompleted) async {
    await _challengeService.toggleCompletedUCTask(
        taskId, _challengeId, currentCompleted);
    notifyListeners();
  }

  void updateSelectedValue({DateTime date}) {
    _selectedDate = date;
    notifyListeners();
  }

  addNewTask() {
    Map args = {
      'taskId': null,
      'challengeId': _challengeId,
      'date': _selectedDate,
      'icon': _challenge.iconData,
      'color': _challenge.iconColor,
    };
    _navigationService.navigateToView(CtaskDetailsView(args: args));
  }

  taskTapped(String taskId) async {
    Map args = {
      'taskId': taskId,
      'challengeId': _challengeId,
      'date': _selectedDate,
      'icon': null,
      'color': null,
    };
    _navigationService.navigateToView(CtaskDetailsView(args: args));
  }

  deleteUTask(String taskId) {
    _challengeService.deleteUCTask(taskId, _challengeId);
  }

  updateChallenge(Challenge newChallenge) {
    _challenge = newChallenge;
  }

  challengeTapped(String id) {
    _navigationService.navigateToView(NewChallengeView(challengeId: id));
  }

  toggleIsEdit() {
    _isEdit = !_isEdit;
    notifyListeners();
  }
}
