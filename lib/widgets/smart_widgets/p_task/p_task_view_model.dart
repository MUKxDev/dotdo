import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:intl/intl.dart';

class PTaskViewModel extends BaseViewModel {
  Logger log;

  PTaskViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  final dateFormat = DateFormat('MMM-dd');
  final timeFormat = DateFormat('hh:mm a');
}
