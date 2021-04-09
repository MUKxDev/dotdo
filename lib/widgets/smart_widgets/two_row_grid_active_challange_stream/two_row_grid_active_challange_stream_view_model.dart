import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/router_constants.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class TwoRowGridActiveChallangeStreamViewModel extends BaseViewModel {
  Logger log;

  TwoRowGridActiveChallangeStreamViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  NavigationService _navigationService = locator<NavigationService>();

  handleStartUp() {}

  challangeTapped(String id) {
    Map args = {
      'challangeId': id,
      'isEdit': false,
    };
    _navigationService.navigateTo(challangeDetailsViewRoute, arguments: args);
  }
}
