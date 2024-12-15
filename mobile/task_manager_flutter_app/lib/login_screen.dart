import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:task_manager_flutter_app/auth_controller.dart';
import 'package:task_manager_flutter_app/auth_screen_design.dart';
import 'package:task_manager_flutter_app/spaces.dart';
import 'package:task_manager_flutter_app/text_theme.dart';
import 'package:task_manager_flutter_app/universal_button.dart';
import 'package:task_manager_flutter_app/universal_colors.dart';
import 'package:task_manager_flutter_app/universal_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
        final AuthController controller = Get.put(AuthController());

    return Scaffold(
      backgroundColor: UniversalColors.black,
      body: AuthScreenDesign(
        bodyWidget: Column(
          children: [
            Text('Welcome Back!',
                style: boldSize20Text(
                  UniversalColors.white,
                )),
            Text('Log in',
                style: boldSize20Text(
                  UniversalColors.white,
                )),
            largeVerticalSizedBox,
            UniversalTextfield(
              controller: controller.emailController,
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
            UniversalButton(
              buttonText: 'Sign Up',
              onPressed: () {},
            ),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                                    text: 'Need an account? ',
                                    style: mediumSize13Text(
                                      UniversalColors.darkViolet.withOpacity(0.6),
                                    ),
                                  ),
                                  TextSpan(
                                    text: 'SIGN UP',
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        // ignore: inference_failure_on_function_invocation
                                        Get.toNamed('/slider_welcome_screen');
                                      },
                                    style: mediumSize13Text(
                                      UniversalColors.darkViolet,
                                    ),
                                  ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}

