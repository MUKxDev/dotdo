import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/router_constants.dart';
import 'package:dotdo/core/services/challengeService.dart';
import 'package:dotdo/views/challenge_details/challenge_details_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class OneRowActiveChallengeViewModel extends BaseViewModel {
  Logger log;

  OneRowActiveChallengeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  NavigationService _navigationService = locator<NavigationService>();
  ChallengeService _challengeService = locator<ChallengeService>();

  Stream get getActiveUChallenge => _challengeService.getActiveUChallenge();

  challengeTapped(String id) {
    Map args = {
      'challengeId': id,
      'isEdit': false,
    };
    _navigationService.navigateToView(ChallengeDetailsView(args: args));
  }
}
