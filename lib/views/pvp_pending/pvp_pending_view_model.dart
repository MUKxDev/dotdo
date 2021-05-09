import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/User.dart';
import 'package:dotdo/core/services/pvpService.dart';
import 'package:dotdo/core/services/userService.dart';
import 'package:dotdo/views/pvp_challenge_details/pvp_challenge_details_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class PvpPendingViewModel extends BaseViewModel {
  Logger log;

  PvpPendingViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  PvpService _pvpService = locator<PvpService>();
  UserService _userService = locator<UserService>();
  NavigationService _navigationService = locator<NavigationService>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  DialogService _dialogService = locator<DialogService>();

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

  Stream get pendingChallangeStream => _pvpService.getPendingChallenge(_pvpId);

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

  challengeTapped(String challengeID) {
    Map args = {
      'pvpId': _pvpId,
      'challengeId': challengeID,
      'isEdit': false,
      'isReadOnly': true,
    };
    _navigationService.navigateToView(PvpChallengeDetailsView(args: args));
  }

  accept(String challengeId) async {
    bool isThereActiveChallange =
        await _pvpService.isThereActiveChallange(_pvpId);
    if (isThereActiveChallange) {
      _snackbarService.showSnackbar(message: 'There is an active challenge.');
    } else {
      String status;
      status = await _pvpService.getUserStatus(_pvpId, challengeId);
      print(status);
      if (status.toLowerCase() == 'pending') {
        _pvpService.toggleAccept(pvpId, challengeId);
        _snackbarService.showSnackbar(message: 'Challenge accepted');
      } else {
        _snackbarService.showSnackbar(
            message: 'You have already accepted this challenge');
      }
    }
  }

  decline(String challengeId) async {
    DialogResponse _dialogResponse =
        await _dialogService.showConfirmationDialog(
            title: 'Are you sure you want to decline the pvp?');
    if (_dialogResponse.confirmed) {
      _pvpService.toggleDecline(pvpId, challengeId);
    }
  }
}
