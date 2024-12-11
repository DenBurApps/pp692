import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pp692/bloc/habit_state.dart';
import 'package:pp692/bloc/habits_state.dart';
import 'package:pp692/storages/isar.dart';

class HabitsBloc extends Cubit<HabitsState> {
  HabitsBloc()
      : super(HabitsState(selected: DateUtils.dateOnly(DateTime.now())));

  Future<void> getHabits() async {
    final habits = await AppIsarDatabase.getHabits(state.selected);
    emit(
      state.copyWith(
        habits:
            habits.reversed.map((e) => HabitState.fromIsarModel(e)).toList(),
      ),
    );
  }

  Future<void> addHabit(HabitState habit) async {
    await AppIsarDatabase.addHabit(habit.toIsarModel());
    await getHabits();
  }

  Future<void> deleteHabit(int id) async {
    await AppIsarDatabase.deleteHabit(id);
    await getHabits();
  }

  Future<void> updateHabit(int id, HabitState habit) async {
    await AppIsarDatabase.updateHabit(id, habit.toIsarModel());
    await getHabits();
  }

  void updatePage(int value) {
    emit(state.copyWith(page: value));
  }

  Future<void> updateSelected(DateTime value) async {
    emit(state.copyWith(selected: value));
    await getHabits();
  }

  void updateFilter(bool? value) {
    emit(
      HabitsState(
        habits: state.habits,
        page: state.page,
        selected: state.selected,
        filter: value,
      ),
    );
  }
}
