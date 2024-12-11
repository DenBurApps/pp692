import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pp692/bloc/habit_state.dart';

class HabitBloc extends Cubit<HabitState> {
  HabitBloc(super.state);

  void updateName(String value) {
    emit(state.copyWith(name: value.trim()));
  }

  void updateDescription(String value) {
    emit(state.copyWith(description: value.trim()));
  }

  void updateDate(DateTime value) {
    emit(
      state.copyWith(
        date: state.date.copyWith(
          day: value.day,
          month: value.month,
          year: value.year,
        ),
      ),
    );
  }

  void updateTime(DateTime value) {
    emit(state.copyWith(date: value));
  }

  void updateColor(int value) {
    emit(state.copyWith(color: value));
  }
}
