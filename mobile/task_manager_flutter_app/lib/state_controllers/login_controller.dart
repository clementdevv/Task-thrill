import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:task_manager_flutter_app/state_controllers/storage_service.dart';

class LoginController extends GetxController {
  final StorageService _storageService = StorageService();

  final String baseUrl = 'http://127.0.0.1:8000';

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    try {
      // Prepare the login request payload
      final response = await http.post(
        Uri.parse('$baseUrl/login/'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': emailController.text.trim(),
          'password': passwordController.text.trim(),
        }),
      );

      if (response.statusCode == 200) {
        // Parse the response body
        final decodedResponse = jsonDecode(response.body);

        // Extract the tokens
        final accessToken = decodedResponse['tokens']['access'];
        final refreshToken = decodedResponse['tokens']['refresh'];

        // Save tokens to secure storage
        await _storageService.saveToken(accessToken);
        await _storageService.saveRefreshToken(refreshToken);

        // Feedback to the user
        Get.snackbar('Success', 'Login successful');
        print('Access Token: $accessToken');
        print('Refresh Token: $refreshToken');

        // Navigate to the dashboard screen
        Get.toNamed('/dashboard_screen');
      } else {
        // Handle HTTP errors
        final errorResponse = jsonDecode(response.body);
        Get.snackbar('Error', errorResponse['detail'] ?? 'Login unsuccessful');
        print("Status Code: ${response.statusCode}");
        print('Response Body: ${response.body}');
      }
    } catch (e) {
      // Handle any exceptions
      Get.snackbar('Error', 'Failed to login: $e');
      print('Exception: $e');
    }
  }
}
