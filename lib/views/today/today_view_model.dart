import 'package:intl/intl.dart';
import 'package:dotdo/core/locator.dart';
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

  bool _isDayMode = true;
  bool get isDayMode => _isDayMode;

  handleOnStartup() {
    refreshDate();
  }

  void toggleMode() {
    _isDayMode = !_isDayMode;
    notifyListeners();
  }

  // Stream get getHomeActiveUChallenge => _challengeService.getActiveUChallenge();

  DateTime get currentDate => _taskService.date.value;
  final dateFormat = DateFormat('MMM-dd');

  NavigationService _navigationService = locator<NavigationService>();
  TaskService _taskService = locator<TaskService>();
  // ChallengeService _challengeService = locator<ChallengeService>();

  TodayViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  void logout() {
    FirebaseAuthenticationService().logout();
    _navigationService.pushNamedAndRemoveUntil(loginViewRoute);
  }

  void refreshDate() {
    DateTime _date;
    int _dateNow = DateTime.now().millisecondsSinceEpoch;
    int _dateSelected = DateTime(
            currentDate.year, currentDate.month, currentDate.day, 23, 59, 59)
        .millisecondsSinceEpoch;
    if (_dateNow > _dateSelected) {
      _date = DateTime(DateTime.now().year, DateTime.now().month,
          DateTime.now().day, 0, 0, 1);
      _taskService.updateDate(_date);
      print('Date refreshed: $_date');
      notifyListeners();
    }
  }

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_taskService];
}
