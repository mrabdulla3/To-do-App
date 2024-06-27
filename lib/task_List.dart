import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:shared_preferences/shared_preferences.dart';

class task_List extends StatefulWidget {
  final String activityName;
  final Function(int) updateTaskCount;
  task_List({required this.activityName,required this.updateTaskCount});
  @override
  State<StatefulWidget> createState() => _Mytask_ListState();
}

class _Mytask_ListState extends State<task_List> {
  late String _activityKey;
  @override
  final TextEditingController inputController = TextEditingController();
  List<Task> arrTask = [];

  bool showButtons = false;
  //DateTime time=DateTime.now();

  get completed => null;

  int getTaskCount(){
    return arrTask.length;

  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _activityKey = 'tasks_${widget.activityName}';
    _loadTasks();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Task',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                  color: Colors.blue.shade400,
                  fontFamily: 'Poppins-Medium')),
        ),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    width: 250,
                    height: 50,
                    child: TextField(
                      controller: inputController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Your Task'),
                    )),
                Container(
                    height: 50,
                    width: 90,
                    child: ElevatedButton(
                        onPressed: () {
                          setState(() {
                            var taskName = inputController.text.toString();
                            arrTask.add(
                                Task(taskName: taskName, completed: false));
                            _saveTasks();
                            inputController.clear();
                          });
                        },
                        child: Text(
                          'Add',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        )))
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Checkbox(
                      value: arrTask[index].completed,
                      onChanged: (bool? value) {
                        setState(() {
                          arrTask[index].completed = value ?? false;
                          _saveTasks();
                        });
                      },
                    ),
                    title: Text(arrTask[index].taskName),
                    //subtitle:Text('$time'),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) {
                        return [
                          PopupMenuItem(
                              child: TextButton(
                            onPressed: () {
                              setState(() {
                                arrTask.removeAt(index);
                                _saveTasks();
                              });
                            },
                            child: Text('Delete'),
                          )),
                          PopupMenuItem(
                              child: TextButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Text('Edit Text'),
                                    content: TextField(
                                      controller: TextEditingController(
                                        text: arrTask[index].taskName,
                                      ),
                                      onChanged: (value) {
                                        setState(() {
                                          arrTask[index].taskName = value;
                                          _saveTasks();
                                        });
                                      },
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Cancel'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text('Save'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Text('Edit'),
                          ))
                        ];
                      },
                    ),
                  );
                },
                itemCount: arrTask.length,
                itemExtent: null,
              ),
            )
          ],
        ));
  }

  void _saveTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> taskList = arrTask.map((task) => task.taskName).toList();
    await prefs.setStringList(_activityKey, taskList);
    List<String> taskCompletedList =
        arrTask.map((task) => task.completed.toString()).toList();
    await prefs.setStringList('${_activityKey}_completed', taskCompletedList);

    widget.updateTaskCount(arrTask.length);
  }

  void _loadTasks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? taskList = prefs.getStringList(_activityKey);
    List<String>? taskCompletedList =
        prefs.getStringList('${_activityKey}_completed');
    if (taskList != null && taskCompletedList != null) {
      setState(() {
        arrTask = List<Task>.generate(
            taskList.length,
            (index) => Task(
                  taskName: taskList[index],
                  completed: taskCompletedList[index] == 'true',
                ));
      });
    }
  }
}

class Task {
  String taskName;
  bool completed;

  Task({required this.taskName, required this.completed});
}
