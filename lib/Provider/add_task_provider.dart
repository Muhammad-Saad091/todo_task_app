import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_task_app/Provider/home_provider.dart';

class add_task_provider with ChangeNotifier {
  final TextEditingController _taskController = TextEditingController();
  bool _isSwitched = false;
  bool _isSwitched2 = false;

  TextEditingController get taskController => _taskController;

  bool get isSwitched => _isSwitched;

  bool get isSwitched2 => _isSwitched2;

  void addTask(BuildContext context) {
    final task = _taskController.text.trim();
    if (task.isEmpty) return;

    final homeProvider = Provider.of<home_provider>(context, listen: false);
    homeProvider.addTask(task);
    _taskController.clear();
    Navigator.pop(context);
  }

  void turn_on(bool value) {
    _isSwitched = value;
    notifyListeners();
  }

  void turn_on2(bool value) {
    _isSwitched2 = value;
    notifyListeners();
  }
}
