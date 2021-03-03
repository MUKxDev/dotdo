import 'package:dotdo/core/locator.dart';
import 'package:dotdo/core/router_constants.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';
import 'package:stacked_services/stacked_services.dart';

class BottomNavBarViewModel extends BaseViewModel {
  Logger log;
  int _selectedIndex = 0;
  int get selectedIndex => _selectedIndex;
  NavigationService _navigationService = locator<NavigationService>();

  BottomNavBarViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  void updateSelectedNavbarItem(int index) {
    if (_selectedIndex != index) {
      _selectedIndex = index;
      switch (_selectedIndex) {
        case 0:
          _navigationService.pushNamedAndRemoveUntil(todayViewRoute);
          break;
        case 1:
          _navigationService.pushNamedAndRemoveUntil(socialViewRoute);
          break;
        case 2:
          _navigationService.pushNamedAndRemoveUntil(todayViewRoute);
          break;
        case 3:
          _navigationService.pushNamedAndRemoveUntil(todayViewRoute);
          break;
        default:
          _navigationService.pushNamedAndRemoveUntil(todayViewRoute);
      }
    } else {
      print('you are on the same page !!');
    }

    notifyListeners();
  }
}
