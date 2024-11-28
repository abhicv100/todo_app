import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/button.dart';
import 'package:todo_app/task_list_page.dart';

class TaskEntryPage extends StatefulWidget {
  const TaskEntryPage({super.key});

  @override
  State<StatefulWidget> createState() => _TaskEntryPage();
}

class _TaskEntryPage extends State<TaskEntryPage> {
  final TextEditingController taskTitleTextController = TextEditingController();

  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          child: Column(
            children: [
              const Center(
                  child: Text(
                'New task',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              )),
              const SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.circular(8.0)),
                child: TextField(
                  textAlign: TextAlign.justify,
                  cursorWidth: 5.0,
                  cursorColor: Colors.black87,
                  controller: taskTitleTextController,
                  decoration: const InputDecoration(
                      border: InputBorder.none,
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      hintText: "Title"),
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  textCapitalization: TextCapitalization.characters,
                  style: const TextStyle(
                      decorationThickness: 0.0,
                      fontSize: 20.0,
                      color: Colors.black87,
                      fontWeight: FontWeight.normal),
                  onChanged: (value) {},
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Due date: ${DateFormat.yMMMd().format(selectedDate)}",
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  PrimaryButton(
                      onPressed: () async {
                        final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            firstDate: selectedDate,
                            lastDate: DateTime(2100));
                        if (pickedDate != null) {
                          setState(() {
                            selectedDate = pickedDate;
                          });
                        }
                      },
                      text: "Select due date")
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Spacer(),
              PrimaryButton(
                onPressed: () {
                  var task =
                      Task(taskTitleTextController.text, selectedDate, false);
                  Navigator.pop(context, task);
                },
                text: "Add",
              ),
              const SizedBox(
                height: 8,
              ),
              PrimaryButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                text: "Close",
              )
            ],
          ),
        ),
      ),
    );
  }
}
