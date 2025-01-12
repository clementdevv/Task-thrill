import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class SignUpController extends GetxController {  
  final String baseUrl = 'http://127.0.0.1:8000'; 

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailAddressController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // final TextEditingController confirmPasswordController = TextEditingController();
  // final TextEditingController confirmPasswordSetController = TextEditingController();

  Future<void> signup({
    required String email,
    required String password,
    required String firstName, 
    required String lastName, 
    required String phoneNumber,     
    required String username,
  }) async {
    try {
      // Replace with your actual API endpoint      
      final response = await http.post(
        Uri.parse('$baseUrl/signup/'),
        body: {
          'username': usernameController.text,
          'first_name': firstNameController.text,
          'last_name': lastNameController.text,
          'phone_number': phoneNumberController.text,
          'email': emailAddressController.text,
          'password': passwordController.text,
        },
      );


      if (response.statusCode == 200 || response.statusCode == 201) {
      final decodedResponse = jsonDecode(response.body);
        // Perform further checks if necessary
      Get.snackbar('Success', 'Signup successful');
        return decodedResponse;
      } else {        
        // Handle HTTP errors
        Get.snackbar('Error', 'Sign up unsuccessful');
        print("Status Code: ${response.statusCode}");
        print('Response Body: ${response.body}');

      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to signup: $e');
      

    }
  }

  
}
