import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/services/routineService.dart';
import 'package:dotdo/views/routine_details/routine_details_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class ActiveRoutinesStreamViewModel extends BaseViewModel {
  Logger log;

  ActiveRoutinesStreamViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  NavigationService _navigationService = locator<NavigationService>();
  RoutineService _routineService = locator<RoutineService>();

  Stream get getActiveURoutines => _routineService.getActiveURoutines();

  routineTapped(String id) {
    Map args = {
      'routineId': id,
      'isEdit': false,
    };
    _navigationService.navigateToView(RoutineDetailsView(args: args));
  }
}
