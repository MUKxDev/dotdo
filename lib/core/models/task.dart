import 'dart:convert';

class Task {
  final String taskName;
  final String taskNote;
  final DateTime dueDate;
  final bool completed;
  final String category;
  Task({
    this.taskName,
    this.taskNote,
    this.dueDate,
    this.completed,
    this.category,
  });

  Task copyWith({
    String taskName,
    String taskNote,
    DateTime dueDate,
    bool completed,
    String category,
  }) {
    return Task(
      taskName: taskName ?? this.taskName,
      taskNote: taskNote ?? this.taskNote,
      dueDate: dueDate ?? this.dueDate,
      completed: completed ?? this.completed,
      category: category ?? this.category,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'taskName': taskName,
      'taskNote': taskNote,
      'dueDate': dueDate?.millisecondsSinceEpoch,
      'completed': completed,
      'category': category,
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Task(
      taskName: map['taskName'],
      taskNote: map['taskNote'],
      dueDate: DateTime.fromMillisecondsSinceEpoch(map['dueDate']),
      completed: map['completed'],
      category: map['category'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Task(taskName: $taskName, taskNote: $taskNote, dueDate: $dueDate, completed: $completed, category: $category)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Task &&
        o.taskName == taskName &&
        o.taskNote == taskNote &&
        o.dueDate == dueDate &&
        o.completed == completed &&
        o.category == category;
  }

  @override
  int get hashCode {
    return taskName.hashCode ^
        taskNote.hashCode ^
        dueDate.hashCode ^
        completed.hashCode ^
        category.hashCode;
  }
}
