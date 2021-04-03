import 'dart:convert';

class Routine {
  final String name;
  final String note;
  final int noOfLikes;
  final bool active;
  Routine({
    this.name,
    this.note,
    this.noOfLikes,
    this.active,
  });

  Routine copyWith({
    String name,
    String note,
    int noOfLikes,
    bool active,
  }) {
    return Routine(
      name: name ?? this.name,
      note: note ?? this.note,
      noOfLikes: noOfLikes ?? this.noOfLikes,
      active: active ?? this.active,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'note': note,
      'noOfLikes': noOfLikes,
      'active': active,
    };
  }

  factory Routine.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Routine(
      name: map['name'],
      note: map['note'],
      noOfLikes: map['noOfLikes'],
      active: map['active'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Routine.fromJson(String source) =>
      Routine.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Routine(name: $name, note: $note, noOfLikes: $noOfLikes, active: $active)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Routine &&
        o.name == name &&
        o.note == note &&
        o.noOfLikes == noOfLikes &&
        o.active == active;
  }

  @override
  int get hashCode {
    return name.hashCode ^ note.hashCode ^ noOfLikes.hashCode ^ active.hashCode;
  }
}
