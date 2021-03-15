import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';

class GroupChallangeViewModel extends BaseViewModel {
  Logger log;

  GroupChallangeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
