import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/services/authService.dart';
import 'package:dotdo/core/services/userService.dart';
import 'package:dotdo/views/another_profile/another_profile_view.dart';

import 'package:dotdo/views/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class DiscoverViewModel extends BaseViewModel {
  Logger log;

  DiscoverViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  NavigationService _navigationService = locator<NavigationService>();
  SnackbarService _snackbarService = locator<SnackbarService>();
  UserService _userService = locator<UserService>();
  AuthService _authService = locator<AuthService>();

  TextEditingController searchController = TextEditingController(text: '');

  Stream<QuerySnapshot> get getUsersLeaderBoard =>
      _userService.getUserLeaderboard();

  search(String input) async {
    String _searchInput = input;
    _searchInput = _searchInput.trim();
    _searchInput = _searchInput.toLowerCase();
    if (_searchInput == '' || _searchInput == null) {
      _snackbarService.showSnackbar(message: 'The search bar is empty!');
    } else {
      _navigationService.navigateToView(SearchView(
        searchedText: _searchInput,
      ));
    }
  }

  userTapped(String uid) async {
    String currentUid = await _authService.getCurrentUserId();
    if (currentUid == uid) {
      _snackbarService.showSnackbar(
          message: 'You can\'t view your profile from here.');
    } else {
      _navigationService.navigateToView(AnotherProfileView(
        uid: uid,
      ));
    }
  }
}
