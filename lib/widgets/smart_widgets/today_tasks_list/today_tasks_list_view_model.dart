import 'package:dotdo/views/task_details/task_details_view.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/services/taskService.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class TodayTasksListViewModel extends ReactiveViewModel {
  Logger log;

  TodayTasksListViewModel() {
    log = getLogger(this.runtimeType.toString());
  }

  TaskService _taskService = locator<TaskService>();
  NavigationService _navigationService = locator<NavigationService>();

  DateTime get currentDate => _taskService.date.value;
  final dateFormat = DateFormat('MMM-dd');

  Stream<QuerySnapshot> get stream =>
      _taskService.getDateUTasksStream(currentDate);

  void toggleCompletedUTask(String taskId, bool currentCompleted) {
    _taskService.toggleCompletedUTask(taskId, currentCompleted);
  }

  taskTapped(String taskId) async {
    _navigationService.navigateToView(TaskDetailsView(taskId: taskId));
  }

  void deleteUTask(String taskId) {
    _taskService.deleteUTask(taskId);
  }

  handleOnStartup() {
    refreshDate();
  }

  void refreshDate() {
    DateTime _date;
    int _dateNow = DateTime.now().millisecondsSinceEpoch;
    int _dateSelected =
        DateTime(currentDate.year, currentDate.month, currentDate.day, 23, 59)
            .millisecondsSinceEpoch;
    if (_dateNow > _dateSelected) {
      _date = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 1);
      _taskService.updateDate(_date);
      print('Date refreshed: $_date');
      notifyListeners();
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_taskService];
}
