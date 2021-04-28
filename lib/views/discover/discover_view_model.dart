import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/services/authService.dart';
import 'package:dotdo/core/services/searchService.dart';
import 'package:dotdo/views/another_profile/another_profile_view.dart';
import 'package:dotdo/views/search/search_view.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class DiscoverViewModel extends BaseViewModel {
  Logger log;

  DiscoverViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  NavigationService _navigationService = locator<NavigationService>();
  SnackbarService _snackbarService = locator<SnackbarService>();

  TextEditingController searchController = TextEditingController(text: '');

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
  // search(String input) async {
  //   String _searchInput = input;
  //   _searchInput = _searchInput.trim();
  //   _searchInput = _searchInput.toLowerCase();
  //   String id = await _searchService.searchBarF(_searchInput);
  //   String currentUid = await _authService.getCurrentUserId();
  //   if (id == null) {
  //     _snackbarService.showSnackbar(message: 'No result found');
  //   } else if (id == currentUid) {
  //     _snackbarService.showSnackbar(
  //         message: 'You can\'t preview your profile from here.');
  //   } else {
  //     _navigationService.navigateToView(AnotherProfileView(
  //       uid: id,
  //     ));
  //   }
  // }
}
