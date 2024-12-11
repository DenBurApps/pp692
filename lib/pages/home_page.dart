import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pp692/bloc/habit_state.dart';
import 'package:pp692/bloc/habits_bloc.dart';
import 'package:pp692/bloc/habits_state.dart';
import 'package:pp692/bloc/note_state.dart';
import 'package:pp692/navigation/routes.dart';
import 'package:pp692/pages/focus_page.dart';
import 'package:pp692/pages/habits_page.dart';
import 'package:pp692/pages/journal_page.dart';
import 'package:pp692/pages/main_page.dart';
import 'package:pp692/ui_kit/colors.dart';
import 'package:pp692/ui_kit/text_styles.dart';
import 'package:pp692/utils/constants.dart';
import 'package:scroll_snap_list/scroll_snap_list.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final now = DateUtils.dateOnly(DateTime.now());
    final start = now.subtract(const Duration(days: 364));
    final end = now.add(const Duration(days: 365));
    return BlocSelector<HabitsBloc, HabitsState, int>(
      selector: (state) => state.page,
      builder: (context, page) => Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColors.surface,
            ),
            height: 64,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(
                AppConstants.pages.length,
                (index) => GestureDetector(
                  onTap: () => context.read<HabitsBloc>().updatePage(index),
                  behavior: HitTestBehavior.translucent,
                  child: AnimatedOpacity(
                    opacity: index == page ? 1 : .3,
                    duration: AppConstants.duration200,
                    child: Column(
                      children: [
                        const SizedBox(height: 12),
                        SvgPicture.asset(
                          AppConstants.pages[index].$1,
                          colorFilter: const ColorFilter.mode(
                            AppColors.onBackground,
                            BlendMode.srcIn,
                          ),
                        ),
                        const SizedBox(height: 2, width: 64),
                        Text(
                          AppConstants.pages[index].$2,
                          style: AppStyles.bodySmall,
                        ),
                        const SizedBox(height: 12),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        appBar: switch (page) {
          1 || 2 => AppBar(
              backgroundColor: AppColors.background,
              surfaceTintColor: AppColors.background,
              shape: const Border(bottom: BorderSide(color: AppColors.outline)),
              titleSpacing: 0,
              toolbarHeight: 138,
              elevation: 10,
              shadowColor: const Color(0xFF270B4D),
              title: Column(
                children: [
                  const SizedBox(height: 20),
                  BlocSelector<HabitsBloc, HabitsState, DateTime>(
                    selector: (state) => state.selected,
                    builder: (context, selected) => Row(
                      children: [
                        const SizedBox(width: 16),
                        Text(
                          DateFormat('MMMM yyyy').format(selected),
                          style: AppStyles.displayMedium,
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => Navigator.of(context).pushNamed(
                            page == 1
                                ? AppRoutes.editHabit
                                : AppRoutes.editNote,
                            arguments: page == 1
                                ? HabitState(date: selected)
                                : NoteState(date: selected),
                          ),
                          child: const Icon(
                            Icons.add_rounded,
                            color: AppColors.onSurface,
                            size: 28,
                          ),
                        ),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 58,
                    child: BlocSelector<HabitsBloc, HabitsState, DateTime>(
                      selector: (state) => state.selected,
                      builder: (context, selected) => ScrollSnapList(
                        initialIndex:
                            selected.difference(start).inDays.toDouble(),
                        selectedItemAnchor: SelectedItemAnchor.END,
                        itemBuilder: (context, index) {
                          final d = start.add(Duration(days: index));
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Column(
                              children: [
                                Text(
                                  DateFormat('EEE').format(d),
                                  style: AppStyles.bodyMedium
                                      .apply(color: AppColors.onBackground),
                                ),
                                const SizedBox(height: 4),
                                AnimatedContainer(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: d == selected
                                        ? AppColors.primary
                                        : null,
                                  ),
                                  duration: AppConstants.duration200,
                                  width: 34,
                                  height: 34,
                                  child: Center(
                                    child: Text(
                                      d.day.toString(),
                                      style: AppStyles.bodyMedium,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        itemCount: end.difference(start).inDays,
                        itemSize: 54,
                        onItemFocus: (index) async => await context
                            .read<HabitsBloc>()
                            .updateSelected(start.add(Duration(days: index))),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                ],
              ),
            ),
          _ => null,
        },
        body: IndexedStack(
          index: page,
          children: const [
            MainPage(),
            HabitsPage(),
            FocusPage(),
            JournalPage(),
          ],
        ),
      ),
    );
  }
}
