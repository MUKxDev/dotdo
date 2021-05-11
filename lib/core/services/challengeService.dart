import 'package:cloud_firestore/cloud_firestore.dart';

// import '../../../../../flutter/.pub-cache/hosted/pub.dartlang.org/cloud_firestore-2.0.0/lib/cloud_firestore.dart';
import '../locator.dart';
import '../models/challenge.dart';
import '../models/task.dart';
import 'authService.dart';
import 'firestoreService.dart';

class ChallengeService {
  FirestoreService _firestoreService = locator<FirestoreService>();
  AuthService _authService = locator<AuthService>();
// *ADD --------------------------------
  Future<String> addUChallenge(Challenge challenge) async {
    String _userId = await _authService.getCurrentUserId();
    String challengeId = await _firestoreService.users
        .doc(_userId)
        .collection('UChallenges')
        .add(challenge.toMap())
        .then((value) {
      print('challenge with id ${value.id} added');
      return value.id;
    }).onError((error, stackTrace) {
      print('erorr with adding challenge: $error');
      return null;
    });
    challengeDotChecks(challengeId);
    return challengeId;
  }

  Future challengeDotChecks(String challengeId) async {
    String _userId = await _authService.getCurrentUserId();
    _firestoreService.users
        .doc(_userId)
        .collection('UChallenges')
        .doc(challengeId)
        .update({'dotCheck': false});
  }

  Future<bool> addUCTask(String challengeId, Task task) async {
    String _userId = await _authService.getCurrentUserId();
    int _totalUCTask = await _firestoreService.users
        .doc(_userId)
        .collection('UChallenges')
        .doc(challengeId)
        .get()
        .then((value) => value.data()['noOfTasks']);

    bool added = await _firestoreService.users
        .doc(_userId)
        .collection('UChallenges')
        .doc(challengeId)
        .collection('UCTasks')
        .add(task.toMap())
        .then((value) {
      print('task with id: ${value.id} added');
      int _tplus = _totalUCTask + 1;
      _firestoreService.users
          .doc(_userId)
          .collection('UChallenges')
          .doc(challengeId)
          .update({'noOfTasks': _tplus});
      toggleCompletedUChalllange(challengeId);
      return true;
    }).onError((error, stackTrace) {
      print('error with adding task: $error');
      return false;
    });

    return added;
  }

// *completed --------------------------------
  Future toggleCompletedUChalllange(String challengeId) async {
    String _userId = await _authService.getCurrentUserId();
    int _totalUCTask = await _firestoreService.users
        .doc(_userId)
        .collection('UChallenges')
        .doc(challengeId)
        .get()
        .then((value) => value.data()['noOfTasks']);

    int _totalCompletedUCTask = await _firestoreService.users
        .doc(_userId)
        .collection('UChallenges')
        .doc(challengeId)
        .get()
        .then((value) => value.data()['noOfCompletedTasks']);
//-----------------------------------
    if (_totalUCTask == _totalCompletedUCTask && _totalUCTask != 0) {
      await _firestoreService.users
          .doc(_userId)
          .collection('UChallenges')
          .doc(challengeId)
          .update({'completed': true});
      await noOfChallengeCompleted();
      await challengeCompletedDot(challengeId);
    } else {
      await _firestoreService.users
          .doc(_userId)
          .collection('UChallenges')
          .doc(challengeId)
          .update({'completed': false});
      await noOfChallengeCompleted();
    }
  }

  Future challengeCompletedDot(String challengeId) async {
    String _userId = await _authService.getCurrentUserId();
    bool check = await _firestoreService.users
        .doc(_userId)
        .collection('UChallenges')
        .doc(challengeId)
        .get()
        .then((value) => value.data()['dotCheck']);
    int dots = await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .get()
        .then((value) => value.data()['dots']);
    int _dplus = dots + 10;
    if (check == false) {
      _firestoreService.users.doc(_userId).update({'dots': _dplus});
      _firestoreService.users
          .doc(_userId)
          .collection('UChallenges')
          .doc(challengeId)
          .update({'dotCheck': true});
    }
  }

  Future dotsPlus() async {
    String _userId = await _authService.getCurrentUserId();
    int dots = await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .get()
        .then((value) => value.data()['dots']);
    int _dplus = dots + 2;
    _firestoreService.users.doc(_userId).update({'dots': _dplus});
  }

