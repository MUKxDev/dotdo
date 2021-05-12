import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotdo/core/models/PChallenge.dart';
import 'package:dotdo/core/models/pcTask.dart';
import 'package:dotdo/core/models/pvp.dart';

import '../locator.dart';
import 'authService.dart';
import 'firestoreService.dart';

class PvpService {
  FirestoreService _firestoreService = locator<FirestoreService>();
  AuthService _authService = locator<AuthService>();

  // createPVP if not found
  Future createPVP(String userBId) async {
    String _userId = await _authService.getCurrentUserId();
    Pvp pvp =
        Pvp(userA: _userId, userB: userBId, aWinng: 0, bWinning: 0, draws: 0);

    int optionA = await _firestoreService.pvps
        .where('userB', isEqualTo: userBId)
        .where('userA', isEqualTo: _userId)
        .get()
        .then((value) => value.size);

    int optionB = await _firestoreService.pvps
        .where('userB', isEqualTo: _userId)
        .where('userA', isEqualTo: userBId)
        .get()
        .then((value) => value.size);

    int noOfFound = optionB + optionA;

    if (noOfFound == null || noOfFound == 0) {
      print(await _firestoreService.pvps
          .add(pvp.toMap())
          .then((value) => value.id));
    }
  }

  // creat or view pvp ----------------------
  Stream<QuerySnapshot> creatOrViewPvp(String userBId) async* {
    String _userId = await _authService.getCurrentUserId();
    if (await _firestoreService.pvps
            .where('userB', isEqualTo: userBId)
            .where('userA', isEqualTo: _userId)
            .get()
            .then((value) => value.size) >
        0) {
      yield* _firestoreService.pvps
          .where('userB', isEqualTo: userBId)
          .where('userA', isEqualTo: _userId)
          .snapshots();
    } else {
      yield* _firestoreService.pvps
          .where('userB', isEqualTo: _userId)
          .where('userA', isEqualTo: userBId)
          .snapshots();
    }
  }

  Future<String> getPvpId(String oppId) async {
    String _userId = await _authService.getCurrentUserId();
    int optionA = await _firestoreService.pvps
        .where('userB', isEqualTo: oppId)
        .where('userA', isEqualTo: _userId)
        .get()
        .then((value) => value.size);
    String pvpId;
    if (optionA > 0) {
      pvpId = await _firestoreService.pvps
          .where('userB', isEqualTo: oppId)
          .where('userA', isEqualTo: _userId)
          .get()
          .then((value) => value.docs.first.id);
    } else {
      pvpId = await _firestoreService.pvps
          .where('userB', isEqualTo: _userId)
          .where('userA', isEqualTo: oppId)
          .get()
          .then((value) => value.docs.first.id);
    }
    return pvpId;
  }

  Future optionA(String userBId) async {
    String _userId = await _authService.getCurrentUserId();
    int optionA = await _firestoreService.pvps
        .where('userB', isEqualTo: userBId)
        .where('userA', isEqualTo: _userId)
        .get()
        .then((value) => value.size);

    return optionA;
  }

  // new challenge ---------------------------
  Future newChallenge(String pvpId, PChallenge pChallenge) async {
    String userAId = await getUserAId(pvpId);
    String challengeId = await _firestoreService.pvps
        .doc(pvpId)
        .collection('Challenges')
        .add(pChallenge.toMap())
        .then((value) => value.id);
    String _userId = await _authService.getCurrentUserId();
    if (userAId == _userId)
      startingpackA(pvpId, challengeId);
    else
      startingpackB(pvpId, challengeId);

    return challengeId;
  }

//add tasks ---------------------------------------------
  Future<bool> addPCtask(
      String pvpId, String challengeId, PCTask pcTask) async {
    int _totalPCtask = await _firestoreService.pvps
        .doc(pvpId)
        .collection('Challenges')
        .doc(challengeId)
        .get()
        .then((value) => value.data()['noOfTasks']);
    int _plus = _totalPCtask + 1;
    bool _added;
    _added = await _firestoreService.pvps
        .doc(pvpId)
        .collection('Challenges')
        .doc(challengeId)
        .collection('PCTasks')
        .add(pcTask.toMap())
        .then((value) async {
      await _firestoreService.pvps
          .doc(pvpId)
          .collection('Challenges')
          .doc(challengeId)
          .update({'noOfTasks': _plus});
      return true;
    }).onError((error, stackTrace) => false);
    return _added;
  }
//toggle complete--------------------------------------

