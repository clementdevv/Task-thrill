import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:task_manager_flutter_app/auth_controller.dart';
import 'package:task_manager_flutter_app/auth_screen_design.dart';
import 'package:task_manager_flutter_app/text_theme.dart';
import 'package:task_manager_flutter_app/universal_button.dart';
import 'package:task_manager_flutter_app/universal_colors.dart';
import 'package:task_manager_flutter_app/spaces.dart';
import 'package:task_manager_flutter_app/universal_textfield.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.put(AuthController());
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
              controller: controller.emailController,
              hintText: 'Please enter your username',
              obscureText: false,
              labelText: '',
            ),
            UniversalTextfield(
              controller: controller.passwordController,
              hintText: 'Please enter your first name',
              obscureText: false,
              labelText: '',
            ),
            UniversalTextfield(
              controller: controller.passwordController,
              hintText: 'Please enter your second name',
              obscureText: false,
              labelText: '',
            ),
            UniversalTextfield(
              controller: controller.passwordController,
              hintText: 'Please enter your email address',
              obscureText: false,
              labelText: '',
            ),
            UniversalTextfield(
              controller: controller.passwordController,
              hintText: 'Please enter your password',
              obscureText: false,
              labelText: '',
            ),
            UniversalTextfield(
              controller: controller.passwordController,
              hintText: 'Please confirm your password',
              obscureText: false,
              labelText: '',
            ),
            UniversalButton(
              buttonText: 'Sign Up',
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
