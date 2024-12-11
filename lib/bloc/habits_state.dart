import 'package:equatable/equatable.dart';
import 'package:pp692/bloc/habit_state.dart';

class HabitsState extends Equatable {
  const HabitsState({
    this.habits = const [],
    this.page = 0,
    required this.selected,
    this.filter,
  });

  final List<HabitState> habits;
  final int page;
  final DateTime selected;
  final bool? filter;

  @override
  List<Object?> get props => [habits, page, selected, filter];

  HabitsState copyWith({
    List<HabitState>? habits,
    int? page,
    DateTime? selected,
    bool? filter,
  }) {
    return HabitsState(
      habits: habits ?? this.habits,
      page: page ?? this.page,
      selected: selected ?? this.selected,
      filter: filter ?? this.filter,
    );
  }
}
