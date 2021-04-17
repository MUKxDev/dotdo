import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/services/challengeService.dart';
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

  ChallengeService _challengeService = locator<ChallengeService>();
  NavigationService _navigationService = locator<NavigationService>();

  DateTime get currentDate => DateTime.now();
  final dateFormat = DateFormat('MMM-dd');

  Stream<QuerySnapshot> get stream =>
      _challengeService.getDateUCTasksStreamHome(currentDate);

  void toggleCompletedUTask(
      String taskId, bool currentCompleted, String challengeId) {
    _challengeService.toggleCompletedUCTask(
        taskId, challengeId, currentCompleted);
  }

  taskTapped(String taskId) async {
    // _navigationService.navigateToView(taskDetailsViewRoute, arguments: taskId);
  }

  void deleteUTask(String taskId, String challengeId) {
    _challengeService.deleteUCTask(taskId, challengeId);
  }
}
