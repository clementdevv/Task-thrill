import 'package:flutter/material.dart';
import 'package:task_manager_flutter_app/universal_colors.dart';
import 'package:task_manager_flutter_app/text_theme.dart';

class UniversalTextfield extends StatelessWidget {
  const UniversalTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.labelText,
    required this.obscureText,
  });

  final TextEditingController controller;
  final String hintText;
  final String labelText;
  final bool obscureText;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: BorderSide(
            color: UniversalColors.darkViolet,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(17),
          borderSide: BorderSide(
            color: UniversalColors.copperRose,
          ),
        ),
        labelText: labelText,
        labelStyle: mediumSize13Text(
          UniversalColors.azureMist,
        ),
      ),
    );
  }
}
