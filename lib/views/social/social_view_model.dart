import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/router_constants.dart';
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
    // TODO: see if this nav better
    _navigationService.navigateToView(PvpDetailsView());
  }

  PvpService _pvpService = locator<PvpService>();

  optionTest() async {
    // print('started');
    // int bbbbb = await _pvpService.optionA('lTu0PCb3C3cWiC9LP1vmsfxGMK83');
    // print('hi');
    // print(bbbbb);
  }
}
