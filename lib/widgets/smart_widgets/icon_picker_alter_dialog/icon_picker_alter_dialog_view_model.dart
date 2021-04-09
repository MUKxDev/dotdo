import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';

class IconPickerAlterDialogViewModel extends BaseViewModel {
  Logger log;

  IconPickerAlterDialogViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }

  IconData _iconData;
  IconData get iconData => _iconData;

  Color _iconColor;
  Color get iconColor => _iconColor;

  handleStartUp(IconData iconData, Color iconColor, Function setIconData,
      Function setIconColor) {
    _iconData = iconData;
    _iconColor = iconColor;
    notifyListeners();
  }

  Color colorTapped(Color iconColor) {
    _iconColor = iconColor;
    notifyListeners();
    return _iconColor;
  }

  IconData iconTapped(IconData iconData) {
    _iconData = iconData;
    notifyListeners();
    return _iconData;
  }
}
