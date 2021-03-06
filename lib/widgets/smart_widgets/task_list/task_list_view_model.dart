import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/task.dart';
import 'package:dotdo/core/services/taskService.dart';
import 'package:dotdo/widgets/smart_widgets/task_list/task_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';

class TaskListViewModel extends BaseViewModel {
  Logger log;
  final globalKey = GlobalKey<AnimatedListState>();

  TaskListViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  List<Task> getTaskList() => _taskService.taskList;

  void removeTask(int index) {
    _taskService.taskList.removeAt(index);
    globalKey.currentState
        .removeItem(index, (context, animation) => Container());
    notifyListeners();
  }

  void addTaskAtIndex(int index, Task task) {
    _taskService.taskList.insert(index, task);
    globalKey.currentState.insertItem(index);
    notifyListeners();
  }

// TODO: add function constructer to add to list
  void addNewTask() {
    Task task = Task(
        public: false,
        checked: false,
        lable: 'A task to be done',
        due: DateTime.now(),
        category: 'Work',
        id: UniqueKey().toString());
    _taskService.taskList.insert(0, task);
    globalKey.currentState.insertItem(0);
  }

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

  TaskService _taskService = locator<TaskService>();
}
