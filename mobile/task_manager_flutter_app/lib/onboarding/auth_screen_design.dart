import 'package:flutter/material.dart';
import 'package:task_manager_flutter_app/universal_colors.dart';

class AuthScreenDesign extends StatelessWidget {
  const AuthScreenDesign({
    super.key,
    required this.bodyWidget,
  });

  final Widget bodyWidget;
  @override
  Widget build(BuildContext context) {

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
            child: bodyWidget,
          ),
        ),
      ],
    );
  }
}
