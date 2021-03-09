import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/task.dart';
import 'package:dotdo/core/services/taskService.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';

class TaskListViewModel extends ReactiveViewModel {
  Logger log;
  TaskListViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
  final globalKey = GlobalKey<AnimatedListState>();

  void removeTask(int index, String id) {
    _taskService.removeTask(id);
    globalKey.currentState
        .removeItem(index, (context, animation) => Container());
    notifyListeners();
  }

// TODO: add function constructer to add to list
  void addNewTask(Task task, List<Task> list) {
    // ? should we remove the above list?
    _taskService.addTask(task);
    globalKey.currentState.insertItem(0);
  }

  void toggleCheckedTask(int index, Task task) {
    String id = task.id;
    bool checked = task.checked;
    Task newTask = task.copyWith(checked: !checked);
    removeTask(index, id);
    _taskService.addTask(newTask);
    notifyListeners();
  }

  void onTaskTap(Task task) {
    print('task with id ${task.id} tapped');
  }

  TaskService _taskService = locator<TaskService>();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_taskService];
}
