import 'package:intl/intl.dart';
import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/task.dart';
import 'package:dotdo/core/router_constants.dart';
import 'package:dotdo/core/services/taskService.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_firebase_auth/stacked_firebase_auth.dart';
import 'package:stacked_services/stacked_services.dart';

class TodayViewModel extends ReactiveViewModel {
  Logger log;
  String _title = 'Today';
  String get title => _title;

  DateTime get currentDate => _taskService.date.value;
  final dateFormat = DateFormat('MMM-dd');

  Future handelStartup() async {
    // TODO: see if you need this
    // refreshData();
  }

  Future refreshData() async {
    _taskService.updateRxListFromFirebase();
  }

  // TODO: change to be updated on the DatePicker selected Date
  List<Task> getTodayTaskList() => _taskService.rxTaskList
      .where(
        (element) =>
            element.checked == false &&
            (element.due.day == DateTime.now().day &&
                element.due.month == DateTime.now().month &&
                element.due.year == DateTime.now().year),
      )
      .toList();

  NavigationService _navigationService = locator<NavigationService>();
  TaskService _taskService = locator<TaskService>();

  TodayViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  void logout() {
    FirebaseAuthenticationService().logout();
    _navigationService.pushNamedAndRemoveUntil(loginViewRoute);
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_taskService];
}