  Future dotsMinus() async {
    String _userId = await _authService.getCurrentUserId();
    int dots = await _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .get()
        .then((value) => value.data()['dots']);
    int _dMinus = dots - 2;
    _firestoreService.users.doc(_userId).update({'dots': _dMinus});
  }

  Future toggleCompletedUCTask(
      String taskId, String challengeId, bool currentCompleted) async {
    String _userId = await _authService.getCurrentUserId();
    int _noOfTaskCompleted = await _firestoreService.users
        .doc(_userId)
        .collection('uGeneral')
        .doc('generalData')
        .get()
        .then((value) => value.data()['noOfTaskCompleted']);

    int _noOfCTaskCompleted = await _firestoreService.users
        .doc(_userId)
        .collection('UChallenges')
        .doc(challengeId)
        .get()
        .then((value) => value.data()['noOfCompletedTasks']);
//------------------------
    int _plus = _noOfTaskCompleted + 1;
    int _minus = _noOfTaskCompleted - 1;
//-----------------------------------------
    int _tplus = _noOfCTaskCompleted + 1;
    int _tminus = _noOfCTaskCompleted - 1;
//
    await _firestoreService.users
        .doc(_userId)
        .collection('UChallenges')
        .doc(challengeId)
        .collection('UCTasks')
        .doc(taskId)
        .update({'completed': !(currentCompleted)}).then((value) async {
      if (currentCompleted == false) {
        await _firestoreService.users
            .doc(_userId)
            .collection("uGeneral")
            .doc('generalData')
            .update({'noOfTaskCompleted': _plus});
        await _firestoreService.users
            .doc(_userId)
            .collection('UChallenges')
            .doc(challengeId)
            .update({'noOfCompletedTasks': _tplus});
        await dotsPlus();
      } else {
        await _firestoreService.users
            .doc(_userId)
            .collection("uGeneral")
            .doc('generalData')
            .update({'noOfTaskCompleted': _minus});
        await _firestoreService.users
            .doc(_userId)
            .collection('UChallenges')
            .doc(challengeId)
            .update({'noOfCompletedTasks': _tminus});
        await dotsMinus();
      }
      await toggleCompletedUChalllange(challengeId);
    }).onError((error, stackTrace) {
      print('error with adding task: $error');
    });
  }

  // *update --------------------------------
  Future updateUChalllange(String challengeId, Challenge challenge) async {
    String _userId = await _authService.getCurrentUserId();
    _firestoreService.users
        .doc(_userId)
        .collection('UChallenges')
        .doc(challengeId)
        .update(challenge.toMap());
  }

  Future<bool> updateUCTask(
      String challengeId, String taskId, Task task) async {
    String _userId = await _authService.getCurrentUserId();
    return _firestoreService.users
        .doc(_userId)
        .collection('UChallenges')
        .doc(challengeId)
        .collection('UCTasks')
        .doc(taskId)
        .update(task.toMap())
        .then((value) => true)
        .onError((error, stackTrace) => false);
  }

  // *get --------------------------------
  //
  // Stream<QuerySnapshot> getHomeActiveUChallenge() async* {
  //   String _userId = await _authService.getCurrentUserId();
  //   DateTime date = DateTime.now();
  //   yield* _firestoreService.users
  //       .doc(_userId)
  //       .collection('UChallenges')
  //       .where('endDate', isGreaterThanOrEqualTo: date.millisecondsSinceEpoch)
  //       .where('completed', isEqualTo: false)
  //       .snapshots();
  // }

  Stream<QuerySnapshot> getActiveUChallenge() async* {
    String _userId = await _authService.getCurrentUserId();
    DateTime date = DateTime.now();
    yield* _firestoreService.users
        .doc(_userId)
        .collection('UChallenges')
        .orderBy('endDate')
        .where('endDate', isGreaterThanOrEqualTo: date.millisecondsSinceEpoch)
        .snapshots();
  }

  Stream<QuerySnapshot> getHistoryUChallenge() async* {
    String _userId = await _authService.getCurrentUserId();
    DateTime date = DateTime.now();
    yield* _firestoreService.users
        .doc(_userId)
        .collection('UChallenges')
        .orderBy('endDate')
        .where('endDate', isLessThan: date.millisecondsSinceEpoch)
        .snapshots();
  }

