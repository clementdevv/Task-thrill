import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager_flutter_app/state_controllers/login_controller.dart';
import 'package:task_manager_flutter_app/onboarding/auth_screen_design.dart';
import 'package:task_manager_flutter_app/spaces.dart';
import 'package:task_manager_flutter_app/text_theme.dart';
import 'package:task_manager_flutter_app/universal_button.dart';
import 'package:task_manager_flutter_app/universal_colors.dart';
import 'package:task_manager_flutter_app/universal_textfield.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final LoginController controller = Get.put(LoginController());
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      backgroundColor: UniversalColors.black,
      body: AuthScreenDesign(
        bodyWidget: Form(
          key: formKey,
          child: Column(
            children: [
              Text('Welcome Back!',
                  style: boldSize20Text(
                    UniversalColors.white,
                  )),
              Text(
                'Log in',
                // style: boldSize20Text(
                //   UniversalColors.white,
                // ),
              ),
              largeVerticalSizedBox,
              UniversalTextfield(
                // errorWidget: ,
                controller: controller.emailController,
                obscureText: false,
                labelText: 'Please enter your email address',
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter an email';
                  }
                  final emailRegex = RegExp(
                      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+.[a-zA-Z]{2,}$');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Invalid email format';
                  }
                  return null; // Valid
                },
              ),
              smallVerticalSizedBox,
              UniversalTextfield(
                controller: controller.passwordController,
                obscureText: false,
                labelText: 'Please enter your password',
              ),
              mediumVerticalSizedBox,
              UniversalButton(
                buttonText: 'Login',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // Form is valid, navigate to dashboard
                    final loginController = Get.put(LoginController());
                    loginController.login();
                  }
                },
              ),
              mediumVerticalSizedBox,
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Need an account? ',
                      style: mediumSize13Text(
                        UniversalColors.copperRose.withOpacity(0.75),
                      ),
                    ),
                    TextSpan(
                      text: 'SIGN UP',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // ignore: inference_failure_on_function_invocation
                          Get.toNamed('/sign_up_screen');
                        },
                      style: mediumSize13Text(
                        UniversalColors.chineseSilver,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
