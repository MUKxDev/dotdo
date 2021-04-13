import 'dart:convert';

import 'package:flutter/material.dart';

class Challenge {
  final String name;
  final String note;
  final DateTime startDate;
  final DateTime endDate;
  final bool completed;
  final int noOfParticipants;
  final int noOfTasks;
  final int noOfCompletedTasks;
  final IconData iconData;
  final Color iconColor;
  Challenge({
    this.name,
    this.note,
    this.startDate,
    this.endDate,
    this.completed,
    this.noOfParticipants,
    this.noOfTasks,
    this.noOfCompletedTasks,
    this.iconData,
    this.iconColor,
  });

  Challenge copyWith({
    String name,
    String note,
    DateTime startDate,
    DateTime endDate,
    bool completed,
    int noOfParticipants,
    int noOfTasks,
    int noOfCompletedTasks,
    IconData iconData,
    Color iconColor,
  }) {
    return Challenge(
      name: name ?? this.name,
      note: note ?? this.note,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      completed: completed ?? this.completed,
      noOfParticipants: noOfParticipants ?? this.noOfParticipants,
      noOfTasks: noOfTasks ?? this.noOfTasks,
      noOfCompletedTasks: noOfCompletedTasks ?? this.noOfCompletedTasks,
      iconData: iconData ?? this.iconData,
      iconColor: iconColor ?? this.iconColor,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'note': note,
      'startDate': startDate?.millisecondsSinceEpoch,
      'endDate': endDate?.millisecondsSinceEpoch,
      'completed': completed,
      'noOfParticipants': noOfParticipants,
      'noOfTasks': noOfTasks,
      'noOfCompletedTasks': noOfCompletedTasks,
      'iconData': iconData?.codePoint,
      'iconColor': iconColor?.value,
    };
  }

  factory Challenge.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Challenge(
      name: map['name'],
      note: map['note'],
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate']),
      endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate']),
      completed: map['completed'],
      noOfParticipants: map['noOfParticipants'],
      noOfTasks: map['noOfTasks'],
      noOfCompletedTasks: map['noOfCompletedTasks'],
      iconData: IconData(map['iconData'], fontFamily: 'MaterialIcons'),
      iconColor: Color(map['iconColor']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Challenge.fromJson(String source) =>
      Challenge.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Challenge(name: $name, note: $note, startDate: $startDate, endDate: $endDate, completed: $completed, noOfParticipants: $noOfParticipants, noOfTasks: $noOfTasks, noOfCompletedTasks: $noOfCompletedTasks, iconData: $iconData, iconColor: $iconColor)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Challenge &&
        o.name == name &&
        o.note == note &&
        o.startDate == startDate &&
        o.endDate == endDate &&
        o.completed == completed &&
        o.noOfParticipants == noOfParticipants &&
        o.noOfTasks == noOfTasks &&
        o.noOfCompletedTasks == noOfCompletedTasks &&
        o.iconData == iconData &&
        o.iconColor == iconColor;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        note.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        completed.hashCode ^
        noOfParticipants.hashCode ^
        noOfTasks.hashCode ^
        noOfCompletedTasks.hashCode ^
        iconData.hashCode ^
        iconColor.hashCode;
  }
}
