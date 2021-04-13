import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';

class ActiveChallengeCardViewModel extends BaseViewModel {
  Logger log;

  ActiveChallengeCardViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
