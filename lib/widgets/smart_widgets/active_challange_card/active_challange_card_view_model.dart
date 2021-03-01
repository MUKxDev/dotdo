import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';

class ActiveChallangeCardViewModel extends BaseViewModel {
  Logger log;

  ActiveChallangeCardViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
}
