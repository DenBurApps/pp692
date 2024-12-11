import 'package:equatable/equatable.dart';
import 'package:pp692/bloc/habit_state.dart';
import 'package:pp692/bloc/note_state.dart';

class HabitsState extends Equatable {
  const HabitsState({
    this.habits = const [],
    this.notes = const [],
    this.page = 0,
    required this.selected,
    this.filter,
  });

  final List<HabitState> habits;
  final List<NoteState> notes;
  final int page;
  final DateTime selected;
  final bool? filter;

  @override
  List<Object?> get props => [habits, notes, page, selected, filter];

  HabitsState copyWith({
    List<HabitState>? habits,
    List<NoteState>? notes,
    int? page,
    DateTime? selected,
    bool? filter,
  }) {
    return HabitsState(
      habits: habits ?? this.habits,
      notes: notes ?? this.notes,
      page: page ?? this.page,
      selected: selected ?? this.selected,
      filter: filter ?? this.filter,
    );
  }
}
