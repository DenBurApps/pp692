import 'package:flutter/material.dart';
import 'package:pp692/ui_kit/colors.dart';
import 'package:pp692/ui_kit/text_styles.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    required this.buttonText,
    required this.onTap,
    this.isActive = true,
  });

  final String buttonText;
  final void Function() onTap;
  final bool isActive;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isActive ? onTap : null,
      behavior: HitTestBehavior.translucent,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(32),
          color: AppColors.primary,
        ),
        height: 56,
        padding: const EdgeInsets.symmetric(vertical: 10),
        width: double.infinity,
        child: Center(
          child: Text(
            buttonText,
            style: AppStyles.bodyLarge,
          ),
        ),
      ),
    );
  }
}
