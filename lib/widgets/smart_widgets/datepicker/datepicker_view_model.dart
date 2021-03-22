import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/services/taskService.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';

class DatepickerViewModel extends ReactiveViewModel {
  Logger log;
  // DateTime _selectedDate = DateTime.now();
  DateTime get currentDate => _taskService.date.value;

  DatepickerViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  TaskService _taskService = locator<TaskService>();

  void updateSelectedValue({date}) {
    _taskService.updateDate(date);
    // _selectedDate = date;
    print(currentDate);
    notifyListeners();
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_taskService];
}
