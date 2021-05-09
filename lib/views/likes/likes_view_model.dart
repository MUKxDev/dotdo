import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/Routine.dart';
import 'package:dotdo/core/services/gRoutineService.dart';
import 'package:dotdo/views/global_routine/global_routine_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class LikesViewModel extends BaseViewModel {
  Logger log;

  LikesViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  GRoutine _gRoutineService = locator<GRoutine>();
  NavigationService _navigationService = locator<NavigationService>();

  bool _isbusy;
  bool get isbusy => _isbusy;

  String _userId;
  String get userId => _userId;

  List<Routine> _routinesList = [];
  List<Routine> get routinesList => _routinesList;

  List<String> _routinesIdList = [];
  List<String> get routinesIdList => _routinesIdList;

  Future<QuerySnapshot> get likedRoutinesStream =>
      _gRoutineService.getLikedRoutiens(_userId);

  handleOnStartUp(String userId) async {
    _isbusy = true;

    _userId = userId;
    QuerySnapshot querySnapshot =
        await _gRoutineService.getLikedRoutiens(_userId);

    if (querySnapshot != null) {
      if (querySnapshot.size != 0) {
        await updateGRoutinesDocs(querySnapshot.docs);
      }
    }

    _isbusy = false;
    notifyListeners();
  }

  routineTapped(String gRoutineId) {
    _navigationService.navigateToView(GlobalRoutineView(
      gRoutineId: gRoutineId,
    ));
  }

  Future<Routine> getGRoutine(String gRoutineId) async {
    DocumentSnapshot documentSnapshot =
        await _gRoutineService.getGRoutineDoc(gRoutineId);
    Routine _routine;
    if (documentSnapshot.exists) {
      _routine = Routine.fromMap(documentSnapshot.data());
    }
    return _routine;
  }

  updateGRoutinesDocs(
      List<QueryDocumentSnapshot<Map<String, dynamic>>> gRoutinesDocs) async {
    List<Routine> _rList = [];
    List<String> _rIdList = [];
    for (var routine in gRoutinesDocs) {
      Routine r = await getGRoutine(routine.data()['gRoutineId']);
      if (r != null) {
        _rList.add(r);
        _rIdList.add(routine.data()['gRoutineId']);
      }
    }

    _routinesList = _rList;
    _routinesIdList = _rIdList;
    notifyListeners();
  }
}
