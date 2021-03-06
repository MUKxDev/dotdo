import 'package:dotdo/core/models/task.dart';

class TaskService {
  List<Task> get taskList => _taskList;

  List<Task> _taskList = [
    Task(
        public: true,
        checked: true,
        lable: 'A task is done',
        due: DateTime.now(),
        category: 'Work',
        id: '1'),
    Task(
        public: false,
        checked: false,
        lable: 'A task to be done',
        due: DateTime.now(),
        category: 'Work',
        id: '2'),
    Task(
        public: true,
        checked: true,
        lable: 'A task is done',
        due: DateTime.now(),
        category: 'Work',
        id: '3'),
    Task(
        public: true,
        checked: false,
        lable: 'A task to be done',
        due: DateTime.now(),
        category: 'Work',
        id: '4'),
    Task(
        public: false,
        checked: false,
        lable: 'A task to be done',
        due: DateTime.now(),
        category: 'Work',
        id: '5'),
  ];
}
