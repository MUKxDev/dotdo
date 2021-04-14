import 'dart:convert';
import 'package:flutter/material.dart';

class PCTask {
  final String taskName;
  final String taskNote;
  final DateTime dueDate;
  final bool aCompleted;
  final bool bCompleted;
  final IconData iconData;
  final Color iconColor;
  PCTask({
    this.taskName,
    this.taskNote,
    this.dueDate,
    this.aCompleted,
    this.bCompleted,
    this.iconData,
    this.iconColor,
  });

  PCTask copyWith({
    String taskName,
    String taskNote,
    DateTime dueDate,
    bool aCompleted,
    bool bCompleted,
    IconData iconData,
    Color iconColor,
  }) {
    return PCTask(
      taskName: taskName ?? this.taskName,
      taskNote: taskNote ?? this.taskNote,
      dueDate: dueDate ?? this.dueDate,
      aCompleted: aCompleted ?? this.aCompleted,
      bCompleted: bCompleted ?? this.bCompleted,
      iconData: iconData ?? this.iconData,
      iconColor: iconColor ?? this.iconColor,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'taskName': taskName,
      'taskNote': taskNote,
      'dueDate': dueDate?.millisecondsSinceEpoch,
      'aCompleted': aCompleted,
      'bCompleted': bCompleted,
      'iconData': iconData?.codePoint,
      'iconColor': iconColor?.value,
    };
  }

  factory PCTask.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PCTask(
      taskName: map['taskName'],
      taskNote: map['taskNote'],
      dueDate: DateTime.fromMillisecondsSinceEpoch(map['dueDate']),
      aCompleted: map['aCompleted'],
      bCompleted: map['bCompleted'],
      iconData: IconData(map['iconData'], fontFamily: 'MaterialIcons'),
      iconColor: Color(map['iconColor']),
    );
  }

  String toJson() => json.encode(toMap());

  factory PCTask.fromJson(String source) => PCTask.fromMap(json.decode(source));

  @override
  String toString() {
    return 'PCTask(taskName: $taskName, taskNote: $taskNote, dueDate: $dueDate, aCompleted: $aCompleted, bCompleted: $bCompleted, iconData: $iconData, iconColor: $iconColor)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PCTask &&
        o.taskName == taskName &&
        o.taskNote == taskNote &&
        o.dueDate == dueDate &&
        o.aCompleted == aCompleted &&
        o.bCompleted == bCompleted &&
        o.iconData == iconData &&
        o.iconColor == iconColor;
  }

  @override
  int get hashCode {
    return taskName.hashCode ^
        taskNote.hashCode ^
        dueDate.hashCode ^
        aCompleted.hashCode ^
        bCompleted.hashCode ^
        iconData.hashCode ^
        iconColor.hashCode;
  }
}
