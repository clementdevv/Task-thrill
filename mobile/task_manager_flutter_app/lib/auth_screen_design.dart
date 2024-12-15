import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:task_manager_flutter_app/content_controller.dart';
import 'package:task_manager_flutter_app/universal_colors.dart';

class AuthScreenDesign extends StatelessWidget {
  const AuthScreenDesign({
    super.key,
    required this.bodyWidget,
  });

  final Widget bodyWidget;
  @override
  Widget build(BuildContext context) {
    final contentController = Get.find<ContentController>();

    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                UniversalColors.brightViolet,
                UniversalColors.darkViolet.withOpacity(0.12)
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Align(
            alignment: Alignment.center,
            child: AnimatedBuilder(
              animation: contentController.animationController,
              builder: (context, child) {
                return Transform.translate(
                  offset: Offset(
                    contentController.animation.value *
                        MediaQuery.of(context).size.width,
                    0,
                  ),
                  child: child,
                );
              },
              child: Padding(
                padding: const EdgeInsets.all(23),
                child: bodyWidget,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