  Future toggleCompletePCtask(
      String pvpId, String challengeId, String pctaskId) async {
    String _userId = await _authService.getCurrentUserId();
    String userA = await getUserAId(pvpId);
    int _totaltask = await _firestoreService.pvps
        .doc(pvpId)
        .collection('Challenges')
        .doc(challengeId)
        .get()
        .then((value) => value.data()['noOfTasks']);

    if (userA == _userId) {
      int _totalACompletedPCtask = await _firestoreService.pvps
          .doc(pvpId)
          .collection('Challenges')
          .doc(challengeId)
          .get()
          .then((value) => value.data()['aCTask']);
      bool _currentAStatus = await _firestoreService.pvps
          .doc(pvpId)
          .collection('Challenges')
          .doc(challengeId)
          .collection('PCTasks')
          .doc(pctaskId)
          .get()
          .then((value) => value.data()['aCompleted']);
      int _plus = _totalACompletedPCtask + 1;
      int _minus = _totalACompletedPCtask - 1;
      await _firestoreService.pvps
          .doc(pvpId)
          .collection('Challenges')
          .doc(challengeId)
          .collection('PCTasks')
          .doc(pctaskId)
          .update({'aCompleted': !(_currentAStatus)});
      if (_currentAStatus == false) {
        await _firestoreService.pvps
            .doc(pvpId)
            .collection('Challenges')
            .doc(challengeId)
            .update({'aCTask': _plus});
      } else {
        await _firestoreService.pvps
            .doc(pvpId)
            .collection('Challenges')
            .doc(challengeId)
            .update({'aCTask': _minus});
      }
      _totalACompletedPCtask = await _firestoreService.pvps
          .doc(pvpId)
          .collection('Challenges')
          .doc(challengeId)
          .get()
          .then((value) => value.data()['aCTask']);
      if (_totaltask == _totalACompletedPCtask) {
        await _firestoreService.pvps
            .doc(pvpId)
            .collection('Challenges')
            .doc(challengeId)
            .update({'aComplete': true});
      } else {
        await _firestoreService.pvps
            .doc(pvpId)
            .collection('Challenges')
            .doc(challengeId)
            .update({'aComplete': false});
      }
    } else {
      int _totalBCompletedPCtask = await _firestoreService.pvps
          .doc(pvpId)
          .collection('Challenges')
          .doc(challengeId)
          .get()
          .then((value) => value.data()['bCTask']);
      bool _currentAStatus = await _firestoreService.pvps
          .doc(pvpId)
          .collection('Challenges')
          .doc(challengeId)
          .collection('PCTasks')
          .doc(pctaskId)
          .get()
          .then((value) => value.data()['bCompleted']);
      int _plus = _totalBCompletedPCtask + 1;
      int _minus = _totalBCompletedPCtask - 1;
      await _firestoreService.pvps
          .doc(pvpId)
          .collection('Challenges')
          .doc(challengeId)
          .collection('PCTasks')
          .doc(pctaskId)
          .update({'bCompleted': !(_currentAStatus)});
      if (_currentAStatus == false) {
        await _firestoreService.pvps
            .doc(pvpId)
            .collection('Challenges')
            .doc(challengeId)
            .update({'bCTask': _plus});
      } else {
        await _firestoreService.pvps
            .doc(pvpId)
            .collection('Challenges')
            .doc(challengeId)
            .update({'bCTask': _minus});
      }
      _totalBCompletedPCtask = await _firestoreService.pvps
          .doc(pvpId)
          .collection('Challenges')
          .doc(challengeId)
          .get()
          .then((value) => value.data()['bCTask']);
      if (_totaltask == _totalBCompletedPCtask) {
        await _firestoreService.pvps
            .doc(pvpId)
            .collection('Challenges')
            .doc(challengeId)
            .update({'bComplete': true});
      } else {
        await _firestoreService.pvps
            .doc(pvpId)
            .collection('Challenges')
            .doc(challengeId)
            .update({'bComplete': false});
      }
    }
  }

//get challange -----------------------------------------

