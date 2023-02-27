import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'model/task_model.dart';


class TaskData extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  Future<void> loadTasksFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final taskJsonList = prefs.getStringList('tasks') ?? [];

    _tasks = taskJsonList.map((jsonString) {
      final taskJson = jsonDecode(jsonString);
      return Task.fromJson(taskJson);
    }).toList();

    notifyListeners();
  }

  Future<void> saveTasksToPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final taskJsonList = _tasks.map((task) => jsonEncode(task.toJson())).toList();

    prefs.setStringList('tasks', taskJsonList);
  }

  void addTask(String name) {
    final task = Task(name: name);
    _tasks.add(task);
    saveTasksToPrefs();
    notifyListeners();
  }

  void editTask(int index, String newName) {
    final task = _tasks[index];
    task.name = newName;
    saveTasksToPrefs();
    notifyListeners();
  }

  void completeTask(int index) {
    final task = _tasks[index];
    task.isCompleted = true;
    saveTasksToPrefs();
    notifyListeners();
  }

  void deleteTask(int index) {
    _tasks.removeAt(index);
    saveTasksToPrefs();
    notifyListeners();
  }
}
