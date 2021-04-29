import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/PChallenge.dart';
import 'package:dotdo/core/models/User.dart';
import 'package:dotdo/core/services/pvpService.dart';
import 'package:dotdo/core/services/userService.dart';
import 'package:dotdo/views/new_pvp_challange/new_pvp_challange_view.dart';
import 'package:dotdo/views/p_c_task_details/p_c_task_details_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:intl/intl.dart';

class PvpChallengeDetailsViewModel extends BaseViewModel {
  Logger log;

  PvpChallengeDetailsViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  PvpService _pvpService = locator<PvpService>();
  UserService _userService = locator<UserService>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  NavigationService _navigationService = locator<NavigationService>();

  String _challengeId;
  String get challengeId => _challengeId;

  String _pvpId;
  String get pvpId => _pvpId;

  PChallenge _challenge;
  PChallenge get challenge => _challenge;

  String _userAId;
  String get userAId => _userAId;

  String _userBId;
  String get userBId => _userBId;

  User _userA;
  User get userA => _userA;

  User _userB;
  User get userB => _userB;

  bool _isEdit = false;
  bool get isEdit => _isEdit;

  bool _isReadOnly = false;
  bool get isReadOnly => _isReadOnly;

  bool _isBusy = true;
  bool get isBusy => _isBusy;

  DateTime _selectedDate;
  DateTime get selectedDate => _selectedDate;

  final dateFormat = DateFormat('MMM-dd');

  Stream<QuerySnapshot> get challengeStream => (_isEdit || _isReadOnly)
      ? _pvpService.getPendingChallenge(_pvpId).first.asStream()
      : _pvpService.getActiveChallenge(_pvpId).first.asStream();

  Stream<QuerySnapshot> get tasksStream =>
      _pvpService.getPCTask(_pvpId, _challengeId);

  handelStartup(Map args) async {
    _isBusy = true;
    print(args);
    _pvpId = args['pvpId'];
    _challengeId = args['challengeId'];
    _isEdit = args['isEdit'];
    _isReadOnly = args['isReadOnly'];
    _userAId = await _pvpService.getUserAId(_pvpId);
    _userBId = await _pvpService.getUserBId(_pvpId);

    _userA = await _userService.getUserProfile(_userAId);
    _userB = await _userService.getUserProfile(_userBId);

    if (_isEdit || _isReadOnly) {
      _challenge = PChallenge.fromMap(await _pvpService
          .getPendingChallenge(_pvpId)
          .first
          .then((value) => value.docs.first.data()));
      _selectedDate = _challenge.startDate;
    } else {
      _challenge = PChallenge.fromMap(await _pvpService
          .getActiveChallenge(_pvpId)
          .first
          .then((value) => value.docs.first.data()));
      _selectedDate = DateTime.now();
    }
    _isBusy = false;
    notifyListeners();
  }

  Future<void> toggleCompletedUTask(String taskId) async {
    await _pvpService.toggleCompletePCtask(_pvpId, _challengeId, taskId);
    notifyListeners();
  }

  void updateSelectedValue({DateTime date}) {
    _selectedDate = date;
    notifyListeners();
  }

  addNewTask() {
    Map args = {
      'pvpId': _pvpId,
      'taskId': null,
      'challengeId': _challengeId,
      'date': _selectedDate,
      'icon': _challenge.iconData,
      'color': _challenge.iconColor,
    };
    _navigationService.navigateToView(PCTaskDetailsView(args: args));
  }

  taskTapped(String taskId) async {
    Map args = {
      'pvpId': _pvpId,
      'taskId': taskId,
      'challengeId': _challengeId,
      'date': _selectedDate,
      'icon': null,
      'color': null,
    };
    _navigationService.navigateToView(PCTaskDetailsView(args: args));
  }

  updateChallenge(PChallenge newChallenge) {
    _challenge = newChallenge;
  }

  challengeTapped(String id) {
    if (_isEdit || _isReadOnly) {
      _snackbarService.showSnackbar(message: 'Can\'t view at the moment');
    } else {
      _navigationService.navigateToView(NewPvpChallangeView(
        challengeId: id,
        pvpId: _pvpId,
        isReadOnly: true,
      ));
    }
  }

  toggleIsEdit() {
    _isEdit = !_isEdit;
    notifyListeners();
  }
}
