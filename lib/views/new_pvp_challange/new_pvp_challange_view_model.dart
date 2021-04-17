import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';

class NewPvpChallangeViewModel extends BaseViewModel {
  Logger log;

  NewPvpChallangeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
