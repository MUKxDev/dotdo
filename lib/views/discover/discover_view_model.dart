import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/services/searchService.dart';
import 'package:dotdo/views/another_profile/another_profile_view.dart';
import 'package:dotdo/views/profile/profile_view.dart';
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

  TextEditingController searchController = TextEditingController(text: '');

  SearchService _searchService = locator<SearchService>();
  NavigationService _navigationService = locator<NavigationService>();
  SnackbarService _snackbarService = locator<SnackbarService>();

  search(String input) async {
    String id = await _searchService.searchBarF(input);
    if (id == null) {
      _snackbarService.showSnackbar(message: 'No result found');
    } else {
      _navigationService.navigateToView(AnotherProfileView(
        uid: id,
      ));
    }
  }
}
