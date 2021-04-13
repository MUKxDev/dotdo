import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';

class NewRoutineViewModel extends BaseViewModel {
  Logger log;

  NewRoutineViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
