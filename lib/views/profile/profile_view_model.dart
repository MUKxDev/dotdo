import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/User.dart';
import 'package:dotdo/core/models/uGeneral.dart';
import 'package:dotdo/core/services/authService.dart';
import 'package:dotdo/core/services/challengeService.dart';
import 'package:dotdo/core/services/routineService.dart';
import 'package:dotdo/core/services/userService.dart';
import 'package:dotdo/views/pvp_details/pvp_details_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileViewModel extends BaseViewModel {
  Logger log;

  ProfileViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  ChallengeService _challengeService = locator<ChallengeService>();
  RoutineService _routineService = locator<RoutineService>();
  AuthService _authService = locator<AuthService>();
  UserService _userService = locator<UserService>();
  NavigationService _navigationService = locator<NavigationService>();

  String _userId;
  String get userId => _userId;

  bool _isBusy;
  bool get isBusy => _isBusy;

  bool _isCurrentUser;
  bool get isCurrentUser => _isCurrentUser;

  bool _haveLastBadge = false;
  bool get haveLastBadge => _haveLastBadge;

  User _user;
  User get user => _user;

  UGeneral _userGeneral;
  UGeneral get userGeneral => _userGeneral;

  Stream get getActiveUChallenge => _challengeService.getActiveUChallenge();
  Stream get getURoutines => _routineService.getAllURoutines();

  handleOnStartup(String uid) async {
    _isBusy = true;
    if (uid == null) {
      _userId = await _authService.getCurrentUserId();
      _isCurrentUser = true;
    } else {
      _userId = uid;
      _isCurrentUser = false;
    }
    _user = await _userService.getUserProfile(_userId);
    _userGeneral = await _userService.getUserGeneral(_userId);
    _haveLastBadge = _userGeneral.lastBadge == '' ? false : true;
    _isBusy = false;
    notifyListeners();
  }

  pvpTapped() {
    _navigationService.navigateToView(PvpDetailsView(
      oppId: _userId,
    ));
  }
}