  Future<PChallenge> getPChallenge(String pvpId, String challengeId) async {
    PChallenge _pC;
    _pC = PChallenge.fromMap(await _firestoreService.pvps
        .doc(pvpId)
        .collection('Challenges')
        .doc(challengeId)
        .get()
        .then((value) => value.data()));

    return _pC;
  }

  Future<QuerySnapshot> getAllActiveUPvp() async {
    return _firestoreService.users
        .doc(await _authService.getCurrentUserId())
        .collection('PvpChallenges')
        .get();
  }

  Stream<QuerySnapshot> getAllPvpsA() async* {
    String _userId = await _authService.getCurrentUserId();
    yield* _firestoreService.pvps
        .where('userA', isEqualTo: _userId)
        .snapshots();
  }

  Stream<QuerySnapshot> getAllPvpsB() async* {
    String _userId = await _authService.getCurrentUserId();
    yield* _firestoreService.pvps
        .where('userB', isEqualTo: _userId)
        .snapshots();
  }

  Future<PCTask> getTask(
      String pvpId, String challengeId, String taskId) async {
    PCTask pcTask;
    await _firestoreService.pvps
        .doc(pvpId)
        .collection('Challenges')
        .doc(challengeId)
        .collection('PCTasks')
        .doc(taskId)
        .get()
        .then((value) {
      pcTask = PCTask.fromMap(value.data());
    });
    return pcTask;
  }

  Stream<QuerySnapshot> getPendingChallenge(String pvpId) async* {
    DateTime date = DateTime.now();
    yield* _firestoreService.pvps
        .doc(pvpId)
        .collection('Challenges')
        .where('status', isEqualTo: 'pending')
        .orderBy('endDate')
        .where('endDate', isGreaterThanOrEqualTo: date.millisecondsSinceEpoch)
        .snapshots();
  }

  Stream<QuerySnapshot> getCompletedChallenge(String pvpId) async* {
    yield* _firestoreService.pvps
        .doc(pvpId)
        .collection('Challenges')
        .where('status', isEqualTo: 'Completed')
        .orderBy('endDate')
        .snapshots();
  }

  Stream<QuerySnapshot> getActiveChallenge(String pvpId) async* {
    yield* _firestoreService.pvps
        .doc(pvpId)
        .collection('Challenges')
        .where('status', isEqualTo: 'Active')
        .orderBy('endDate')
        .snapshots();
  }

  Future<bool> isThereActiveChallange(String pvpId) async {
    QuerySnapshot querySnapshot = await _firestoreService.pvps
        .doc(pvpId)
        .collection('Challenges')
        .where('status', isEqualTo: 'Active')
        .get();

    return querySnapshot.size >= 1 ? true : false;
  }

// get task
  Stream<QuerySnapshot> getPCTask(String pvpId, String challengeId) async* {
    yield* _firestoreService.pvps
        .doc(pvpId)
        .collection('Challenges')
        .doc(challengeId)
        .collection('PCTasks')
        .snapshots();
  }

// toggle challenge acception ------------
  Future toggleAccept(String pvpId, String challengeId) async {
    String _userId = await _authService.getCurrentUserId();
    String userA = await getUserAId(pvpId);
    String userB = await getUserBId(pvpId);
    if (_userId == userA) {
      await _firestoreService.pvps
          .doc(pvpId)
          .collection('Challenges')
          .doc(challengeId)
          .update({'aStatus': 'Accept'});

      accept(pvpId, challengeId);
    } else {
      await _firestoreService.pvps
          .doc(pvpId)
          .collection('Challenges')
          .doc(challengeId)
          .update({'bStatus': 'Accept'});

      accept(pvpId, challengeId);
    }
    await _firestoreService.users
        .doc(userA)
        .collection('PvpChallenges')
        .add({'PvpId': pvpId, 'ChallengeId': challengeId});

    await _firestoreService.users
        .doc(userB)
        .collection('PvpChallenges')
        .add({'PvpId': pvpId, 'ChallengeId': challengeId});
  }

