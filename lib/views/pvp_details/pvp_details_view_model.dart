import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/User.dart';
import 'package:dotdo/core/models/uGeneral.dart';
import 'package:dotdo/core/services/pvpService.dart';
import 'package:dotdo/core/services/userService.dart';
import 'package:dotdo/views/new_pvp_challange/new_pvp_challange_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class PvpDetailsViewModel extends BaseViewModel {
  Logger log;

  PvpDetailsViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  PvpService _pvpService = locator<PvpService>();
  UserService _userService = locator<UserService>();
  NavigationService _navigationService = locator<NavigationService>();

  bool _isBusy;
  bool get isBusy => _isBusy;

  String _pvpId;
  String get pvpId => _pvpId;

  String _userAId;
  String get userAId => _userAId;

  String _userBId;
  String get userBId => _userBId;

  String _oppId;
  String get oppId => _oppId;

  User _userA;
  User get userA => _userA;

  User _userB;
  User get userB => _userB;

  UGeneral _userAGeneral;
  UGeneral get userAGeneral => _userAGeneral;

  UGeneral _userBGeneral;
  UGeneral get userBGeneral => _userBGeneral;

  Stream get pvpCardStream => _pvpService.creatOrViewPvp(_oppId);
  Stream get activeChallangeStream => _pvpService.getActiveChallenge(_pvpId);

  handleOnStartup(String oppId) async {
    _isBusy = true;
    _oppId = oppId;
    _pvpId = await _pvpService.getPvpId(oppId);

    _userAId = await _pvpService.getUserAId(_pvpId);
    _userBId = await _pvpService.getUserBId(_pvpId);

    _userA = await _userService.getUserProfile(_userAId);
    _userB = await _userService.getUserProfile(_userBId);

    _userAGeneral = await _userService.getUserGeneral(_userAId);
    _userBGeneral = await _userService.getUserGeneral(_userBId);

    _isBusy = false;
    notifyListeners();
  }

  newChallengeTapped() {
    _navigationService.navigateToView(NewPvpChallangeView(pvpId: _pvpId));
  }

  challengeTapped() {}

  historyTapped() {}
}
