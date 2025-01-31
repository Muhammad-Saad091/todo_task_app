import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class home_provider with ChangeNotifier {
  List<String> _tasks = [];
  List<String> _completedTasks = [];
  bool _isLoaded = false;
  TextEditingController changeTask = TextEditingController();

  List<String> get tasks => _tasks;

  List<String> get completedTasks => _completedTasks;

  bool get isLoaded => _isLoaded;

  home_provider() {
    loadData();
  }

  Future<void> loadData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      // Handle tasks loading
      final tasksData = prefs.getString('tasks') ?? '[]';
      _tasks = (jsonDecode(tasksData) as List<dynamic>)
          .map((e) => e.toString())
          .toList();
      // Handle completed tasks loading
      final completedData = prefs.getString('completedTasks') ?? '[]';
      _completedTasks = (jsonDecode(completedData) as List<dynamic>)
          .map((e) => e.toString())
          .toList();
    } catch (e) {
      _tasks = [];
      _completedTasks = [];
    } finally {
      _isLoaded = true;
      notifyListeners();
    }
  }

  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('tasks', jsonEncode(_tasks));
    prefs.setString('completedTasks', jsonEncode(_completedTasks));
  }

  void addTask(String task) {
    _tasks.add(task);
    notifyListeners();
    saveData();
  }

  void moveTask(int index, bool fromCompleted) {
    if (fromCompleted) {
      String task = _completedTasks.removeAt(index);
      _tasks.add(task);
    } else {
      String task = _tasks.removeAt(index);
      _completedTasks.add(task);
    }
    notifyListeners();
    saveData();
  }

  void deleteTask(int index, bool fromCompleted) {
    if (fromCompleted) {
      _completedTasks.removeAt(index);
    } else {
      _tasks.removeAt(index);
    }
    notifyListeners();
    saveData();
  }

  void editTask(int index, bool fromCompleted, String newTask) {
    if (fromCompleted) {
      _completedTasks[index] = newTask;
    } else {
      _tasks[index] = newTask;
    }
    notifyListeners();
    saveData();
  }
}
