import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/router_constants.dart';
import 'package:dotdo/core/services/challangeService.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class OneRowActiveChallangeViewModel extends BaseViewModel {
  Logger log;

  OneRowActiveChallangeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  NavigationService _navigationService = locator<NavigationService>();
  ChallangeService _challangeService = locator<ChallangeService>();

  Stream get getActiveUChallange => _challangeService.getActiveUChallange();

  challangeTapped(String id) {
    Map args = {
      'challangeId': id,
      'isEdit': false,
    };
    _navigationService.navigateTo(challangeDetailsViewRoute, arguments: args);
  }
}
