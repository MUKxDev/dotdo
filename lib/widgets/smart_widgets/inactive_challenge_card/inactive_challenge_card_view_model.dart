import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';

class InactiveChallengeCardViewModel extends BaseViewModel {
  Logger log;

  InactiveChallengeCardViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
  String capitalize(String s) => s[0].toUpperCase() + s.substring(1);
}
