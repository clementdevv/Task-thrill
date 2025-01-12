
import 'dart:convert';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_manager_flutter_app/state_controllers/storage_service.dart';

class ApiService {
  String baseUrl = 'http://127.0.0.1:8000';

  Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  Future<void> setToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  // Future<Map<String, dynamic>> login(
  //     String email,
  //     String password,
  //   ) async {
  //     // print(email);
  //     // print(password);
  //     final url = Uri.parse('$baseUrl/login/');
  //     final response = await http.post(
  //       url,
  //       headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({'email': email, 'password': password}),
  //   );
  //   // print(response);
  //   if (response.statusCode == 200) {
  //     final token = jsonDecode(response.body)['token'];
  //     await StorageService().saveToken(token as String);
  //     return jsonDecode(response.body) as Map<String, dynamic>;
  //   } else {
  //     throw Exception('Failed to login: ${response.body}');
  //   }
  // }

  // Future<Map<String, dynamic>> signup({
  //   required String username,
  //   required String email,
  //   required String password,
  //   required String firstName,
  //   required String lastName,
  //   required String phoneNumber,
  // }) async {
  //   try {
  //     final url = Uri.parse('$baseUrl/signup/');

  //     final response = await http.post(
  //       url,
  //       body: {
  //         'username': username,
  //         'first_name':
  //             firstName, // Use passed parameters instead of controllers
  //         'last_name': lastName,
  //         'phone_number': phoneNumber,
  //         'email': email,
  //         'password': password,
  //         // 'passwordCheck': confirmPasswordSetController.text,
  //       },
  //     );
  //     print('Response status: ${response.statusCode}');
  //     print('Response body: ${response.body}');

  //     if (response.statusCode == 200) {
  //       final token = jsonDecode(response.body)[
  //           'token']; // Assuming the token is in the response body
  //       await StorageService().saveToken(token as String);
  //       final decodedResponse =
  //           jsonDecode(response.body) as Map<String, dynamic>;
  //       // Perform further checks if necessary
  //       Get.snackbar('Success', 'Signup successful');
  //       return decodedResponse;
  //     } else {
  //       // Handle HTTP errors
  //       print('Request Body: ${jsonEncode(response.body)}');
  //       Get.snackbar('Error', 'Sign up unsuccessful');
  //       return {};
  //     }
  //   } catch (e) {
  //     Get.snackbar('Error', 'Failed to signup: $e');
  //     return {};
  //   }
  // }

   Future<void> logout() async {
    await StorageService().deleteToken(); // Delete token securely
    // ignore: inference_failure_on_function_invocation
    Get.offAllNamed('/login_screen'); // Navigate to login screen
  }

}