import 'package:flutter/material.dart';
import 'package:pp692/ui_kit/colors.dart';
import 'package:pp692/ui_kit/text_styles.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({super.key, required this.delete});

  final void Function() delete;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: AppColors.background,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Delete',
              style: AppStyles.displayMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Delete',
              style: AppStyles.bodyMedium
                  .apply(color: AppColors.surface.withOpacity(.5)),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: Navigator.of(context).pop,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        border: Border.all(width: 2, color: AppColors.surface),
                        color: AppColors.background,
                      ),
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      child: const Center(
                        child: Text(
                          'No',
                          style: AppStyles.displaySmall,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: GestureDetector(
                    onTap: delete,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: AppColors.primary,
                      ),
                      height: 50,
                      padding: const EdgeInsets.all(10),
                      child: const Center(
                        child: Text(
                          'Yes',
                          style: AppStyles.displaySmall,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
