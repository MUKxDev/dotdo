import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';

class PvpchallangeViewModel extends BaseViewModel {
  Logger log;

  PvpchallangeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
