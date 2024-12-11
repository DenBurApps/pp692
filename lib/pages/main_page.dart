import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pp692/bloc/habit_state.dart';
import 'package:pp692/bloc/habits_bloc.dart';
import 'package:pp692/bloc/habits_state.dart';
import 'package:pp692/bloc/note_state.dart';
import 'package:pp692/navigation/routes.dart';
import 'package:pp692/ui_kit/colors.dart';
import 'package:pp692/ui_kit/text_styles.dart';
import 'package:pp692/utils/assets_paths.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
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
                BlocSelector<HabitsBloc, HabitsState, DateTime>(
                  selector: (state) => state.selected,
                  builder: (context, selected) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Good ${switch (selected.hour) {
                          23 || 0 || 1 || 2 || 3 || 4 || 5 => 'night',
                          6 || 7 || 8 || 9 || 10 || 11 => 'morning',
                          12 || 13 || 14 || 15 || 16 => 'afternoon',
                          _ => 'evening',
                        }}!',
                        style: AppStyles.bodyLarge
                            .apply(color: AppColors.onBackground),
                      ),
                      Text(
                        DateFormat('MMMM yyyy').format(selected),
                        style: AppStyles.displayMedium,
                      ),
                    ],
                  ),
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
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Image.asset(AppImages.planet),
                    ),
                  ),
                  const Text(
                    'Focus on the\nimportant\nthings',
                    style: AppStyles.displayLarge,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            const Row(
              children: [
                _HabitsBlock(),
                SizedBox(width: 8),
                _FocusBlock(),
              ],
            ),
            const SizedBox(height: 8),
            const _JournalBlock(),
            SizedBox(height: 75 + MediaQuery.of(context).viewPadding.bottom),
          ],
        ),
      ),
    );
  }
}

class _JournalBlock extends StatelessWidget {
  const _JournalBlock();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
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
            BlocSelector<HabitsBloc, HabitsState, List<NoteState>>(
              selector: (state) => state.notes,
              builder: (context, notes) => notes.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        "Add notes about your day",
                        style: AppStyles.bodyMedium
                            .apply(color: AppColors.onBackground),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(
                        min(3, notes.length),
                        (index) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 12),
                            Text(
                              DateFormat('HH:mm').format(notes[index].date),
                              style: AppStyles.bodyLarge,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              notes[index].description,
                              style: AppStyles.bodyMedium.apply(
                                color: AppColors.onSurface.withOpacity(.5),
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FocusBlock extends StatelessWidget {
  const _FocusBlock();

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
                style:
                    AppStyles.bodyMedium.apply(color: AppColors.onBackground),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HabitsBlock extends StatelessWidget {
  const _HabitsBlock();

  @override
  Widget build(BuildContext context) {
    return Expanded(
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
              BlocSelector<HabitsBloc, HabitsState, List<HabitState>>(
                selector: (state) =>
                    state.habits.where((e) => !e.done).toList(),
                builder: (context, habits) => habits.isEmpty
                    ? Expanded(
                        child: Column(
                          children: [
                            const Spacer(),
                            Text(
                              'Easily track\nyour habits',
                              style: AppStyles.bodyMedium.apply(
                                color: AppColors.onBackground,
                              ),
                            ),
                          ],
                        ),
                      )
                    : Column(
                        children: [
                          const SizedBox(height: 8),
                          ...List.generate(
                            min(5, habits.length),
                            (index) => _HabitTile(habits[index].name),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HabitTile extends StatelessWidget {
  const _HabitTile(this.name);

  final String name;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                color: AppColors.onSurface.withOpacity(.2),
              ),
            ),
            height: 20,
            width: 20,
          ),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              name,
              style: AppStyles.bodyMedium,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
