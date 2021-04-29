import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/User.dart';
import 'package:dotdo/core/services/pvpService.dart';
import 'package:dotdo/core/services/userService.dart';
import 'package:dotdo/views/pvp_challenge_details/pvp_challenge_details_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class PvpHistoryViewModel extends BaseViewModel {
  Logger log;

  PvpHistoryViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  PvpService _pvpService = locator<PvpService>();
  UserService _userService = locator<UserService>();
  NavigationService _navigationService = locator<NavigationService>();
  // SnackbarService _snackbarService = locator<SnackbarService>();

  bool _isBusy;
  bool get isBusy => _isBusy;

  String _pvpId;
  String get pvpId => _pvpId;

  String _userAId;
  String get userAId => _userAId;

  String _userBId;
  String get userBId => _userBId;

  User _userA;
  User get userA => _userA;

  User _userB;
  User get userB => _userB;

  Stream get completedChallangeStream =>
      _pvpService.getCompletedChallenge(_pvpId);

  handleOnStartup(String pvpId) async {
    _isBusy = true;
    _pvpId = pvpId;

    _userAId = await _pvpService.getUserAId(_pvpId);
    _userBId = await _pvpService.getUserBId(_pvpId);

    _userA = await _userService.getUserProfile(_userAId);
    _userB = await _userService.getUserProfile(_userBId);

    _isBusy = false;
    notifyListeners();
  }

  // challengeTapped(String challengeID) {
  //   Map args = {
  //     'pvpId': _pvpId,
  //     'challengeId': challengeID,
  //     'isEdit': false,
  //     'isReadOnly': true,
  //   };
  //   _navigationService.navigateToView(PvpChallengeDetailsView(args: args));
  // }

}
