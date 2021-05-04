import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/Routine.dart';
import 'package:dotdo/core/services/routineService.dart';
import 'package:dotdo/views/new_routine/new_routine_view.dart';
import 'package:dotdo/views/rtask_details/rtask_details_view.dart';
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

  bool _isPublic = false;
  bool get isPublic => _isPublic;

  NavigationService _navigationService = locator<NavigationService>();
  DialogService _dialogService = locator<DialogService>();

  Stream<DocumentSnapshot> get routineStream =>
      _routineService.getURoutineStream(routineId);

  Stream<QuerySnapshot> get tasksStream =>
      _routineService.getURTasks(_routineId);

  handelStartup(Map args) async {
    print(args);
    _routineId = args['routineId'];
    _isEdit = args['isEdit'];

    _routine = await _routineService.getURoutine(_routineId);
    _isPublic = _routine.publicRoutine;

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
    _navigationService.navigateToView(RtaskDetailsView(args: args));
  }

  taskTapped(String taskId) async {
    Map args = {
      'taskId': taskId,
      'routineId': _routineId,
      'icon': null,
      'color': null,
    };
    _navigationService.navigateToView(RtaskDetailsView(args: args));
  }

  deleteUTask(String taskId) {
    _routineService.deleteRTask(_routineId, taskId);
  }

  updateRoutine(Routine newRoutine) {
    _routine = newRoutine;
  }

  routineTapped(String id) {
    _navigationService.navigateToView(NewRoutineView(routineId: id));
  }

  toggleIsEdit() {
    _isEdit = !_isEdit;
    notifyListeners();
  }

  toggleIsPublic() async {
    bool _oldBool = _isPublic;

    if (_oldBool) {
      DialogResponse _dialogResponse =
          await _dialogService.showConfirmationDialog(
              title: 'Are you sure you want remove it from public?');
      if (_dialogResponse.confirmed) {
        _isPublic = !_isPublic;
        _routineService.togglePublicROFF(routineId);
      }
    } else {
      _isPublic = !_isPublic;
      _routineService.togglePublicR(routineId);
    }
    notifyListeners();
  }
}
