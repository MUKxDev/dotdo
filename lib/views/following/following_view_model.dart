import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/User.dart';
import 'package:dotdo/core/services/authService.dart';
import 'package:dotdo/core/services/userService.dart';
import 'package:dotdo/views/another_profile/another_profile_view.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class FollowingViewModel extends BaseViewModel {
  Logger log;

  FollowingViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  UserService _userService = locator<UserService>();
  AuthService _authService = locator<AuthService>();
  NavigationService _navigationService = locator<NavigationService>();
  SnackbarService _snackbarService = locator<SnackbarService>();

  bool _isbusy;
  bool get isbusy => _isbusy;

  String _userId;
  String get userId => _userId;

  List<User> _usersList = [];
  List<User> get usersList => _usersList;

  List<String> _usersIdList = [];
  List<String> get usersIdList => _usersIdList;

  handleOnStartUp(String userId) async {
    _isbusy = true;

    _userId = userId;
    QuerySnapshot querySnapshot = await _userService.getFollowing(_userId);

    if (querySnapshot != null) {
      if (querySnapshot.size != 0) {
        await updateUsersList(querySnapshot.docs);
      }
    }

    _isbusy = false;
    notifyListeners();
  }

  userTapped(String userId) async {
    String uid = await _authService.getCurrentUserId();
    if (uid == userId) {
      _snackbarService.showSnackbar(
          message: 'You can\'t view your profile from here');
    } else {
      _navigationService.navigateToView(AnotherProfileView(
        uid: userId,
      ));
    }
  }

  Future<User> getUser(String userId) async {
    User user = await _userService.getUserProfile(userId);

    return user;
  }

  updateUsersList(List<QueryDocumentSnapshot> uL) async {
    List<User> _uList = [];
    List<String> _uIdList = [];
    for (var user in uL) {
      User r = await getUser(user.data()['ID']);
      if (r != null) {
        _uList.add(r);
        _uIdList.add(user.data()['ID']);
      }
    }

    _usersList = _uList;
    _usersIdList = _uIdList;
    notifyListeners();
  }
}
