import 'dart:convert';

import 'package:flutter/material.dart';

class Task {
  final String taskName;
  final String taskNote;
  final DateTime dueDate;
  final bool completed;
  final IconData iconData;
  final Color iconColor;
  Task({
    this.taskName,
    this.taskNote,
    this.dueDate,
    this.completed,
    this.iconData,
    this.iconColor,
  });

  Task copyWith({
    String taskName,
    String taskNote,
    DateTime dueDate,
    bool completed,
    IconData iconData,
    Color iconColor,
  }) {
    return Task(
      taskName: taskName ?? this.taskName,
      taskNote: taskNote ?? this.taskNote,
      dueDate: dueDate ?? this.dueDate,
      completed: completed ?? this.completed,
      iconData: iconData ?? this.iconData,
      iconColor: iconColor ?? this.iconColor,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'taskName': taskName,
      'taskNote': taskNote,
      'dueDate': dueDate?.millisecondsSinceEpoch,
      'completed': completed,
      'iconData': iconData?.codePoint,
      'iconColor': iconColor?.value,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Task(
      taskName: map['taskName'],
      taskNote: map['taskNote'],
      dueDate: DateTime.fromMillisecondsSinceEpoch(map['dueDate']),
      completed: map['completed'],
      iconData: IconData(map['iconData'], fontFamily: 'MaterialIcons'),
      iconColor: Color(map['iconColor']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Task(taskName: $taskName, taskNote: $taskNote, dueDate: $dueDate, completed: $completed, iconData: $iconData, iconColor: $iconColor)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Task &&
        o.taskName == taskName &&
        o.taskNote == taskNote &&
        o.dueDate == dueDate &&
        o.completed == completed &&
        o.iconData == iconData &&
        o.iconColor == iconColor;
  }

  @override
  int get hashCode {
    return taskName.hashCode ^
        taskNote.hashCode ^
        dueDate.hashCode ^
        completed.hashCode ^
        iconData.hashCode ^
        iconColor.hashCode;
  }
}
