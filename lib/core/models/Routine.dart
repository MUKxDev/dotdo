import 'dart:convert';

class Routine {
  final String name;
  final String note;
  final int noOfLikes;
  final bool active;
  final int noOfTask;
  final int noOfCompletedTask;
  Routine({
    this.name,
    this.note,
    this.noOfLikes,
    this.active,
    this.noOfTask,
    this.noOfCompletedTask,
  });

  Routine copyWith({
    String name,
    String note,
    int noOfLikes,
    bool active,
    int noOfTask,
    int noOfCompletedTask,
  }) {
    return Routine(
      name: name ?? this.name,
      note: note ?? this.note,
      noOfLikes: noOfLikes ?? this.noOfLikes,
      active: active ?? this.active,
      noOfTask: noOfTask ?? this.noOfTask,
      noOfCompletedTask: noOfCompletedTask ?? this.noOfCompletedTask,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'note': note,
      'noOfLikes': noOfLikes,
      'active': active,
      'noOfTask': noOfTask,
      'noOfCompletedTask': noOfCompletedTask,
    };
  }

  factory Routine.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Routine(
      name: map['name'],
      note: map['note'],
      noOfLikes: map['noOfLikes'],
      active: map['active'],
      noOfTask: map['noOfTask'],
      noOfCompletedTask: map['noOfCompletedTask'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Routine.fromJson(String source) =>
      Routine.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Routine(name: $name, note: $note, noOfLikes: $noOfLikes, active: $active, noOfTask: $noOfTask, noOfCompletedTask: $noOfCompletedTask)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Routine &&
        o.name == name &&
        o.note == note &&
        o.noOfLikes == noOfLikes &&
        o.active == active &&
        o.noOfTask == noOfTask &&
        o.noOfCompletedTask == noOfCompletedTask;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        note.hashCode ^
        noOfLikes.hashCode ^
        active.hashCode ^
        noOfTask.hashCode ^
        noOfCompletedTask.hashCode;
  }
}
