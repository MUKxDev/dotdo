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

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_taskService];
}
