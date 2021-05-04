import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/PChallenge.dart';
import 'package:dotdo/core/models/User.dart';
import 'package:dotdo/core/services/gRoutineService.dart';
import 'package:dotdo/core/services/pvpService.dart';
import 'package:dotdo/core/services/userService.dart';
import 'package:dotdo/views/global_routine/global_routine_view.dart';
import 'package:dotdo/views/pvp_challenge_details/pvp_challenge_details_view.dart';
import 'package:dotdo/views/routine_details/routine_details_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class SocialViewModel extends BaseViewModel {
  Logger log;

  SocialViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  NavigationService _navigationService = locator<NavigationService>();
  PvpService _pvpService = locator<PvpService>();
  UserService _userService = locator<UserService>();
  GRoutine _gRoutineService = locator<GRoutine>();

  bool _isbusy;
  bool get isbusy => _isbusy;

  List<PChallenge> _pvpChallanges = [];
  List get pvpChallanges => _pvpChallanges;

  List _pvpChallangeUsers = [];
  List get pvpChallangeUsers => _pvpChallangeUsers;

  List _pvpPath = [];
  List get pvpPath => _pvpPath;

  handleOnStartUp() async {
    _isbusy = true;
    QuerySnapshot pvpQuerySnapshot = await _pvpService.getAllActiveUPvp();
    await getPvpChallenges(pvpQuerySnapshot: pvpQuerySnapshot);
    _isbusy = false;
  }

  getPvpChallenges({QuerySnapshot pvpQuerySnapshot}) async {
    List<PChallenge> _pCList = [];
    List _pUList = [];
    List _path = [];
    if (pvpQuerySnapshot.size >= 1) {
      for (var item in pvpQuerySnapshot.docs) {
        String _pvpId = item.data()['PvpId'];
        String _challengeId = item.data()['ChallengeId'];
        PChallenge _pChallange =
            await _pvpService.getPChallenge(_pvpId, _challengeId);
        String _userAId = await _pvpService.getUserAId(_pvpId);
        String _userBId = await _pvpService.getUserBId(_pvpId);
        User _userA = await _userService.getUserProfile(_userAId);
        User _userB = await _userService.getUserProfile(_userBId);

        if (_pChallange != null && _userA != null && _userB != null) {
          _pCList.add(_pChallange);
          _pUList.add([_userA, _userB]);
          _path.add([_pvpId, _challengeId]);
        }
      }
      _pvpChallanges = _pCList;
      _pvpChallangeUsers = _pUList;
      _pvpPath = _path;
    }
    notifyListeners();
  }

  challengeTapped({String pvpId, String challengeID}) {
    Map<String, dynamic> args = {
      'pvpId': pvpId,
      'challengeId': challengeID,
      'isEdit': false,
      'isReadOnly': false,
    };
    _navigationService.navigateToView(PvpChallengeDetailsView(args: args));
  }

  Stream<QuerySnapshot> get topLikedRoutinesStream =>
      _gRoutineService.getAllGRoutine();
  Stream<QuerySnapshot> get yourPublicRoutinesStream =>
      _gRoutineService.getUGRoutine();

  // challengeTapped(String challengeID) {
  //   Map<String, dynamic> args = {
  //     'pvpId': _pvpId,
  //     'challengeId': challengeID,
  //     'isEdit': false,
  //     'isReadOnly': false,
  //   };
  //   _navigationService.navigateToView(PvpChallengeDetailsView(args: args));
  // }

  routineTapped(String gRoutineId) {
    _navigationService.navigateToView(GlobalRoutineView(
      gRoutineId: gRoutineId,
    ));
  }

  yourPublicRoutineTapped(String id) {
    Map args = {
      'routineId': id,
      'isEdit': false,
    };
    _navigationService.navigateToView(RoutineDetailsView(args: args));
  }
}
