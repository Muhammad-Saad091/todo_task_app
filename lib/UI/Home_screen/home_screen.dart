import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_task_app/Provider/home_provider.dart';
import 'package:todo_task_app/UI/Add_task_screen/add_task_screen.dart';

class home_screen extends StatefulWidget {
  const home_screen({super.key});

  @override
  State<home_screen> createState() => _home_screenState();
}

class _home_screenState extends State<home_screen> {
  @override
  Widget build(BuildContext context) {
    final homeProvider = Provider.of<home_provider>(context, listen: true);
    final mediaQuery = MediaQuery.of(context);

    if (!homeProvider.isLoaded) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    Widget _listItem(String task, int index, bool isCompleted) {
      return Slidable(
        key: Key(task),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                homeProvider.deleteTask(index, isCompleted);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("$task deleted"),
                    backgroundColor: Colors.red,
                  ),
                );
              },
              backgroundColor: Colors.red.withOpacity(0.7),
              foregroundColor: Colors.red,
              icon: Icons.delete_outline_rounded,
            ),
            SlidableAction(
              onPressed: (context) {
                homeProvider.changeTask.text = task;
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      backgroundColor: Colors.grey,
                      content: Container(
                        height: mediaQuery.size.height * 0.17,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextFormField(
                              controller: homeProvider.changeTask,
                              decoration: InputDecoration(
                                hintText: task,
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                MaterialButton(
                                  color: Colors.green,
                                  child: Text('Save'),
                                  onPressed: () {
                                    final newTask =
                                        homeProvider.changeTask.text.trim();
                                    if (newTask.isNotEmpty) {
                                      homeProvider.editTask(
                                          index, isCompleted, newTask);
                                      Navigator.pop(context);
                                    }
                                  },
                                ),
                                SizedBox(width: 8),
                                MaterialButton(
                                  color: Colors.green,
                                  child: Text('Cancel'),
                                  onPressed: () => Navigator.pop(context),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              backgroundColor: Colors.green.withOpacity(0.7),
              foregroundColor: Colors.green,
              icon: Icons.done_outline_outlined,
            ),
          ],
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5),
          height: mediaQuery.size.height * 0.075,
          decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.25),
            borderRadius: BorderRadius.circular(14),
          ),
          child: ListTile(
            title: isCompleted
                ? Text(task,
                    style: const TextStyle(
                        fontSize: 18, decoration: TextDecoration.lineThrough))
                : Text(task, style: TextStyle(fontSize: 18)),
            leading: Radio<bool>(
              value: true,
              groupValue: isCompleted,
              onChanged: (bool? value) {
                homeProvider.moveTask(index, isCompleted);
              },
              activeColor: Colors.green,
            ),
            trailing: const Icon(Icons.more_vert),
          ),
        ),
      );
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const add_task_screen()),
        ),
        backgroundColor: Colors.green,
        child: const Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Today",
          style: TextStyle(
            color: Colors.green,
            fontWeight: FontWeight.bold,
            fontSize: 40,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const Text("Tasks",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            SlidableAutoCloseBehavior(
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: homeProvider.tasks.length,
                itemBuilder: (context, index) =>
                    _listItem(homeProvider.tasks[index], index, false),
              ),
            ),
            SizedBox(height: mediaQuery.size.height * 0.08),
            const Text("Completed",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: homeProvider.completedTasks.length,
              itemBuilder: (context, index) =>
                  _listItem(homeProvider.completedTasks[index], index, true),
            ),
          ],
        ),
      ),
    );
  }
}
