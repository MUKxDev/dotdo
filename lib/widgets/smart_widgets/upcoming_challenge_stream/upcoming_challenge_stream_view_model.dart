import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/router_constants.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class UpcomingChallengeStreamViewModel extends BaseViewModel {
  Logger log;

  UpcomingChallengeStreamViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  NavigationService _navigationService = locator<NavigationService>();

  handleStartUp() {}

  challengeTapped(String id) {
    Map args = {
      'challengeId': id,
      'isEdit': false,
    };
    _navigationService.navigateTo(challengeDetailsViewRoute, arguments: args);
  }
}
