import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/router_constants.dart';
import 'package:dotdo/core/services/taskService.dart';
import 'package:dotdo/views/task_details/task_details_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class TaskListViewModel extends BaseViewModel {
  Logger log;
  TaskListViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  TaskService _taskService = locator<TaskService>();
  NavigationService _navigationService = locator<NavigationService>();

  Stream<QuerySnapshot> get stream => _taskService.getUpComingUTasksStream();

  void toggleCompletedUTask(String taskId, bool currentCompleted) {
    _taskService.toggleCompletedUTask(taskId, currentCompleted);
  }

  taskTapped(String taskId) async {
    _navigationService.navigateToView(TaskDetailsView(taskId: taskId));
  }

  void deleteUTask(String taskId) {
    _taskService.deleteUTask(taskId);
  }
}
