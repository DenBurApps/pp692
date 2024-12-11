import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pp692/bloc/habit_state.dart';
import 'package:pp692/bloc/habits_bloc.dart';
import 'package:pp692/bloc/habits_state.dart';
import 'package:pp692/navigation/routes.dart';
import 'package:pp692/ui_kit/colors.dart';
import 'package:pp692/ui_kit/text_styles.dart';
import 'package:pp692/utils/assets_paths.dart';
import 'package:pp692/utils/constants.dart';

class HabitsPage extends StatelessWidget {
  const HabitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HabitsBloc, HabitsState, List<HabitState>>(
      selector: (state) => state.habits,
      builder: (context, habits) => habits.isEmpty
          ? Center(
              child: BlocSelector<HabitsBloc, HabitsState, DateTime>(
                selector: (state) => state.selected,
                builder: (context, selected) => GestureDetector(
                  onTap: () => Navigator.of(context).pushNamed(
                    AppRoutes.editHabit,
                    arguments: HabitState(date: selected),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      bottom: 75 + MediaQuery.of(context).viewPadding.bottom,
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        SvgPicture.asset(AppImages.polygon),
                        const Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.add_rounded,
                              size: 40,
                              color: AppColors.onSurface,
                            ),
                            Text('Start new', style: AppStyles.displayXL),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  BlocSelector<HabitsBloc, HabitsState, bool?>(
                    selector: (state) => state.filter,
                    builder: (context, filter) => Row(
                      children: [
                        const SizedBox(width: 16),
                        GestureDetector(
                          onTap: () =>
                              context.read<HabitsBloc>().updateFilter(null),
                          child: AnimatedContainer(
                            duration: AppConstants.duration200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: filter == null
                                  ? AppColors.primary
                                  : AppColors.surface,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: const Text(
                              'All habits',
                              style: AppStyles.bodyMedium,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () =>
                              context.read<HabitsBloc>().updateFilter(false),
                          child: AnimatedContainer(
                            duration: AppConstants.duration200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: filter == false
                                  ? AppColors.primary
                                  : AppColors.surface,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: const Text(
                              'In progress',
                              style: AppStyles.bodyMedium,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        GestureDetector(
                          onTap: () =>
                              context.read<HabitsBloc>().updateFilter(true),
                          child: AnimatedContainer(
                            duration: AppConstants.duration200,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: filter == true
                                  ? AppColors.primary
                                  : AppColors.surface,
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            child: const Text(
                              'Done habits',
                              style: AppStyles.bodyMedium,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  BlocSelector<HabitsBloc, HabitsState, bool?>(
                    selector: (state) => state.filter,
                    builder: (context, filter) {
                      final hs = filter == null
                          ? habits
                          : habits.where((e) => e.done == filter).toList();
                      return Column(
                        children: List.generate(
                          hs.length,
                          (index) => _HabitTile(hs[index]),
                        ),
                      );
                    },
                  ),
                  SizedBox(
                    height: 75 + MediaQuery.of(context).viewPadding.bottom,
                  ),
                ],
              ),
            ),
    );
  }
}

class _HabitTile extends StatelessWidget {
  const _HabitTile(this.habit);

  final HabitState habit;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 120 / MediaQuery.sizeOf(context).width,
        motion: const ScrollMotion(),
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context)
                .pushNamed(AppRoutes.editHabit, arguments: habit),
            child: Container(
              color: AppColors.yellow,
              width: 60,
              child: Center(child: SvgPicture.asset(AppIcons.edit)),
            ),
          ),
          GestureDetector(
            onTap: () async =>
                await context.read<HabitsBloc>().deleteHabit(habit.id ?? 0),
            child: Container(
              color: AppColors.red,
              width: 60,
              child: Center(child: SvgPicture.asset(AppIcons.trash)),
            ),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () async => await context
            .read<HabitsBloc>()
            .updateHabit(habit.id ?? 0, habit.copyWith(done: !habit.done)),
        behavior: HitTestBehavior.translucent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AnimatedContainer(
                duration: AppConstants.duration200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(
                    color: habit.done ? AppColors.primary : AppColors.outline,
                  ),
                  color: habit.done ? AppColors.primary : null,
                ),
                height: 24,
                width: 24,
                child: AnimatedOpacity(
                  opacity: habit.done ? 1 : 0,
                  duration: AppConstants.duration200,
                  child: const Icon(Icons.check_rounded, size: 16),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AnimatedDefaultTextStyle(
                      duration: AppConstants.duration200,
                      style: AppStyles.bodyLarge.apply(
                        color: habit.done
                            ? AppColors.onSurface.withOpacity(.2)
                            : null,
                        decoration:
                            habit.done ? TextDecoration.lineThrough : null,
                        decorationColor: habit.done
                            ? AppColors.onSurface.withOpacity(.2)
                            : null,
                      ),
                      child: Text(habit.name),
                    ),
                    if (habit.description.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: AnimatedDefaultTextStyle(
                          duration: AppConstants.duration200,
                          style: AppStyles.bodyMedium.apply(
                            color: habit.done
                                ? AppColors.onSurface.withOpacity(.2)
                                : AppColors.onBackground,
                          ),
                          child: Text(habit.description),
                        ),
                      ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  CircleAvatar(radius: 10, backgroundColor: Color(habit.color)),
                  const SizedBox(height: 4),
                  Text(
                    DateFormat('HH:mm').format(habit.date),
                    style: AppStyles.bodyMedium
                        .apply(color: AppColors.onSurface.withOpacity(.2)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
