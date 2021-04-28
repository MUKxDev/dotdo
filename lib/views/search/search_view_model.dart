import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/services/authService.dart';
import 'package:dotdo/core/services/searchService.dart';
import 'package:dotdo/views/another_profile/another_profile_view.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class SearchViewModel extends BaseViewModel {
  Logger log;

  SearchViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  SearchService _searchService = locator<SearchService>();
  AuthService _authService = locator<AuthService>();
  NavigationService _navigationService = locator<NavigationService>();
  SnackbarService _snackbarService = locator<SnackbarService>();

  Stream<QuerySnapshot> get usersStream =>
      _searchService.usersStream(_searchedText);

  bool _isBusy;
  bool get isBusy => _isBusy;

  String _searchedText;
  String get searchedText => _searchedText;

  String _currentUserId;
  String get currentUserId => _currentUserId;

  TextEditingController searchController = TextEditingController(text: '');

  handleOnStartUp(String searchedText) async {
    _isBusy = true;
    _searchedText = searchedText;
    searchController.text = searchedText;
    _currentUserId = await _authService.getCurrentUserId();

    _isBusy = false;
    notifyListeners();
  }

  search(String input) async {
    String _searchInput = input;
    _searchInput = _searchInput.trim();
    _searchInput = _searchInput.toLowerCase();
    if (_searchInput == '' || _searchInput == null) {
      _snackbarService.showSnackbar(message: 'The search bar is empty!');
    } else {
      _searchedText = _searchInput;
      notifyListeners();
    }
  }

  userTapped(String id) {
    _navigationService.navigateToView(AnotherProfileView(
      uid: id,
    ));
  }
}
