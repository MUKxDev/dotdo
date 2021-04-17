import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';

class AnotherProfileViewModel extends BaseViewModel {
  Logger log;

  AnotherProfileViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
