import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:task_manager_flutter_app/app_screens/task_creation_screen.dart';
import 'package:task_manager_flutter_app/app_screens/update_task_screen.dart';
import 'package:task_manager_flutter_app/onboarding/dashboard_screen.dart';
import 'package:task_manager_flutter_app/onboarding/login_screen.dart';
import 'package:task_manager_flutter_app/onboarding/sign_up_screen.dart';

List<GetPage> routes = <GetPage>[
  GetPage(name: '/sign_up_screen', page: SignUpScreen.new),
  GetPage(name: '/login_screen', page: LoginScreen.new),
  GetPage(name: '/dashboard_screen', page: DashboardScreen.new),
  GetPage(name: '/task_creation_screen', page: TaskCreationScreen.new),
  GetPage(name: '/update_task_screen', page: UpdateTaskScreen.new),

];