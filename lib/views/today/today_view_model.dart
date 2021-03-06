import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/task.dart';
import 'package:dotdo/core/router_constants.dart';
import 'package:dotdo/core/services/taskService.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class TodayViewModel extends BaseViewModel {
  Logger log;
  String _title = 'Today';
  String get title => _title;

  List<Task> getTaskList() => _taskService.taskList;

  void removeTask(int index) {
    _taskService.taskList.removeAt(index);
    notifyListeners();
  }

  void addTaskAtIndex(int index, Task task) {
    _taskService.taskList.insert(index, task);
    notifyListeners();
  }

  void addNewTask() {}

  void toggleCheckedTask(int index) {
    bool checked = _taskService.taskList[index].checked;
    Task task = _taskService.taskList[index].copyWith(checked: !checked);
    removeTask(index);
    addTaskAtIndex(index, task);
    notifyListeners();
  }

  void onTaskTap(index) {
    print('task $index tapped');
  }

  // AuthService _authService = locator<AuthService>();
  NavigationService _navigationService = locator<NavigationService>();
  TaskService _taskService = locator<TaskService>();

  TodayViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  void logout() {
    FirebaseAuthenticationService().logout();
    _navigationService.pushNamedAndRemoveUntil(loginViewRoute);
  }
}
