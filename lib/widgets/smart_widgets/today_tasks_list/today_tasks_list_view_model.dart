import 'package:dotdo/core/router_constants.dart';
import 'package:dotdo/views/task_details/task_details_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/services/taskService.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class TodayTasksListViewModel extends BaseViewModel {
  Logger log;

  TodayTasksListViewModel() {
    log = getLogger(this.runtimeType.toString());
  }

  TaskService _taskService = locator<TaskService>();
  NavigationService _navigationService = locator<NavigationService>();

  DateTime get currentDate => _taskService.date.value;
  final dateFormat = DateFormat('MMM-dd');

  Stream<QuerySnapshot> get stream => _taskService.getUTasksStream();

  void toggleCompletedUTask(String taskId, bool currentCompleted) {
    _taskService.toggleCompletedUTask(taskId, currentCompleted);
  }

  taskTapped(String taskId) async {
    _navigationService.navigateTo(taskDetailsViewRoute, arguments: taskId);
  }

  // @override
  // List<ReactiveServiceMixin> get reactiveServices => [_taskService];
}
