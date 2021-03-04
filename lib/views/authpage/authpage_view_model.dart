import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';

class AuthpageViewModel extends BaseViewModel {
  Logger log;
  AuthpageViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  String _title = 'Sign in';
  get title => _title;

  int _pageIndex = 0;
  int get pageIndex => _pageIndex;

  PageController pageController = PageController(initialPage: 0);

  void updateTitle() {
    switch (_pageIndex) {
      case 0:
        _title = 'Sign in';
        break;
      case 1:
        _title = 'Register';
        break;
      default:
        _title = 'Sign in';
    }
  }

  void navigateToIndex(int index) {
    _pageIndex = index;
    updateTitle();
    pageController.animateToPage(
      _pageIndex,
      curve: Curves.easeInOutQuart,
      duration: Duration(milliseconds: 500),
    );
  }

  // * For sliding the PageView(onPageChanged)
  void updatePageIndex(int index) {
    _pageIndex = index;
    updateTitle();
    notifyListeners();
  }
}
