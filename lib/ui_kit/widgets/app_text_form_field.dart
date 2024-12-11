import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pp692/ui_kit/colors.dart';
import 'package:pp692/ui_kit/text_styles.dart';

class AppTextFormField extends StatelessWidget {
  const AppTextFormField({
    super.key,
    required this.hint,
    this.initialValue,
    required this.onChanged,
    this.formatters,
    this.keyboardType,
  });

  final String hint;
  final String? initialValue;
  final void Function(String) onChanged;
  final List<TextInputFormatter>? formatters;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      style: AppStyles.bodyMedium,
      cursorHeight: 20,
      cursorWidth: 1,
      onChanged: onChanged,
      keyboardType: keyboardType,
      inputFormatters: formatters,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(12),
        hintStyle: AppStyles.bodyMedium
            .apply(color: AppColors.onSurface.withOpacity(.5)),
        hintText: hint,
        isDense: true,
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.outline),
        ),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.outline),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.outline),
        ),
      ),
    );
  }
}
