// import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController  = TextEditingController();
  final firstNameController = TextEditingController();
  final secondNameController = TextEditingController();

  final username = ''.obs;
  final password = ''.obs;
  final isLoading = false.obs;
  final errorMessage = ''.obs;

  Future<void> signUp() async {
    isLoading.value = true;
    errorMessage.value = '';

    try {
      await Future.delayed(Duration(seconds: 2));
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> login() async {
    isLoading.value = true; 
    errorMessage.value = ''; 

    try {
            await Future.delayed(Duration(seconds: 2));
      Get.offNamed('/');

    } catch (e) {
      errorMessage.value =  e.toString();
    } finally {
      isLoading.value = false; 
    }
  }
}
