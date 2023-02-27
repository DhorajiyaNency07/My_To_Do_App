import 'package:flutter/material.dart';
import 'package:model_lerning_new_project/function_screen.dart';
import 'package:provider/provider.dart';

class TasksScreen extends StatelessWidget {
  final taskNameController = TextEditingController();

  TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskData = Provider.of<TaskData>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('To Do App'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: taskNameController,
              decoration: const InputDecoration(
                hintText: 'Enter your task',
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              final taskName = taskNameController.text;
              if (taskName.isNotEmpty) {
                taskData.addTask(taskName);
                taskNameController.clear();
              }
            },
            child: const Text('Add Task'),
          ),

          Expanded(
            child: ListView.builder(
              itemCount: taskData.tasks.length,
              itemBuilder: (context, index) {
                final task = taskData.tasks[index];
                return ListTile(
                  title: Text(task.name),
                  trailing: IconButton(
                      onPressed: () => taskData.deleteTask(index),
                      icon: const Icon(Icons.delete,color: Colors.red,)),
                  leading: Checkbox(
                    value: task.isCompleted,
                    checkColor: Colors.black,
                    onChanged: (value) => taskData.completeTask(index),
                  ),
                  onTap: () => _editTask(context, taskData, index, task.name),
                  // onLongPress: () => taskData.deleteTask(index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

void _editTask(
    BuildContext context, TaskData taskData, int index, String oldName) {
  final newNameController = TextEditingController(text: oldName);

  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text('Edit Task'),
        content: TextField(
          controller: newNameController,
          decoration: const InputDecoration(hintText: 'Enter new task name'),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Cancel'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          TextButton(
            child: const Text('Save'),
            onPressed: () {
              final newName = newNameController.text;
              if (newName.isNotEmpty) {
                taskData.editTask(index, newName);
                Navigator.of(context).pop();
              }
            },
          ),
        ],
      );
    },
  );
}
}
