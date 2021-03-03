import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';

class SocialViewModel extends BaseViewModel {
  Logger log;

  SocialViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
