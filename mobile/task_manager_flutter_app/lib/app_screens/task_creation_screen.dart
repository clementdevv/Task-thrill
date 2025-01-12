import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:task_manager_flutter_app/spaces.dart';
import 'package:task_manager_flutter_app/state_controllers/task_controller.dart';

class TaskCreationScreen extends StatelessWidget {
  final TaskController taskController = Get.find<TaskController>();

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController startTimeController = TextEditingController();
  final TextEditingController endTimeController = TextEditingController();

  final RxString priorityLevel = 'Medium'.obs; // Default priority level

  TaskCreationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: startTimeController,
              decoration: InputDecoration(
                  labelText: 'Start Time (YYYY-MM-DD HH:MM:SS)'),
            ),
            TextField(
              controller: endTimeController,
              decoration:
                  InputDecoration(labelText: 'End Time (YYYY-MM-DD HH:MM:SS)'),
            ),
            smallVerticalSizedBox,
            Obx(() => DropdownButtonFormField<String>(
                  value: priorityLevel.value,
                  onChanged: (newValue) {
                    priorityLevel.value = newValue!;
                  },
                  decoration:
                      const InputDecoration(labelText: 'Priority Level'),
                  items: ['Low', 'Medium', 'High']
                      .map((level) => DropdownMenuItem(
                            value: level,
                            child: Text(level),
                          ))
                      .toList(),
                )),
            veryLargeVerticalSizedBox,
            Center(
              child: ElevatedButton(
                onPressed: () {
                  taskController.addTask({
                    'title': titleController.text,
                    'description': descriptionController.text,
                    'start_time': startTimeController.text,
                    'end_time': endTimeController.text,
                    'priority_level': priorityLevel.value,
                    'status': 'Pending',
                  });
                  Get.snackbar('Task', 'Task added successfully');
                },
                child: const Text('Add Task'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
