import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/services/challangeService.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';

class ProfileViewModel extends BaseViewModel {
  Logger log;

  ProfileViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  ChallangeService _challangeService = locator<ChallangeService>();

  Stream get stream => _challangeService.getActiveUChallange();
}
