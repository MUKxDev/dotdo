import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/Routine.dart';
import 'package:dotdo/core/models/User.dart';
import 'package:dotdo/core/services/authService.dart';
import 'package:dotdo/core/services/gRoutineService.dart';
import 'package:dotdo/core/services/userService.dart';
import 'package:dotdo/views/another_profile/another_profile_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class GlobalRoutineViewModel extends BaseViewModel {
  Logger log;

  GlobalRoutineViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  GRoutine _gRoutineService = locator<GRoutine>();
  UserService _userService = locator<UserService>();
  AuthService _authService = locator<AuthService>();
  NavigationService _navigationService = locator<NavigationService>();
  SnackbarService _snackbarService = locator<SnackbarService>();

  String _gRoutineId;
  String get gRoutineId => _gRoutineId;

  Routine _routine;
  Routine get routine => _routine;

  User _user;
  User get user => _user;

  bool _isBusy = true;
  bool get isBusy => _isBusy;

  bool _isAddedGRotine = false;
  bool get isAddedGRotine => _isAddedGRotine;

  bool _isLiked = false;
  bool get isLiked => _isLiked;

  Stream<DocumentSnapshot> get routineStream =>
      _gRoutineService.getGRoutineStream(gRoutineId);

  Stream<QuerySnapshot> get tasksStream =>
      _gRoutineService.getGRTasks(_gRoutineId);

  handelStartup(String gRoutineId) async {
    _gRoutineId = gRoutineId;

    _routine = await _gRoutineService.getGRoutine(_gRoutineId);
    _user = await _userService.getUserProfile(_routine.creatorId);
    _isLiked = await _gRoutineService.getLikeStatus(_gRoutineId);
    _isAddedGRotine = await _gRoutineService.isAddedGRoutine(_gRoutineId);

    _isBusy = false;
    notifyListeners();
  }

  userTapped() async {
    String currentUserId = await _authService.getCurrentUserId();
    if (currentUserId == _routine.creatorId) {
      _snackbarService.showSnackbar(
          message: 'You can\'t view your profile from here');
    } else {
      _navigationService.navigateToView(AnotherProfileView(
        uid: _routine.creatorId,
      ));
    }
  }

  updateRoutine(Routine newRoutine) {
    _routine = newRoutine;
  }

  toggleIsLiked() async {
    await _gRoutineService.toggleLike(_gRoutineId);
    _isLiked = await _gRoutineService.getLikeStatus(_gRoutineId);

    notifyListeners();
  }

  toggleIsAddedGRoutine() async {
    if (_isAddedGRotine) {
      _snackbarService.showSnackbar(message: 'You already have this routine');
    } else {
      await _gRoutineService.saveGRoutine(_gRoutineId);

      _isAddedGRotine = !_isAddedGRotine;
      _snackbarService.showSnackbar(message: 'The routine is added to you');
      notifyListeners();
    }
  }
}
