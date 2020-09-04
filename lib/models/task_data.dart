import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:todoapp/db_helper/gb_helper.dart';
import 'package:todoapp/models/task.dart';
import 'package:todoapp/models/todo.dart';

class TaskData extends ChangeNotifier {
  List<Todo> _lists = [
    Todo(
      id: 'All',
      title: 'All',
      icon: FontAwesomeIcons.clipboardList,
      colorIcon: Color(0xFF5A87FC),
    ),
    Todo(
      id: 'Work',
      title: 'Work',
      icon: FontAwesomeIcons.businessTime,
      colorIcon: Color(0xFFFABA79),
    ),
    Todo(
      id: 'Music',
      title: 'Music',
      icon: FontAwesomeIcons.headphones,
      colorIcon: Color(0xFFF39481),
    ),
    Todo(
      id: 'Travel',
      title: 'Travel',
      icon: FontAwesomeIcons.plane,
      colorIcon: Color(0xFF58CA7C),
    ),
    Todo(
      id: 'Study',
      title: 'Study',
      icon: FontAwesomeIcons.stickyNote,
      colorIcon: Color(0xFF8D85D1),
    ),
    Todo(
      id: 'Home',
      title: 'Home',
      icon: FontAwesomeIcons.home,
      colorIcon: Color(0xFFD87569),
    ),
  ];
  List<TaskItem> _tasks = [];

  List<Todo> get lists => _lists;
  List<TaskItem> get tasks => _tasks;
  Todo findById(String id) {
    return _lists.firstWhere((element) => element.id == id);
  }
  List<TaskItem> filter(String name) {
    return _tasks
        .where((element) => element.categoryId.contains(name))
        .toList();
  }
  Future<void> addTask({String newTaskTitle,String category,String time})async {
    final task = TaskItem(name: newTaskTitle,categoryId: category,time: time,);
    _tasks.add(task);
    await DbHelper.insert(task);
    notifyListeners();

  }
  Future<void> fetchData() async {
    final dataList = await DbHelper.getData();
    _tasks = dataList
        .map(
          (item) => TaskItem(
            id:item['id'],
            name: item['name'],
            categoryId: item['category'],
            time: item['time'],
            isDone: item['done'] == 1 ? true : false,
          ),
    )
        .toList();
    notifyListeners();
  }
  Future<void> updateTask(TaskItem task)async {
    task.toggleDone();
    await DbHelper.update(task);
    notifyListeners();
  }
  Future<void> deleteTask(TaskItem task) async{
    _tasks.remove(task);
     await DbHelper.delete(task);

    notifyListeners();

  }
}
