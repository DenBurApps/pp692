import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pp692/bloc/habits_bloc.dart';
import 'package:pp692/navigation/routes.dart';
import 'package:pp692/ui_kit/colors.dart';
import 'package:pp692/ui_kit/text_styles.dart';
import 'package:pp692/utils/assets_paths.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final part = switch (now.hour) {
      23 || 0 || 1 || 2 || 3 || 4 || 5 => 'night',
      6 || 7 || 8 || 9 || 10 || 11 => 'morning',
      12 || 13 || 14 || 15 || 16 => 'afternoon',
      _ => 'evening',
    };
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            SizedBox(
              height: 20 +
                  MediaQuery.of(context).viewInsets.top +
                  MediaQuery.of(context).viewPadding.top,
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Good $part!',
                      style: AppStyles.bodyLarge
                          .apply(color: AppColors.onBackground),
                    ),
                    Text(
                      DateFormat('MMMM yyyy').format(now),
                      style: AppStyles.displayMedium,
                    ),
                  ],
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushNamed(AppRoutes.settings),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.surface,
                    ),
                    padding: const EdgeInsets.all(12),
                    child: SvgPicture.asset(AppIcons.settings),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFF081935),
                    Color(0xFF0F205D),
                    Color(0xFF152784),
                  ],
                  stops: [0, .52, .91],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(12, 16, 10, 0),
              child: Stack(
                children: [
                  const Text(
                    'Focus on the\nimportant\nthings',
                    style: AppStyles.displayLarge,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Image.asset(AppImages.planet),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => context.read<HabitsBloc>().updatePage(1),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF1E1EAC),
                            Color(0xFF122769),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                      height: 220,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Text('Habits', style: AppStyles.displaySmall),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                                color: AppColors.onSurface,
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            'Easily track\nyour habits',
                            style: AppStyles.bodyMedium
                                .apply(color: AppColors.onBackground),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: GestureDetector(
                    onTap: () => context.read<HabitsBloc>().updatePage(2),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF07152C),
                            Color(0xFF0E2A58),
                          ],
                          stops: [0, .91],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      height: 220,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 16,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Row(
                            children: [
                              Text('Focusing', style: AppStyles.displaySmall),
                              Spacer(),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                                color: AppColors.onSurface,
                              ),
                            ],
                          ),
                          const Spacer(),
                          Text(
                            "Focus on what's important",
                            style: AppStyles.bodyMedium
                                .apply(color: AppColors.onBackground),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () => context.read<HabitsBloc>().updatePage(3),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF1C5DC7),
                      Color(0xFF13329F),
                      Color(0xFF152884),
                    ],
                    stops: [0, .515, .91],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 16,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text('Journal', style: AppStyles.displaySmall),
                        Spacer(),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 20,
                          color: AppColors.onSurface,
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Add notes about your day",
                      style: AppStyles.bodyMedium
                          .apply(color: AppColors.onBackground),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 75 + MediaQuery.of(context).viewPadding.bottom),
          ],
        ),
      ),
    );
  }
}
