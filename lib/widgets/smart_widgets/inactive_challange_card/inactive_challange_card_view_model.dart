import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';

class InactiveChallangeCardViewModel extends BaseViewModel {
  Logger log;

  InactiveChallangeCardViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
