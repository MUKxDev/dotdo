import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';

class DatepickerViewModel extends BaseViewModel {
  Logger log;
  DateTime _selectedDate = DateTime.now();

  DatepickerViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  // final _dateService = locator<DateService>();

  void updateSelectedValue({date}) {
    _selectedDate = date;
    print(_selectedDate);
    // _dateService.updateSelectedValue(date: date);
    notifyListeners();
  }
}
