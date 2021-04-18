import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';

class PvpChallengeDetailsViewModel extends BaseViewModel {
  Logger log;

  PvpChallengeDetailsViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  handelStartup(Map args) {
    print(args.toString());
  }
}
