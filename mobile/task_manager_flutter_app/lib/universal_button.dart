import 'package:flutter/material.dart';
import 'package:task_manager_flutter_app/text_theme.dart';
import 'package:task_manager_flutter_app/universal_colors.dart';

class UniversalButton extends StatelessWidget {
  const UniversalButton(
      {super.key, required this.buttonText, required this.onPressed});
  final String buttonText;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        disabledBackgroundColor: UniversalColors.darkViolet.withOpacity(0.12),        
        backgroundColor: UniversalColors.darkViolet,
        padding: const EdgeInsets.symmetric(
          vertical: 15,
          horizontal: 25,
        ),
      ),
      child: Text(
        buttonText,
        style: mediumSize18Text(
          UniversalColors.white,
        ),
      ),
    );
  }
}
