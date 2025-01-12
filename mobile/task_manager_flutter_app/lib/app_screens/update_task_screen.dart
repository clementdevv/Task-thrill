import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_flutter_app/state_controllers/task_controller.dart';

class UpdateTaskScreen extends StatelessWidget {
  final TaskController taskController = Get.find<TaskController>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final String status;

  UpdateTaskScreen({Key? key})
      : status = Get.arguments['status'], // Retrieve status from arguments
        super(key: key) {
    // Prepopulate fields with task data
    titleController.text = Get.arguments['title'] ?? '';
    descriptionController.text = Get.arguments['description'] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Task'),
      ),
      // body: Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     children: [
      //       TextField(
      //         controller: titleController,
      //         decoration: InputDecoration(labelText: 'Title'),
      //       ),
      //       TextField(
      //         controller: descriptionController,
      //         decoration: InputDecoration(labelText: 'Description'),
      //       ),
      //       DropdownButtonFormField<String>(
      //         value: status, // This should be 'Pending' or 'Completed' or null
      //         items: ['Pending', 'Completed']
      //             .map((statusOption) => DropdownMenuItem<String>(
      //                   value: statusOption, // Use a unique value
      //                   child: Text(statusOption),
      //                 ))
      //             .toList(),
      //         onChanged: (value) {
      //           // Update the status variable here
      //           if (value != null) {
      //             // You may use a controller or variable to track this change
      //             // Example: setState(() { status = value; });
      //           }
      //         },
      //       ),
      //       SizedBox(height: 20),
      //       ElevatedButton(
      //         onPressed: () async {
      //           final updatedTask = {
      //             'id': Get.arguments['id'],
      //             'title': titleController.text,
      //             'description': descriptionController.text,
      //             'status': status,
      //           };

      //           // Call updateTask from your controller
      //           final isUpdated = await taskController.updateTask(updatedTask);

      //           if (isUpdated) {
      //             Get.snackbar(
      //               'Success',
      //               'Task updated successfully',
      //               snackPosition: SnackPosition.BOTTOM,
      //               backgroundColor: Colors.green,
      //               colorText: Colors.white,
      //             );
      //             Get.back(); // Navigate back to the previous screen
      //           } else {
      //             Get.snackbar(
      //               'Error',
      //               'Failed to update task',
      //               snackPosition: SnackPosition.BOTTOM,
      //               backgroundColor: Colors.red,
      //               colorText: Colors.white,
      //             );
      //           }
      //         },
      //         child: Text('Update Task'),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
