import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/models/User.dart';
import 'package:dotdo/core/models/uGeneral.dart';
import 'package:dotdo/core/services/ImageSelectorService.dart';
import 'package:dotdo/core/services/authService.dart';
import 'package:dotdo/core/services/challengeService.dart';
import 'package:dotdo/core/services/gRoutineService.dart';
import 'package:dotdo/core/services/routineService.dart';
import 'package:dotdo/core/services/userService.dart';
import 'package:dotdo/views/followers/followers_view.dart';
import 'package:dotdo/views/following/following_view.dart';
import 'package:dotdo/views/global_routine/global_routine_view.dart';
import 'package:dotdo/views/likes/likes_view.dart';
import 'package:dotdo/views/pvp_details/pvp_details_view.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class ProfileViewModel extends BaseViewModel {
  Logger log;

  ProfileViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  ChallengeService _challengeService = locator<ChallengeService>();
  RoutineService _routineService = locator<RoutineService>();
  AuthService _authService = locator<AuthService>();
  UserService _userService = locator<UserService>();
  NavigationService _navigationService = locator<NavigationService>();
  ImageSelectorService _imageSelectorService = locator<ImageSelectorService>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  GRoutine _gRoutineService = locator<GRoutine>();

  String _userId;
  String get userId => _userId;

  bool _isBusy;
  bool get isBusy => _isBusy;

  bool _isCurrentUser;
  bool get isCurrentUser => _isCurrentUser;

  bool _haveLastBadge = false;
  bool get haveLastBadge => _haveLastBadge;

  bool _isFollowing;
  bool get isFollowing => _isFollowing;

  bool _isFollowingLoading = false;
  bool get isFollowingLoading => _isFollowingLoading;

  User _user;
  User get user => _user;

  UGeneral _userGeneral;
  UGeneral get userGeneral => _userGeneral;

  File _selectedImage;
  File get selectedImage => _selectedImage;

  String _imageUrl;
  String get imageUrl => _imageUrl;

  // int _noOfLikes;
  // int get noOfLikes => _noOfLikes;

  TextEditingController usernameController = TextEditingController(text: '');
  Stream<QuerySnapshot> get getAllUserGRoutine =>
      _gRoutineService.getAllUserGRoutine(_userId);
  Stream get getActiveUChallenge => _challengeService.getActiveUChallenge();
  Stream get getURoutines => _routineService.getAllURoutines();

  handleOnStartup(String uid) async {
    _isBusy = true;
    if (uid == null) {
      _userId = await _authService.getCurrentUserId();
      _isCurrentUser = true;
      // _noOfLikes = await _gRoutineService.getNumberOfLikes(_userId);
    } else {
      _userId = uid;
      _isCurrentUser = false;
      _isFollowing = await _userService.isFollowing(_userId);
      // _noOfLikes = await _gRoutineService.getNumberOfLikes(uid);
    }

    _user = await _userService.getUserProfile(_userId);
    _userGeneral = await _userService.getUserGeneral(_userId);
    _haveLastBadge = _userGeneral.lastBadge == '' ? false : true;
    _isBusy = false;
    notifyListeners();
  }

  pvpTapped() {
    _navigationService.navigateToView(PvpDetailsView(
      oppId: _userId,
    ));
  }

  routineTapped(String gRoutineId) {
    _navigationService.navigateToView(GlobalRoutineView(
      gRoutineId: gRoutineId,
    ));
  }

  Future selectImageFromCamera() async {
    PickedFile newSelectImageFromCamera =
        await _imageSelectorService.selectImageFromCamrea();

    // you will face errors if you dont cheack if the image not exist
    if (newSelectImageFromCamera != null) {
      // display that image
      _selectedImage = File(newSelectImageFromCamera.path);
      notifyListeners();

      _snackbarService.showSnackbar(message: 'Uploading...');
      // then uploade that image
      _imageUrl =
          await _userService.uploadAnImage(image: _selectedImage, uid: _userId);

      if (_imageUrl != null) {
        await _userService.updateUserProfilePicture(userId, _imageUrl);
        _user = await _userService.getUserProfile(_userId);
        notifyListeners();
        _snackbarService.showSnackbar(message: 'Profile picture updated');
      } else {
        _snackbarService.showSnackbar(message: 'An error happend!');
      }
    }
  }

  Future selectImageFromGallery() async {
    PickedFile newSelectImageFromGallery =
        await _imageSelectorService.selectImageFromGallery();

    // you will face errors if you dont cheack if the image not exist
    if (newSelectImageFromGallery != null) {
      // display that image
      _selectedImage = File(newSelectImageFromGallery.path);
      notifyListeners();
      _snackbarService.showSnackbar(message: 'Uploading...');
      // then uploade that image
      _imageUrl =
          await _userService.uploadAnImage(image: _selectedImage, uid: _userId);

      if (_imageUrl != null) {
        await _userService.updateUserProfilePicture(userId, _imageUrl);
        _user = await _userService.getUserProfile(_userId);
        notifyListeners();
        _snackbarService.showSnackbar(message: 'Profile picture updated');
      } else {
        _snackbarService.showSnackbar(message: 'An error happend!');
      }
    }
  }

  updateUsername() async {
    String _newUserName = usernameController.text.trim();
    _newUserName = replaceWhitespacesUsingRegex(_newUserName, '');
    _newUserName.toLowerCase();
    int _hashIndex = _newUserName.indexOf(RegExp(r'#'));
    if (_hashIndex != -1) {
      _newUserName = _newUserName.substring(0, _hashIndex);
      _newUserName.trim();
    }
    if (_newUserName != '') {
      await _userService.updateUserName(userId, _newUserName);
      _user = await _userService.getUserProfile(_userId);
      notifyListeners();
      _snackbarService.showSnackbar(message: 'Username Updated');
    } else {
      _snackbarService.showSnackbar(message: 'Username is empty!');
    }
  }

  String replaceWhitespacesUsingRegex(String s, String replace) {
    if (s == null) {
      return null;
    }

    // This pattern means "at least one space, or more"
    // \\s : space
    // +   : one or more
    final pattern = RegExp('\\s+');
    return s.replaceAll(pattern, replace);
  }

  likesTapped() {
    _navigationService.navigateToView(LikesView(
      userId: _userId,
    ));
  }

  // * Following/Followers
  void followTapped() async {
    _isFollowingLoading = true;
    notifyListeners();
    await _userService.addFollowing(_userId);
    await _userService.updateNoOfF(_userId);
    _isFollowing = await _userService.isFollowing(_userId);
    _userGeneral = await _userService.getUserGeneral(_userId);
    _isFollowingLoading = false;
    notifyListeners();
  }

  void unFollowTapped() async {
    _isFollowingLoading = true;
    notifyListeners();
    await _userService.removeFollowing(_userId);
    await _userService.updateNoOfF(_userId);
    _isFollowing = await _userService.isFollowing(_userId);
    _userGeneral = await _userService.getUserGeneral(_userId);
    _isFollowingLoading = false;
    notifyListeners();
  }

  followingTapped() {
    _navigationService.navigateToView(FollowingView(
      userID: _userId,
    ));
  }

  followersTapped() {
    _navigationService.navigateToView(FollowersView(
      userID: _userId,
    ));
  }
}
