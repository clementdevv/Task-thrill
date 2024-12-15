


import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:task_manager_flutter_app/login_screen.dart';
import 'package:task_manager_flutter_app/sign_up_screen.dart';

List<GetPage> routes = <GetPage>[
  GetPage(name: '/sign_up_screen', page: SignUpScreen.new),
  GetPage(name: '/login_screen', page: LoginScreen.new),

];