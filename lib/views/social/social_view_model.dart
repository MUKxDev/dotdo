import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/services/gRoutineService.dart';
import 'package:dotdo/core/services/pvpService.dart';
import 'package:dotdo/views/global_routine/global_routine_view.dart';
import 'package:dotdo/views/pvp_details/pvp_details_view.dart';
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
  GRoutine _gRoutineService = locator<GRoutine>();

  pvpTapped() {
    _navigationService.navigateToView(PvpDetailsView());
  }

  Stream<QuerySnapshot> get pvpsAStream => _pvpService.getAllPvpsA();
  Stream<QuerySnapshot> get pvpsBStream => _pvpService.getAllPvpsB();

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
