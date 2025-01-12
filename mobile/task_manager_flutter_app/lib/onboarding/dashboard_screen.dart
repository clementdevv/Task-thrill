import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_flutter_app/spaces.dart';
import 'package:task_manager_flutter_app/state_controllers/task_controller.dart';

class DashboardScreen extends StatelessWidget {
  final TaskController taskController = Get.put(TaskController());

  DashboardScreen({super.key}) {
    taskController.fetchTasks(); // Fetch tasks when screen loads
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Tasks'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              taskController.fetchTasks(); // Manually refresh tasks
            },
          ),
        ],
      ),
      body: Obx(() {
        if (taskController.tasks.isEmpty) {
          return const Center(
            child: Text('No tasks found.'),
          );
        }
        return ListView.builder(
          itemCount: taskController.tasks.length,
          itemBuilder: (context, index) {
            final task = taskController.tasks[index];
            return Card(
                child: GestureDetector(
              onTap: () {
                // Navigate to task details or edit screen
                Get.toNamed('/update_task_screen', arguments: task);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(task['title'] ?? 'Untitled Task'),
                        Text(task['description'] ?? 'No description'),
                      ],
                    ),
                    Row(
                      children: [
                        Text(task['status'] ?? 'Unknown'),
                        smallHorizontalSizedBox,
                        InkWell(
  child: Icon(Icons.delete),
  onTap: () {
    // Show the custom AlertDialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Task'),
          content: Text('Are you sure you want to delete this task?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: Text('Confirm'),
              onPressed: () async {
                final taskId = task['id']; // Retrieve the task ID
                Navigator.of(context).pop(); // Close the dialog
                final isDeleted = await taskController.deleteTask(taskId);
                if (isDeleted) {
                  Get.snackbar(
                    'Success',
                    'Task deleted successfully',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.green,
                    colorText: Colors.white,
                  );
                } else {
                  Get.snackbar(
                    'Error',
                    'Failed to delete task',
                    snackPosition: SnackPosition.BOTTOM,
                    backgroundColor: Colors.red,
                    colorText: Colors.white,
                  );
                }
              },
            ),
          ],
        );
      },
    );
  },
),

                      ],
                    ),
                  ],
                ),
              ),
            ));
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/task_creation_screen'); // Navigate to add task screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
