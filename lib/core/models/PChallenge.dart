import 'dart:convert';

import 'package:flutter/material.dart';

class PChallenge {
  final String name;
  final String note;
  final DateTime startDate;
  final DateTime endDate;
  final int noOfTasks;
  final IconData iconData;
  final Color iconColor;
  final String challangeWinner;
  final String status;
  final String aStatus;
  final String bStatus;
  final int aCTask;
  final int bCTask;
  final bool aComplete;
  final bool bComplete;
  PChallenge({
    this.name,
    this.note,
    this.startDate,
    this.endDate,
    this.noOfTasks,
    this.iconData,
    this.iconColor,
    this.challangeWinner,
    this.status,
    this.aStatus,
    this.bStatus,
    this.aCTask,
    this.bCTask,
    this.aComplete,
    this.bComplete,
  });

  PChallenge copyWith({
    String name,
    String note,
    DateTime startDate,
    DateTime endDate,
    int noOfTasks,
    IconData iconData,
    Color iconColor,
    String challangeWinner,
    String status,
    String aStatus,
    String bStatus,
    int aCTask,
    int bCTask,
    bool aComplete,
    bool bComplete,
  }) {
    return PChallenge(
      name: name ?? this.name,
      note: note ?? this.note,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      noOfTasks: noOfTasks ?? this.noOfTasks,
      iconData: iconData ?? this.iconData,
      iconColor: iconColor ?? this.iconColor,
      challangeWinner: challangeWinner ?? this.challangeWinner,
      status: status ?? this.status,
      aStatus: aStatus ?? this.aStatus,
      bStatus: bStatus ?? this.bStatus,
      aCTask: aCTask ?? this.aCTask,
      bCTask: bCTask ?? this.bCTask,
      aComplete: aComplete ?? this.aComplete,
      bComplete: bComplete ?? this.bComplete,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'note': note,
      'startDate': startDate?.millisecondsSinceEpoch,
      'endDate': endDate?.millisecondsSinceEpoch,
      'noOfTasks': noOfTasks,
      'iconData': iconData?.codePoint,
      'iconColor': iconColor?.value,
      'challangeWinner': challangeWinner,
      'status': status,
      'aStatus': aStatus,
      'bStatus': bStatus,
      'aCTask': aCTask,
      'bCTask': bCTask,
      'aComplete': aComplete,
      'bComplete': bComplete,
    };
  }

  factory PChallenge.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PChallenge(
      name: map['name'],
      note: map['note'],
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate']),
      endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate']),
      noOfTasks: map['noOfTasks'],
      iconData: IconData(map['iconData'], fontFamily: 'MaterialIcons'),
      iconColor: Color(map['iconColor']),
      challangeWinner: map['challangeWinner'],
      status: map['status'],
      aStatus: map['aStatus'],
      bStatus: map['bStatus'],
      aCTask: map['aCTask'],
      bCTask: map['bCTask'],
      aComplete: map['aComplete'],
      bComplete: map['bComplete'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PChallenge.fromJson(String source) =>
      PChallenge.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PChallenge(name: $name, note: $note, startDate: $startDate, endDate: $endDate, noOfTasks: $noOfTasks, iconData: $iconData, iconColor: $iconColor, challangeWinner: $challangeWinner, status: $status, aStatus: $aStatus, bStatus: $bStatus, aCTask: $aCTask, bCTask: $bCTask, aComplete: $aComplete, bComplete: $bComplete)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PChallenge &&
        o.name == name &&
        o.note == note &&
        o.startDate == startDate &&
        o.endDate == endDate &&
        o.noOfTasks == noOfTasks &&
        o.iconData == iconData &&
        o.iconColor == iconColor &&
        o.challangeWinner == challangeWinner &&
        o.status == status &&
        o.aStatus == aStatus &&
        o.bStatus == bStatus &&
        o.aCTask == aCTask &&
        o.bCTask == bCTask &&
        o.aComplete == aComplete &&
        o.bComplete == bComplete;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        note.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        noOfTasks.hashCode ^
        iconData.hashCode ^
        iconColor.hashCode ^
        challangeWinner.hashCode ^
        status.hashCode ^
        aStatus.hashCode ^
        bStatus.hashCode ^
        aCTask.hashCode ^
        bCTask.hashCode ^
        aComplete.hashCode ^
        bComplete.hashCode;
  }
}
