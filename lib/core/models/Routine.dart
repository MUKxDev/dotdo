import 'dart:convert';

import 'package:flutter/material.dart';

class Routine {
  final String name;
  final String note;
  final bool active;
  final int noOfLikes;
  final int noOfTasks;
  final int noOfCompletedTasks;
  final IconData iconData;
  final Color iconColor;
  Routine({
    this.name,
    this.note,
    this.active,
    this.noOfLikes,
    this.noOfTasks,
    this.noOfCompletedTasks,
    this.iconData,
    this.iconColor,
  });

  Routine copyWith({
    String name,
    String note,
    bool active,
    int noOfLikes,
    int noOfTasks,
    int noOfCompletedTasks,
    IconData iconData,
    Color iconColor,
  }) {
    return Routine(
      name: name ?? this.name,
      note: note ?? this.note,
      active: active ?? this.active,
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
      'active': active,
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
      active: map['active'],
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
    return 'Routine(name: $name, note: $note, active: $active, noOfLikes: $noOfLikes, noOfTasks: $noOfTasks, noOfCompletedTasks: $noOfCompletedTasks, iconData: $iconData, iconColor: $iconColor)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Routine &&
        o.name == name &&
        o.note == note &&
        o.active == active &&
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
        active.hashCode ^
        noOfLikes.hashCode ^
        noOfTasks.hashCode ^
        noOfCompletedTasks.hashCode ^
        iconData.hashCode ^
        iconColor.hashCode;
  }
}
