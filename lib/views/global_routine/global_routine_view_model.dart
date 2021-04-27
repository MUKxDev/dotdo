import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/Routine.dart';
import 'package:dotdo/core/services/gRoutineService.dart';
import 'package:dotdo/core/services/routineService.dart';
import 'package:dotdo/views/new_routine/new_routine_view.dart';
import 'package:dotdo/views/rtask_details/rtask_details_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class GlobalRoutineViewModel extends BaseViewModel {
  Logger log;

  GlobalRoutineViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  GRoutine _gRoutineService = locator<GRoutine>();
  // NavigationService _navigationService = locator<NavigationService>();
  SnackbarService _snackbarService = locator<SnackbarService>();

  String _gRoutineId;
  String get gRoutineId => _gRoutineId;

  Routine _routine;
  Routine get routine => _routine;

  bool _isBusy = true;
  bool get isBusy => _isBusy;

  bool _isAddedGRotine = false;
  bool get isAddedGRotine => _isAddedGRotine;

  bool _isLiked = false;
  bool get isLiked => _isLiked;

  Stream<DocumentSnapshot> get routineStream =>
      _gRoutineService.getGRoutineStream(gRoutineId);

  Stream<QuerySnapshot> get tasksStream =>
      _gRoutineService.getGRTasks(_gRoutineId);

  handelStartup(String gRoutineId) async {
    _gRoutineId = gRoutineId;

    _routine = await _gRoutineService.getGRoutine(_gRoutineId);
    _isLiked = await _gRoutineService.getLikeStatus(_gRoutineId);
    _isAddedGRotine = await _gRoutineService.isAddedGRoutine(_gRoutineId);

    _isBusy = false;
    notifyListeners();
  }

  // taskTapped(String taskId) async {
  //   Map args = {
  //     'taskId': taskId,
  //     'routineId': _gRoutineId,
  //     'icon': null,
  //     'color': null,
  //   };
  //   _navigationService.navigateToView(RtaskDetailsView(args: args));
  // }

  // routineTapped(String id) {
  //   _navigationService.navigateToView(NewRoutineView(routineId: id));
  // }

  updateRoutine(Routine newRoutine) {
    _routine = newRoutine;
  }

  toggleIsLiked() async {
    await _gRoutineService.toggleLike(_gRoutineId);
    _isLiked = await _gRoutineService.getLikeStatus(_gRoutineId);

    notifyListeners();
  }

  toggleIsAddedGRoutine() async {
    if (_isAddedGRotine) {
      _snackbarService.showSnackbar(message: 'You already have this routine');
    } else {
      await _gRoutineService.saveGRoutine(_gRoutineId);

      _isAddedGRotine = !_isAddedGRotine;
      _snackbarService.showSnackbar(message: 'The routine is added to you');
      notifyListeners();
    }
  }
}
