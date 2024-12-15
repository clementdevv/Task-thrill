import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:task_manager_flutter_app/content_controller.dart';
import 'package:task_manager_flutter_app/login_screen.dart';
import 'package:task_manager_flutter_app/routes.dart';

void main() {
  Get.put(ContentController()); // Register the controller

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/login_screen',
      title: 'Task Thrill',
      home: const LoginScreen(),
      getPages: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
