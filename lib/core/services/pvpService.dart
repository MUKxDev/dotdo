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
  // creat or view pvp ----------------------
  Stream<QuerySnapshot> creatOrViewPvp(String userBId) async* {
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
  Future newChallenge(String pvpId) async {
    PChallenge pChallenge = PChallenge();
    String userAId = getUserAId(pvpId).toString();
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
  }

//add tasks ---------------------------------------------
  Future addPCtask(String pvpId, String challengeId) async {
    String _userId = await _authService.getCurrentUserId();
    int _totalPCtask = await _firestoreService.pvps
        .doc(pvpId)
        .collection('Challenges')
        .doc(challengeId)
        .get()
        .then((value) => value.data()['noOfTasks']);
    PCTask pcTask = PCTask();
    int _plus = _totalPCtask + 1;
    _firestoreService.pvps
        .doc(pvpId)
        .collection('Challenges')
        .doc(challengeId)
        .collection('PCTasks')
        .add(pcTask.toMap())
        .then((value) async {
      _firestoreService.pvps
          .doc(pvpId)
          .collection('Challenges')
          .doc(challengeId)
          .update({'noOfTasks': _plus});
    });
  }
//toggle complete--------------------------------------

  Future toggleCompletePCtask(
      String pvpId, String challengeId, String pctaskId) async {
    String _userId = await _authService.getCurrentUserId();
    String userA = getUserAId(pvpId).toString();
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
      _firestoreService.pvps
          .doc(pvpId)
          .collection('Challenges')
          .doc(challengeId)
          .collection('PCTasks')
          .doc(pctaskId)
          .update({'aCompleted': !(_currentAStatus)});
      if (_currentAStatus == false) {
        _firestoreService.pvps
            .doc(pvpId)
            .collection('Challenges')
            .doc(challengeId)
            .update({'aCTask': _plus});
      } else {
        _firestoreService.pvps
            .doc(pvpId)
            .collection('Challenges')
            .doc(challengeId)
            .update({'aCTask': _minus});
      }
      if (_totaltask == _totalACompletedPCtask) {
        _firestoreService.pvps
            .doc(pvpId)
            .collection('Challenges')
            .doc(challengeId)
            .update({'aComplete': true});
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
      _firestoreService.pvps
          .doc(pvpId)
          .collection('Challenges')
          .doc(challengeId)
          .collection('PCTasks')
          .doc(pctaskId)
          .update({'bCompleted': !(_currentAStatus)});
      if (_currentAStatus == false) {
        _firestoreService.pvps
            .doc(pvpId)
            .collection('Challenges')
            .doc(challengeId)
            .update({'bCTask': _plus});
      } else {
        _firestoreService.pvps
            .doc(pvpId)
            .collection('Challenges')
            .doc(challengeId)
            .update({'bCTask': _minus});
      }
      if (_totaltask == _totalBCompletedPCtask) {
        _firestoreService.pvps
            .doc(pvpId)
            .collection('Challenges')
            .doc(challengeId)
            .update({'bComplete': true});
      }
    }
  }

//get challange -----------------------------------------
  Stream<QuerySnapshot> getPendingChallenge(String pvpId) async* {
    DateTime date = DateTime.now();
    yield* _firestoreService.pvps
        .doc(pvpId)
        .collection('Challenges')
        .where('status', isEqualTo: 'Pending')
        .orderBy('endDate')
        .where('endDate', isGreaterThanOrEqualTo: date.millisecondsSinceEpoch)
        .where('startdate', isLessThan: date.microsecondsSinceEpoch)
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
    String userA = getUserAId(pvpId).toString();
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
    if (_userId == userA) {
      _firestoreService.pvps
          .doc(pvpId)
          .collection('Challenges')
          .doc(challengeId)
          .update({'aStatus': 'Accept'});

      if (userBstatus == userAstatus) {
        _firestoreService.pvps
            .doc(pvpId)
            .collection('Challenges')
            .doc(challengeId)
            .update({'status': 'Active'});
      }
    } else {
      _firestoreService.pvps
          .doc(pvpId)
          .collection('Challenges')
          .doc(challengeId)
          .update({'bStatus': 'Accept'});

      if (userBstatus == userAstatus) {
        _firestoreService.pvps
            .doc(pvpId)
            .collection('Challenges')
            .doc(challengeId)
            .update({'status': 'Active'});
      }
    }
  }

  Future toggleDecline(String pvpId, String challengeId) async {
    String _userId = await _authService.getCurrentUserId();
    String userA = getUserAId(pvpId).toString();
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
        .then((value) => value.data()['aStatus']);

    bool currentBStatus = await _firestoreService.pvps
        .doc(pvpId)
        .collection('Challenges')
        .doc(challengeId)
        .get()
        .then((value) => value.data()['bStatus']);

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
    String userA = getUserAId(pvpId).toString();
    String userB = getUserBId(pvpId).toString();
    DateTime now = DateTime.now();
    int _dPlus = draw + 1;
    int _aPlus = aWinng + 1;
    int _bPlus = bWinning + 1;
    if (currentStatus == 'Active' && enddate > now.millisecondsSinceEpoch) {
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
        _firestoreService.pvps.doc(pvpId).update({'draws': _aPlus});

        _firestoreService.pvps
            .doc(pvpId)
            .collection('Challenges')
            .doc(challengeId)
            .update({'challangeWinner': userA, 'status': 'Completed'});
      } else {
        _firestoreService.pvps.doc(pvpId).update({'draws': _bPlus});

        _firestoreService.pvps
            .doc(pvpId)
            .collection('Challenges')
            .doc(challengeId)
            .update({'challangeWinner': userB, 'status': 'Completed'});
      }
    }
  }

// get status ---------------------------
  Future<String> getUserStatus(String pvpId, String challengeId) async {
    String _userId = await _authService.getCurrentUserId();
    String userA = getUserAId(pvpId).toString();
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

  Future<String> getUserBId(String pvpId) async {
    String userB = await _firestoreService.pvps
        .doc(pvpId)
        .get()
        .then((value) => value.data()['userB']);
    return userB;
  }
}