  Future<Challenge> getUChallenge(String challengeId) async {
    String _userId = await _authService.getCurrentUserId();
    return _firestoreService.users
        .doc(_userId)
        .collection('UChallenges')
        .doc(challengeId)
        .get()
        .then((value) {
      Challenge _challenge = Challenge.fromMap(value.data());
      return _challenge;
    }).onError((error, stackTrace) {
      print('An error has occurred: $error');
      return null;
    });
  }

  Future<Task> getUCTask(String challengeId, String taskId) async {
    String _userId = await _authService.getCurrentUserId();
    return _firestoreService.users
        .doc(_userId)
        .collection('UChallenges')
        .doc(challengeId)
        .collection('UCTasks')
        .doc(taskId)
        .get()
        .then((value) {
      Task _task = Task.fromMap(value.data());
      return _task;
    }).onError((error, stackTrace) {
      print('An error has occurred: $error');
      return null;
    });
  }

  Stream<DocumentSnapshot> getUChallengeStream(String challengeId) async* {
    String _userId = await _authService.getCurrentUserId();
    yield* _firestoreService.users
        .doc(_userId)
        .collection('UChallenges')
        .doc(challengeId)
        .snapshots();
  }

  // * Get Date UCTasks
  Stream<QuerySnapshot> getDateUCTasksStream(
      String challengeId, DateTime date) async* {
    String _userId = await _authService.getCurrentUserId();
    yield* _firestoreService.users
        .doc(_userId)
        .collection('UChallenges')
        .doc(challengeId)
        .collection('UCTasks')
        .where('dueDate',
            isLessThanOrEqualTo:
                DateTime(date.year, date.month, date.day, 23, 59, 59)
                    .millisecondsSinceEpoch)
        .where('dueDate', isGreaterThanOrEqualTo: date.millisecondsSinceEpoch)
        .orderBy('dueDate')
        .snapshots();
  }

  Stream<QuerySnapshot> getDateUCTasksStreamHome(DateTime date) async* {
    String _userId = await _authService.getCurrentUserId();
    yield* _firestoreService.users
        .doc(_userId)
        .collection('UChallenges')
        .doc()
        .collection('UCTasks')
        .snapshots();
  }

  Future<int> noOfChallengeCompleted() async {
    String _userId = await _authService.getCurrentUserId();
    int _noOfcompletedChallenge = await _firestoreService.users
        .doc(_userId)
        .collection('UChallenges')
        .where('completed', isEqualTo: true)
        .get()
        .then((value) => value.size);
    print(_noOfcompletedChallenge);
    return await _firestoreService.users
        .doc(_userId)
        .collection('uGeneral')
        .doc('generalData')
        .update({'noOfChallengeCompleted': _noOfcompletedChallenge}).then(
            (value) => _noOfcompletedChallenge);
  }

  Future deleteUChallenge(String challengeId) async {
    String _userId = await _authService.getCurrentUserId();
    _firestoreService.users
        .doc(_userId)
        .collection('UChallenges')
        .doc(challengeId)
        .delete();
  }

  Future deleteUCTask(String taskId, String challengeId) async {
    String _userId = await _authService.getCurrentUserId();
    int _totalUCTask = await _firestoreService.users
        .doc(_userId)
        .collection('UChallenges')
        .doc(challengeId)
        .get()
        .then((value) => value.data()['noOfTasks']);

    int _totalCompletedUCTask = await _firestoreService.users
        .doc(_userId)
        .collection('UChallenges')
        .doc(challengeId)
        .get()
        .then((value) => value.data()['noOfCompletedTasks']);

    bool currentStats = await _firestoreService.users
        .doc(_userId)
        .collection('UChallenges')
        .doc(challengeId)
        .collection('UCTasks')
        .doc(taskId)
        .get()
        .then((value) => value.data()['completed']);

    int _cminus = _totalCompletedUCTask - 1;
    int _tminus = _totalUCTask - 1;

    if (currentStats == true) {
      _firestoreService.users
          .doc(_userId)
          .collection('UChallenges')
          .doc(challengeId)
          .update({'noOfCompletedTasks': _cminus});
    }
    _firestoreService.users
        .doc(_userId)
        .collection('UChallenges')
        .doc(challengeId)
        .update({'noOfTasks': _tminus});
    _firestoreService.users
        .doc(_userId)
        .collection('UChallenges')
        .doc(challengeId)
        .collection('UCTasks')
        .doc(taskId)
        .delete();
  }
}
