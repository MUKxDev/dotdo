import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/services/pvpService.dart';
import 'package:dotdo/views/pvp_details/pvp_details_view.dart';
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

  pvpTapped() {
    _navigationService.navigateToView(PvpDetailsView());
  }

  PvpService _pvpService = locator<PvpService>();

  Stream<QuerySnapshot> get pvpsAStream => _pvpService.getAllPvpsA();
  Stream<QuerySnapshot> get pvpsBStream => _pvpService.getAllPvpsB();

  // challengeTapped(String challengeID) {
  //   Map<String, dynamic> args = {
  //     'pvpId': _pvpId,
  //     'challengeId': challengeID,
  //     'isEdit': false,
  //     'isReadOnly': false,
  //   };
  //   _navigationService.navigateToView(PvpChallengeDetailsView(args: args));
  // }
}
