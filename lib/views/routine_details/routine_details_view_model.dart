import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/Routine.dart';
import 'package:dotdo/core/router_constants.dart';
import 'package:dotdo/core/services/routineService.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class RoutineDetailsViewModel extends BaseViewModel {
  Logger log;

  RoutineDetailsViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
  RoutineService _routineService = locator<RoutineService>();

  String _routineId;
  String get routineId => _routineId;

  Routine _routine;
  Routine get routine => _routine;

  bool _isEdit = false;
  bool get isEdit => _isEdit;

  bool _isBusy = true;
  bool get isBusy => _isBusy;

  NavigationService _navigationService = locator<NavigationService>();

  Stream<DocumentSnapshot> get routineStream =>
      _routineService.getURoutineStream(routineId);

  Stream<QuerySnapshot> get tasksStream =>
      _routineService.getURTasks(_routineId);

  handelStartup(Map args) async {
    print(args);
    _routineId = args['routineId'];
    _isEdit = args['isEdit'];

    _routine = await _routineService.getURoutine(_routineId);

    _isBusy = false;
    notifyListeners();
  }

  Future<void> toggleCompletedUTask(
      String taskId, bool currentCompleted) async {
    await _routineService.toggleCompletedURTask(
        taskId, _routineId, currentCompleted);
    notifyListeners();
  }

  addNewTask() {
    Map args = {
      'taskId': null,
      'routineId': _routineId,
      'icon': _routine.iconData,
      'color': _routine.iconColor,
    };
    _navigationService.navigateTo(rtaskDetailsViewRoute, arguments: args);
  }

  taskTapped(String taskId) async {
    Map args = {
      'taskId': taskId,
      'routineId': _routineId,
      'icon': null,
      'color': null,
    };
    _navigationService.navigateTo(rtaskDetailsViewRoute, arguments: args);
  }

  deleteUTask(String taskId) {
    _routineService.deleteRTask(_routineId, taskId);
  }

  updateRoutine(Routine newRoutine) {
    _routine = newRoutine;
  }

  routineTapped(String id) {
    _navigationService.navigateTo(newRoutineViewRoute, arguments: id);
  }

  toggleIsEdit() {
    _isEdit = !_isEdit;
    notifyListeners();
  }
}
