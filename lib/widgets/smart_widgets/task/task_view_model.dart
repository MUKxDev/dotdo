import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';

class TaskViewModel extends BaseViewModel {
  Logger log;

  TaskViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
