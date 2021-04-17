import 'package:dotdo/core/services/taskService.dart';
import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/router_constants.dart';
import 'package:dotdo/core/services/authService.dart';
import 'package:dotdo/views/new_challenge/new_challenge_view.dart';
import 'package:dotdo/views/new_routine/new_routine_view.dart';
import 'package:dotdo/views/task_details/task_details_view.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends ReactiveViewModel {
  Logger log;
  HomeViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  NavigationService _navigationService = locator<NavigationService>();
  TaskService _taskService = locator<TaskService>();

  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  DateTime get currentDate => _taskService.date.value;

  PageController pageController = PageController(initialPage: 0);
  String _title = '.Do';
  get title => _title;

  void updateTitle() {
    switch (_selectedIndex) {
      case 0:
        _title = '.Do';
        break;
      case 1:
        _title = 'Social';
        break;
      case 2:
        _title = 'Discover';
        break;
      case 3:
        _title = 'Profile';
        break;
      default:
    }
  }

  // * For The BottomNavigationBar(onTap)
  void updateSelectedNavbarItem(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      updateTitle();
      pageController.jumpToPage(
        _selectedIndex,
      );
    } else {
      print('you are on the same page !!');
    }
    notifyListeners();
  }

  // * For sliding the PageView(onPageChanged)
  void updateSelectedIndex(int index) {
    _selectedIndex = index;
    updateTitle();
    notifyListeners();
  }

  void logout() {
    _authService.logout();
    _navigationService.pushNamedAndRemoveUntil(authpageViewRoute);
  }

  AuthService _authService = locator<AuthService>();

  addTask() {
    _navigationService.navigateToView(TaskDetailsView());
  }

  addRoutine() async {
    _navigationService.navigateToView(NewRoutineView());
  }

  addChallenge() {
    _navigationService.navigateToView(NewChallengeView());
  }

  Key fabKey = UniqueKey();

  @override
  List<ReactiveServiceMixin> get reactiveServices => [_taskService];
}
