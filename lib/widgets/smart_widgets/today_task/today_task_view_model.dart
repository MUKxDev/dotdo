import 'package:intl/intl.dart';
import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/task.dart';
import 'package:dotdo/core/services/taskService.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';

class TodayTaskViewModel extends ReactiveViewModel {
  Logger log;

  TodayTaskViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
  final dateFormat = DateFormat('MMM-dd');

  DateTime get currentDate => _taskService.date.value;
  List<Task> get allTaskList => _taskService.rxTaskList.toList();
  List<Task> get todayTaskList => allTaskList
      .where(
        (element) =>
            element.checked == false &&
            (DateTime(element.due.year, element.due.month, element.due.day) ==
                DateTime(currentDate.year, currentDate.month, currentDate.day)),
      )
      .toList();

  void removeTask(int index, String id) {
    _taskService.removeTask(id);
    notifyListeners();
  }

// TODO: add function constructer to add to list
  void addNewTask(Task task) {
    // ? should we remove the above list?
    _taskService.addTask(task);
  }

  void toggleCheckedTask(int index, Task task) {
    String id = task.id;

    removeTask(index, id);
    _taskService.toggleCheckedTask(task);
    // _taskService.addTask(newTask);
    print(todayTaskList.length);
    notifyListeners();
  }

  void onTaskTap(Task task) {
    print('task with id ${task.id} tapped');
  }

  TaskService _taskService = locator<TaskService>();
  @override
  List<ReactiveServiceMixin> get reactiveServices => [_taskService];
}
