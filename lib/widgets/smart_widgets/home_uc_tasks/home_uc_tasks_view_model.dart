import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/services/challangeService.dart';
import 'package:dotdo/core/services/taskService.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:intl/intl.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeUcTasksViewModel extends BaseViewModel {
  Logger log;

  HomeUcTasksViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  ChallangeService _challangeService = locator<ChallangeService>();
  NavigationService _navigationService = locator<NavigationService>();

  DateTime get currentDate => DateTime.now();
  final dateFormat = DateFormat('MMM-dd');

  Stream<QuerySnapshot> get stream =>
      _challangeService.getDateUCTasksStreamHome(currentDate);

  void toggleCompletedUTask(
      String taskId, bool currentCompleted, String challangeId) {
    _challangeService.toggleCompletedUCTask(
        taskId, challangeId, currentCompleted);
  }

  taskTapped(String taskId) async {
    // _navigationService.navigateTo(taskDetailsViewRoute, arguments: taskId);
  }

  void deleteUTask(String taskId, String challangeId) {
    _challangeService.deleteUCTask(taskId, challangeId);
  }
}
