import 'dart:convert';

class Challanges {
  final String name;
  final String note;
  final DateTime startDate;
  final DateTime endDate;
  final bool completed;
  final int noOfParticipants;
  Challanges({
    this.name,
    this.note,
    this.startDate,
    this.endDate,
    this.completed,
    this.noOfParticipants,
  });

  Challanges copyWith({
    String name,
    String note,
    DateTime startDate,
    DateTime endDate,
    bool completed,
    int noOfParticipants,
  }) {
    return Challanges(
      name: name ?? this.name,
      note: note ?? this.note,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      completed: completed ?? this.completed,
      noOfParticipants: noOfParticipants ?? this.noOfParticipants,
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
    };
  }

  factory Challanges.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Challanges(
      name: map['name'],
      note: map['note'],
      startDate: DateTime.fromMillisecondsSinceEpoch(map['startDate']),
      endDate: DateTime.fromMillisecondsSinceEpoch(map['endDate']),
      completed: map['completed'],
      noOfParticipants: map['noOfParticipants'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Challanges.fromJson(String source) =>
      Challanges.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Challanges(name: $name, note: $note, startDate: $startDate, endDate: $endDate, completed: $completed, noOfParticipants: $noOfParticipants)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Challanges &&
        o.name == name &&
        o.note == note &&
        o.startDate == startDate &&
        o.endDate == endDate &&
        o.completed == completed &&
        o.noOfParticipants == noOfParticipants;
  }

  @override
  int get hashCode {
    return name.hashCode ^
        note.hashCode ^
        startDate.hashCode ^
        endDate.hashCode ^
        completed.hashCode ^
        noOfParticipants.hashCode;
  }
}
