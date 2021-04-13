import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/services/challengeService.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';

class ProfileViewModel extends BaseViewModel {
  Logger log;

  ProfileViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  ChallengeService _challengeService = locator<ChallengeService>();

  Stream get getActiveUChallenge => _challengeService.getActiveUChallenge();
}
