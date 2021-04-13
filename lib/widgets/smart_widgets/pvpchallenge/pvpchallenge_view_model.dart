import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';

class PvpchallengeViewModel extends BaseViewModel {
  Logger log;

  PvpchallengeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