  Future accept(String pvpId, String challengeId) async {
    String userAstatus = await _firestoreService.pvps
        .doc(pvpId)
        .collection('Challenges')
        .doc(challengeId)
        .get()
        .then((value) => value.data()['aStatus']);
    String userBstatus = await _firestoreService.pvps
        .doc(pvpId)
        .collection('Challenges')
        .doc(challengeId)
        .get()
        .then((value) => value.data()['bStatus']);
    if (userBstatus == userAstatus) {
      _firestoreService.pvps
          .doc(pvpId)
          .collection('Challenges')
          .doc(challengeId)
          .update({'status': 'Active'});
    }
  }

  Future toggleDecline(String pvpId, String challengeId) async {
    String _userId = await _authService.getCurrentUserId();
    String userA = await getUserAId(pvpId);
    if (userA == _userId) {
      _firestoreService.pvps
          .doc(pvpId)
          .collection('Challenges')
          .doc(challengeId)
          .update({'aStatus': 'Decline'});
    } else {
      _firestoreService.pvps
          .doc(pvpId)
          .collection('Challenges')
          .doc(challengeId)
          .update({'bStatus': 'decline'});
    }
    _firestoreService.pvps
        .doc(pvpId)
        .collection('Challenges')
        .doc(challengeId)
        .update({'status': 'Decline'});
  }

// toggle completed ---------------------
  Future toggleCompleted(String pvpId) async {
    int _noOfFound = await _firestoreService.pvps
        .doc(pvpId)
        .collection('Challenges')
        .where('status', isEqualTo: 'Active')
        .get()
        .then((value) => value.size);
    if (_noOfFound >= 1) {
      String challengeId = await _firestoreService.pvps
          .doc(pvpId)
          .collection('Challenges')
          .where('status', isEqualTo: 'Active')
          .get()
          .asStream()
          .first
          .then((value) => value.docs.first.id);

      String currentStatus = await _firestoreService.pvps
          .doc(pvpId)
          .collection('Challenges')
          .doc(challengeId)
          .get()
          .then((value) => value.data()['status']);

      bool currentAStatus = await _firestoreService.pvps
          .doc(pvpId)
          .collection('Challenges')
          .doc(challengeId)
          .get()
          .then((value) => value.data()['aComplete']);

      bool currentBStatus = await _firestoreService.pvps
          .doc(pvpId)
          .collection('Challenges')
          .doc(challengeId)
          .get()
          .then((value) => value.data()['bComplete']);

      int draw = await _firestoreService.pvps
          .doc(pvpId)
          .get()
          .then((value) => value.data()['draws']);

      int aWinng = await _firestoreService.pvps
          .doc(pvpId)
          .get()
          .then((value) => value.data()['aWinng']);

      int bWinning = await _firestoreService.pvps
          .doc(pvpId)
          .get()
          .then((value) => value.data()['bWinning']);

      int enddate = await _firestoreService.pvps
          .doc(pvpId)
          .collection('Challenges')
          .doc(challengeId)
          .get()
          .then((value) => value.data()['endDate']);

      print('test: $enddate');

      String userA = await getUserAId(pvpId);
      String userB = await getUserBId(pvpId);

      DateTime now = DateTime.now();

      int _dPlus = draw + 1;
      int _aPlus = aWinng + 1;
      int _bPlus = bWinning + 1;

      if (currentStatus == 'Active' && enddate <= now.millisecondsSinceEpoch) {
        if (currentAStatus == true && currentBStatus == true) {
          _firestoreService.pvps.doc(pvpId).update({'draws': _dPlus});

          _firestoreService.pvps
              .doc(pvpId)
              .collection('Challenges')
              .doc(challengeId)
              .update({'challangeWinner': 'Draw', 'status': 'Completed'});
        } else if (currentAStatus == false && currentBStatus == false) {
          _firestoreService.pvps.doc(pvpId).update({'draws': _dPlus});

          _firestoreService.pvps
              .doc(pvpId)
              .collection('Challenges')
              .doc(challengeId)
              .update({'challangeWinner': 'Draw', 'status': 'Completed'});
        } else if (currentAStatus == true && currentBStatus == false) {
          _firestoreService.pvps.doc(pvpId).update({'aWinng': _aPlus});

          _firestoreService.pvps
              .doc(pvpId)
              .collection('Challenges')
              .doc(challengeId)
              .update({'challangeWinner': userA, 'status': 'Completed'});
        } else {
          _firestoreService.pvps.doc(pvpId).update({'bWinning': _bPlus});

          _firestoreService.pvps
              .doc(pvpId)
              .collection('Challenges')
              .doc(challengeId)
              .update({'challangeWinner': userB, 'status': 'Completed'});
        }
        String aId = await _firestoreService.users
            .doc(userA)
            .collection('PvpChallenges')
            .where('PvpId', isEqualTo: pvpId)
            .where('ChallengeId', isEqualTo: challengeId)
            .get()
            .then((value) => value.docs.first.id);
        String bId = await _firestoreService.users
            .doc(userB)
            .collection('PvpChallenges')
            .where('PvpId', isEqualTo: pvpId)
            .where('ChallengeId', isEqualTo: challengeId)
            .get()
            .then((value) => value.docs.first.id);
        await _firestoreService.users
            .doc(userA)
            .collection('PvpChallenges')
            .doc(aId)
            .delete();
        await _firestoreService.users
            .doc(userB)
            .collection('PvpChallenges')
            .doc(bId)
            .delete();
      }
    }
  }

// get status ---------------------------
  Future<String> getUserStatus(String pvpId, String challengeId) async {
    String _userId = await _authService.getCurrentUserId();
    String userA = await getUserAId(pvpId);
    String currentStatus;
    if (userA == _userId) {
      currentStatus = await _firestoreService.pvps
          .doc(pvpId)
          .collection('Challenges')
          .doc(challengeId)
          .get()
          .then((value) => value.data()['aStatus']);
    } else {
      currentStatus = await _firestoreService.pvps
          .doc(pvpId)
          .collection('Challenges')
          .doc(challengeId)
          .get()
          .then((value) => value.data()['bStatus']);
    }

    return currentStatus;
  }

// strting pack ------------------------------------------
  Future startingpackA(String pvpId, String challengeId) async {
    _firestoreService.pvps
        .doc(pvpId)
        .collection('Challenges')
        .doc(challengeId)
        .update({
      'status': 'pending',
      'aStatus': 'Accept',
      'bStatus': 'pending',
      'aCTask': 0,
      'bCTask': 0,
      'aComplete': false,
      'bComplete': false
    });
  }

  Future startingpackB(String pvpId, String challengeId) async {
    _firestoreService.pvps
        .doc(pvpId)
        .collection('Challenges')
        .doc(challengeId)
        .update({
      'status': 'pending',
      'aStatus': 'pending',
      'bStatus': 'Accept',
      'aCTask': 0,
      'bCTask': 0,
      'aComplete': false,
      'bComplete': false
    });
  }

// get Id ------------------------------------------
  Future<String> getUserAId(String pvpId) async {
    String userA = await _firestoreService.pvps
        .doc(pvpId)
        .get()
        .then((value) => value.data()['userA']);
    return userA;
  }

  Future<int> getNoOfPending(String pvpId) async {
    DateTime date = DateTime.now();
    return await _firestoreService.pvps
        .doc(pvpId)
        .collection('Challenges')
        .where('status', isEqualTo: 'pending')
        .where('endDate', isGreaterThanOrEqualTo: date.millisecondsSinceEpoch)
        .get()
        .then((value) => value.size);
  }

  Future<String> getUserBId(String pvpId) async {
    String userB = await _firestoreService.pvps
        .doc(pvpId)
        .get()
        .then((value) => value.data()['userB']);
    return userB;
  }
}
