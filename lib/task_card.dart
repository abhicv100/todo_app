import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/task_list_page.dart';

class TaskCard extends StatefulWidget {
  final int id;
  final Task task;
  final void Function(int, String, bool) updateCompletionStatus;
  final void Function(int, String) deleteTask;

  const TaskCard(
      {super.key,
      required this.id,
      required this.task,
      required this.updateCompletionStatus,
      required this.deleteTask});

  @override
  State<StatefulWidget> createState() => _TaskCard();
}

class _TaskCard extends State<TaskCard> {

  String formatedDate(DateTime date) {
    return '${date.day} ${date.month}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: Colors.black12, borderRadius: BorderRadius.circular(8.0)),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Row(
                children: [
                  Checkbox(
                    value: widget.task.isCompleted,
                    onChanged: (value) =>
                        {widget.updateCompletionStatus(widget.id, widget.task.objectId, value!)},
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0)),
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.task.title,
                          softWrap: true,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87,
                              decoration: widget.task.isCompleted
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          DateFormat.yMMMd().format(widget.task.dueDate),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
              IconButton(onPressed: () {
                  widget.deleteTask(widget.id, widget.task.objectId);
                }, icon: const Icon(Icons.delete))
              ],
            )
          ],
        ));
  }
}
