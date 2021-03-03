import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';

class BottomNavBarViewModel extends BaseViewModel {
  Logger log;
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;

  BottomNavBarViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  void updateSelectedNavbarItem(int index) {
    _selectedIndex = index;
    notifyListeners();
  }
}
