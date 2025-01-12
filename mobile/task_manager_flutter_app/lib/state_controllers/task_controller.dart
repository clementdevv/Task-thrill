import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:task_manager_flutter_app/state_controllers/storage_service.dart';

class TaskController extends GetxController {
  // Task list and other states
  var tasks = [].obs; // List of tasks
  var totalTasks = 0.obs;
  var completedTasks = 0.obs;

  final String baseUrl =
      'http://127.0.0.1:8000'; // Replace with your Django API URL

  // Current sorting option
  var currentSortOption = 'due_date'.obs; // Default sorting option

  // Fetch tasks from backend
  Future<void> fetchTasks() async {
    try {
      final token = await StorageService().getToken(); // Retrieve token
      if (token == null) {
        Get.snackbar('Error', 'No token found, please login first!');
        return;
      }

      final response = await http.get(
        Uri.parse('$baseUrl/tasks/'),
        headers: {
          'Authorization': 'Bearer $token', // Add token to header
          'Content-Type': 'application/json', // Optional: if needed
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        tasks.value = data;
        sortTasks(); // Sort tasks after fetching
        updateTaskCounts();
      } else {
        Get.snackbar('Error', 'Failed to fetch tasks: ${response.statusCode}');
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
    }
  }

  // Add a new task
  Future<void> addTask(Map<String, dynamic> taskData) async {
    try {
      final token = await StorageService().getToken(); // Retrieve the token
      if (token == null) {
        Get.snackbar('Error', 'No token found, please login first!');
        return;
      }

      final response = await http.post(
        Uri.parse('$baseUrl/tasks/create/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode(taskData),
      );

      if (response.statusCode == 201) {
        print("Task created successfully");
        // fetchTasks(); // Fetch the latest tasks after adding one
      } else if (response.statusCode == 401) {
        Get.snackbar('Error', 'Unauthorized: ${response.body}');
      } else {
        Get.snackbar('Error', 'Failed to create task: ${response.body}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Error creating task: $e');
    }
  }

  // Update an existing task
 Future<bool> updateTask(Map<String, dynamic> task) async {
  try {
    final token = await StorageService().getToken(); // Retrieve the token
    if (token == null) {
      Get.snackbar('Error', 'No token found, please login first!');
      return false; // Indicate failure
    }

    final response = await http.put(
      Uri.parse('$baseUrl/tasks/${task['id']}/update/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(task),
    );

    if (response.statusCode == 200) {
      // Task updated successfully
      return true;
    } else {
      Get.snackbar('Error', 'Failed to update task');
      return false; // Indicate failure
    }
  } catch (e) {
    Get.snackbar('Error', 'An error occurred: $e');
    return false; // Indicate failure
  }
}


  // Delete a task
  Future<bool> deleteTask(int id) async {
    try {
      final token = await StorageService().getToken(); // Retrieve the token
      if (token == null) {
        Get.snackbar('Error', 'No token found, please login first!');
        return false;
      }

      final response = await http.delete(
        Uri.parse('$baseUrl/tasks/$id/delete/'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 204) {
        fetchTasks(); // Refresh tasks after delete\
        return true;
      } else {
        Get.snackbar('Error', 'Failed to delete task');
        return false;
      }
    } catch (e) {
      Get.snackbar('Error', 'An error occurred: $e');
      return false;
    }
  }

  // Helper to update task counts
  void updateTaskCounts() {
    totalTasks.value = tasks.length;
    completedTasks.value =
        tasks.where((task) => task['status'] == 'COMPLETED').length;
  }

  // Sort tasks based on the current sorting option
  void sortTasks() {
    if (currentSortOption.value == 'due_date') {
      tasks.sort((a, b) {
        final aDueDate = DateTime.parse(a['end_time']).toLocal();
        final bDueDate = DateTime.parse(b['end_time']).toLocal();
        return aDueDate.compareTo(bDueDate);
      });
    } else if (currentSortOption.value == 'priority_level') {
      const priorityOrder = {'Low': 0, 'Medium': 1, 'High': 2};
      tasks.sort((a, b) {
        final aPriority = priorityOrder[a['priority_level']] ?? 0;
        final bPriority = priorityOrder[b['priority_level']] ?? 0;
        return aPriority.compareTo(bPriority);
      });
    }
  }

  // Set sorting option and re-sort tasks
  void setSortOption(String option) {
    currentSortOption.value = option;
    sortTasks();
  }
}
