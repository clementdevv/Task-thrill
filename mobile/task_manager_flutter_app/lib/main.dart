import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:task_manager_flutter_app/onboarding/login_screen.dart';
import 'package:task_manager_flutter_app/routes.dart';
import 'package:task_manager_flutter_app/state_controllers/login_controller.dart';
import 'package:task_manager_flutter_app/state_controllers/sign_up_controller.dart';
import 'package:task_manager_flutter_app/state_controllers/task_controller.dart';
import 'package:task_manager_flutter_app/state_controllers/storage_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(SignUpController()); 
  Get.put(TaskController());
  Get.put(LoginController());

  runApp(const App());
}


class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: StorageService().getToken(), // Get token from secure storage
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Check if token exists
        if (snapshot.hasData && snapshot.data != null) {
          // Token exists, proceed to the home screen
          return GetMaterialApp(
            initialRoute: '/login_screen',
            getPages: routes,
            title: 'Task Thrill',
            home: const LoginScreen(),
            debugShowCheckedModeBanner: false,
          );
        } else {
          // Token does not exist, go to login screen
          return GetMaterialApp(
            initialRoute: '/login_screen',
            getPages: routes,
            title: 'Task Thrill',
            home: const LoginScreen(),
            debugShowCheckedModeBanner: false,
          );
        }
      },
    );
  }
}
