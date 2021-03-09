import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/task.dart';
import 'package:dotdo/core/services/taskService.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';

class TodayTaskViewModel extends ReactiveViewModel {
  Logger log;

  TodayTaskViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  List<Task> get todayTaskList => _taskService.rxTaskList.toList();
  GlobalKey<AnimatedListState> get globalKey => _taskService.todayTaskListKey;

  void removeTask(int index, String id) {
    _taskService.removeTask(id);
    globalKey.currentState
        .removeItem(index, (context, animation) => Container());
    notifyListeners();
  }

// TODO: add function constructer to add to list
  void addNewTask(Task task) {
    // ? should we remove the above list?
    _taskService.addTask(task);
    globalKey.currentState.insertItem(0);
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
  // TODO: implement reactiveServices
  List<ReactiveServiceMixin> get reactiveServices => [_taskService];
}
