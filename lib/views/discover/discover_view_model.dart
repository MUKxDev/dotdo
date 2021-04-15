import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/services/searchService.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';

class DiscoverViewModel extends BaseViewModel {
  Logger log;

  DiscoverViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  TextEditingController searchController = TextEditingController(text: '');

  SearchService _searchService = locator<SearchService>();

  search(String input) async {
    String id = await _searchService.searchBarF(input);
    print(id);
  }
}
