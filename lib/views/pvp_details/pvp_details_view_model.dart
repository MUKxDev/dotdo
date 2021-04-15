import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import 'package:dotdo/core/logger.dart';

class PvpDetailsViewModel extends BaseViewModel {
  Logger log;

  PvpDetailsViewModel() {
    this.log = getLogger(this.runtimeType.toString());
  }
  String _user1Name = 'mukxdev#fgj678';
  String get user1Name => _user1Name;

  String _user2Name = 'ilillliliwolf#moo789';
  String get user2Name => _user2Name;

  String _user1Avatar =
      'https://firebasestorage.googleapis.com/v0/b/dotdo-autovita.appspot.com/o/defaultAvatar.png?alt=media&token=d8896de4-4a13-4560-995c-d010a1a3bfd9';
  String get user1Avatar => _user1Avatar;

  String _user2Avatar =
      'https://firebasestorage.googleapis.com/v0/b/dotdo-autovita.appspot.com/o/defaultAvatar.png?alt=media&token=d8896de4-4a13-4560-995c-d010a1a3bfd9';
  String get user2Avatar => _user2Avatar;

  String _noOfWins = '1';
  String get noOfWins => _noOfWins;

  String _noOfDraws = '1';
  String get noOfDraws => _noOfDraws;

  String _noOfLosses = '1';
  String get noOfLosses => _noOfLosses;

  int _noTotalTasks = 3;
  int get noTotalTasks => _noTotalTasks;

  int _noUser1TasksCompleted = 2;
  int get noUser1TasksCompleted => _noUser1TasksCompleted;

  int _noUser2TasksCompleted = 1;
  int get noUser2TasksCompleted => _noUser2TasksCompleted;

  newChallengeTapped() {}

  challengeTapped() {}
}
