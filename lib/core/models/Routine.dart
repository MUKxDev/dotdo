import 'dart:convert';

import 'package:flutter/material.dart';

class Routine {
  final String name;
  final String note;
  final String creatorId;
  final bool active;
  final bool publicRoutine;
  final int noOfLikes;
  final int noOfTasks;
  final int noOfCompletedTasks;
  final IconData iconData;
  final Color iconColor;
  Routine({
    this.name,
    this.note,
    this.creatorId,
    this.active,
    this.publicRoutine,
    this.noOfLikes,
    this.noOfTasks,
    this.noOfCompletedTasks,
    this.iconData,
    this.iconColor,
  });

  Routine copyWith({
    String name,
    String note,
    String creatorId,
    bool active,
    bool publicRoutine,
    int noOfLikes,
    int noOfTasks,
    int noOfCompletedTasks,
    IconData iconData,
    Color iconColor,
  }) {
    return Routine(
      name: name ?? this.name,
      note: note ?? this.note,
      creatorId: creatorId ?? this.creatorId,
      active: active ?? this.active,
      publicRoutine: publicRoutine ?? this.publicRoutine,
      noOfLikes: noOfLikes ?? this.noOfLikes,
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
      'creatorId': creatorId,
      'active': active,
      'publicRoutine': publicRoutine,
      'noOfLikes': noOfLikes,
      'noOfTasks': noOfTasks,
      'noOfCompletedTasks': noOfCompletedTasks,
      'iconData': iconData?.codePoint,
      'iconColor': iconColor?.value,
    };
  }

  factory Routine.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Routine(
      name: map['name'],
      note: map['note'],
      creatorId: map['creatorId'],
      active: map['active'],
      publicRoutine: map['publicRoutine'],
      noOfLikes: map['noOfLikes'],
      noOfTasks: map['noOfTasks'],
      noOfCompletedTasks: map['noOfCompletedTasks'],
      iconData: IconData(map['iconData'], fontFamily: 'MaterialIcons'),
      iconColor: Color(map['iconColor']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Routine.fromJson(String source) =>
      Routine.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Routine(name: $name, note: $note, creatorId: $creatorId, active: $active, publicRoutine: $publicRoutine, noOfLikes: $noOfLikes, noOfTasks: $noOfTasks, noOfCompletedTasks: $noOfCompletedTasks, iconData: $iconData, iconColor: $iconColor)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Routine &&
        o.name == name &&
        o.note == note &&
        o.creatorId == creatorId &&
        o.active == active &&
        o.publicRoutine == publicRoutine &&
        o.noOfLikes == noOfLikes &&
        o.noOfTasks == noOfTasks &&
        o.noOfCompletedTasks == noOfCompletedTasks &&
        o.iconData == iconData &&
        o.iconColor == iconColor;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        note.hashCode ^
        creatorId.hashCode ^
        active.hashCode ^
        publicRoutine.hashCode ^
        noOfLikes.hashCode ^
        noOfTasks.hashCode ^
        noOfCompletedTasks.hashCode ^
        iconData.hashCode ^
        iconColor.hashCode;
  }
}
