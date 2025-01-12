import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:task_manager_flutter_app/state_controllers/sign_up_controller.dart';
import 'package:task_manager_flutter_app/onboarding/auth_screen_design.dart';
import 'package:task_manager_flutter_app/text_theme.dart';
import 'package:task_manager_flutter_app/universal_button.dart';
import 'package:task_manager_flutter_app/universal_colors.dart';
import 'package:task_manager_flutter_app/spaces.dart';
import 'package:task_manager_flutter_app/universal_textfield.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final SignUpController signUpController = Get.find<SignUpController>();
    return Scaffold(
      backgroundColor: UniversalColors.black,
      body: AuthScreenDesign(
        bodyWidget: Column(
          children: [
            Text('Sign up to Task Thrill',
                style: boldSize20Text(
                  UniversalColors.white,
                )),
            largeVerticalSizedBox,
            UniversalTextfield(
              controller: signUpController.usernameController,
              labelText: 'Please enter your username',
              obscureText: false,
            ),
            smallVerticalSizedBox,
            UniversalTextfield(
              controller: signUpController.firstNameController,
              labelText: 'Please enter your first name',
              obscureText: false,
            ),
            smallVerticalSizedBox,
            UniversalTextfield(
              controller: signUpController.lastNameController,
              labelText: 'Please enter your second name',
              obscureText: false,
            ),
            smallVerticalSizedBox,
            UniversalTextfield(
              controller: signUpController.emailAddressController,
              labelText: 'Please enter your email address',
              obscureText: false,
            ),
            smallVerticalSizedBox,
            UniversalTextfield(
              controller: signUpController.phoneNumberController,
              labelText: 'Please enter your phone number',
              obscureText: false,

            ),
            smallVerticalSizedBox,
            UniversalTextfield(
              controller: signUpController.passwordController,
              labelText: 'Please enter your password',
              obscureText: false,
            ),           
            mediumVerticalSizedBox,
            UniversalButton(
              buttonText: 'Sign Up',
              onPressed: () {
                signUpController.signup(
                  email: signUpController.emailAddressController.text,
                  password: signUpController.passwordController.text,
                  firstName: signUpController.firstNameController.text,
                  lastName: signUpController.lastNameController.text,
                  phoneNumber: signUpController.phoneNumberController.text,
                  username: signUpController.usernameController.text,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
