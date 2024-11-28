import 'package:flutter/material.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk_flutter.dart';
import 'package:todo_app/task_card.dart';
import 'package:todo_app/task_entry_page.dart';

class TaskViewPage extends StatefulWidget {
  const TaskViewPage({super.key});

  @override
  State<StatefulWidget> createState() => _TaskViewPage();
}

class Task {
  String objectId = 'id';
  final String title;
  final DateTime dueDate;
  bool isCompleted;
  Task(this.title, this.dueDate, this.isCompleted);
}

class _TaskViewPage extends State<TaskViewPage> {
  final tasks = [];

  @override
  void initState() {
    super.initState();
    getAllTasks();
  }

  void getAllTasks() {
    ParseObject('task').getAll().then((response) {
      if (response.results != null) {
        var parseObjects = response.results as List<ParseObject>;
        for (var parseObject in parseObjects) {
          var title = parseObject.get<String>('title')!;
          var dueDate = parseObject.get<DateTime>('dueDate')!;
          var isCompleted = parseObject.get<bool>('isCompleted')!;
          var task = Task(title, dueDate, isCompleted);
          task.objectId = parseObject.objectId!;
          setState(() {
            tasks.add(task);
          });
        }
      }
    });
  }

  void updateCompletionStatus(
      int index, String objectId, bool isCompleted) async {
    final taskParseObject = ParseObject('task')
      ..objectId = objectId
      ..set("isCompleted", isCompleted);

    await taskParseObject.save();

    setState(() {
      tasks[index].isCompleted = isCompleted;
    });
  }

  void deleteTask(int index, String objectId) async {
    final taskParseObject = ParseObject('task')..objectId = objectId;

    await taskParseObject.delete();

    setState(() {
      tasks.removeAt(index);
    });
  }

  void addTask(Task task) async {

    var currentUser = await ParseUser.currentUser();

    final taskParseObject = ParseObject('task')
      ..setACL(ParseACL(owner: currentUser))
      ..set('title', task.title)
      ..set('isCompleted', task.isCompleted)
      ..set('dueDate', task.dueDate);

    await taskParseObject.save();

    task.objectId = taskParseObject.objectId!;
    setState(() {
      tasks.add(task);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Task? task = await Navigator.push(context,
              MaterialPageRoute(builder: (context) => const TaskEntryPage()));
          if (task != null) {
            addTask(task);
          }
        },
        backgroundColor: Colors.amberAccent,
        child: const Icon(
          Icons.add,
          color: Colors.black87,
          size: 35,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: Column(
            children: [
              const Center(
                  child: Text(
                'Tasks',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                child: ListView.separated(
                    itemBuilder: (context, index) => TaskCard(
                        id: index,
                        task: tasks[index],
                        updateCompletionStatus: updateCompletionStatus,
                        deleteTask: deleteTask),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 8.0),
                    itemCount: tasks.length),
              )
            ],
          ),
        ),
      ),
    );
  }
}
