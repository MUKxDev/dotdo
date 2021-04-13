import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';

class GroupChallengeViewModel extends BaseViewModel {
  Logger log;

  GroupChallengeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
