import 'dart:convert';

class Task {
  final bool public;
  final bool checked;
  final String lable;
  final DateTime due;
  final String category;
  final String id;
  Task({
    this.public,
    this.checked,
    this.lable,
    this.due,
    this.category,
    this.id,
  });

  Task copyWith({
    bool public,
    bool checked,
    String lable,
    DateTime due,
    String category,
    String id,
  }) {
    return Task(
      public: public ?? this.public,
      checked: checked ?? this.checked,
      lable: lable ?? this.lable,
      due: due ?? this.due,
      category: category ?? this.category,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'public': public,
      'checked': checked,
      'lable': lable,
      'due': due?.millisecondsSinceEpoch,
      'category': category,
      'id': id,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Task(
      public: map['public'],
      checked: map['checked'],
      lable: map['lable'],
      due: DateTime.fromMillisecondsSinceEpoch(map['due']),
      category: map['category'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Task(public: $public, checked: $checked, lable: $lable, due: $due, category: $category, id: $id)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Task &&
        o.public == public &&
        o.checked == checked &&
        o.lable == lable &&
        o.due == due &&
        o.category == category &&
        o.id == id;
  }

  @override
  int get hashCode {
    return public.hashCode ^
        checked.hashCode ^
        lable.hashCode ^
        due.hashCode ^
        category.hashCode ^
        id.hashCode;
  }
}
