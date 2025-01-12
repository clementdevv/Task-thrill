import 'package:flutter/material.dart';
import 'package:task_manager_flutter_app/universal_colors.dart';
import 'package:task_manager_flutter_app/text_theme.dart';

class UniversalTextfield extends StatelessWidget {
  const UniversalTextfield({
    super.key,
    required this.controller,
    required this.labelText,
    required this.obscureText,
    this.validator,
    this.errorWidget,
  });

  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final FormFieldValidator<String>? validator;
  final Widget? errorWidget;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      obscureText: obscureText,
      decoration: InputDecoration(
        errorMaxLines: 1,
        errorStyle: TextStyle(
          color: UniversalColors.deepRed,
        ),
        error: errorWidget,
        focusedBorder: OutlineInputBorder(
          gapPadding: 1.5,
          borderRadius: BorderRadius.circular(17),
          borderSide: BorderSide(
            color: UniversalColors.white,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          gapPadding: 1.5,
          borderRadius: BorderRadius.circular(17),
          borderSide: BorderSide(
            color: UniversalColors.darkViolet,
            // style: BorderStyle.solid,
          ),
        ),
        errorBorder: OutlineInputBorder(
          gapPadding: 1.5,
          borderRadius: BorderRadius.circular(17),
          borderSide: BorderSide(
            color: UniversalColors.deepRed,
          ),
        ),
        disabledBorder: OutlineInputBorder(
          gapPadding: 1.5,
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
