import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:todo_task_app/Provider/add_task_provider.dart';

class add_task_screen extends StatefulWidget {
  const add_task_screen({super.key});

  @override
  State<add_task_screen> createState() => _add_task_screenState();
}

class _add_task_screenState extends State<add_task_screen> {
  @override
  Widget build(BuildContext context) {
    final addProvider = Provider.of<add_task_provider>(context);
    final mediaQuery = MediaQuery.of(context);

    return Scaffold(
      floatingActionButton: Container(
        height: mediaQuery.size.height * 0.07,
        width: mediaQuery.size.width * 0.33,
        child: FloatingActionButton(
          backgroundColor: Colors.green,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          onPressed: () => addProvider.addTask(context),
          child: Text(
            'Save Task',
            style: TextStyle(color: Colors.white, fontSize: 17.sp),
          ),
        ),
      ),
      body: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          Container(
            height: mediaQuery.size.height * 0.86,
            decoration: const BoxDecoration(color: Colors.green),
          ),
          Container(
            height: mediaQuery.size.height * 0.7,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 8.0, right: 50, left: 20),
                    child: Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.close_outlined,
                              size: 40, color: Colors.grey.withOpacity(0.8)),
                          onPressed: () => Navigator.pop(context),
                        ),
                        const Expanded(
                          child: Center(
                            child: Text(
                              'Add Task',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 25),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(thickness: 2.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 17, horizontal: 22.0),
                    child: TextFormField(
                      controller: addProvider.taskController,
                      decoration: InputDecoration(
                          hintText: 'Task title',
                          hintStyle: TextStyle(
                              color: Colors.grey[600], fontSize: 18.sp),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 15),
                          filled: true,
                          fillColor: Colors.grey[345],
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12)),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(12))),
                    ),
                  ),
                  const Divider(thickness: 1.5, color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SwitchListTile(
                      title: Text('To every day',
                          style:
                              TextStyle(color: Colors.grey, fontSize: 19.sp)),
                      value: addProvider.isSwitched,
                      onChanged: addProvider.turn_on,
                      activeColor: Colors.green,
                      inactiveThumbColor: Colors.green,
                      inactiveTrackColor: Colors.white,
                    ),
                  ),
                  const Divider(thickness: 1.5, color: Colors.grey),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SwitchListTile(
                      title: Text("To today's list only",
                          style:
                              TextStyle(color: Colors.grey, fontSize: 19.sp)),
                      value: addProvider.isSwitched2,
                      onChanged: addProvider.turn_on2,
                      activeColor: Colors.green,
                      inactiveThumbColor: Colors.green,
                      inactiveTrackColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
