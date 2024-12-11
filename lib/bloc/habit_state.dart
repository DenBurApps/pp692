import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pp692/storages/models/habit.dart';

class HabitState extends Equatable {
  const HabitState({
    this.id,
    this.name = '',
    this.description = '',
    required this.date,
    this.color = 0xFF1656CE,
    this.done = false,
  });

  factory HabitState.fromIsarModel(Habit habit) {
    return HabitState(
      id: habit.id,
      name: habit.name ?? '',
      description: habit.description ?? '',
      date: habit.date ?? DateUtils.dateOnly(DateTime.now()),
      color: habit.color ?? 0xFF1656CE,
      done: habit.done ?? false,
    );
  }

  final int? id;
  final String name;
  final String description;
  final DateTime date;
  final int color;
  final bool done;

  @override
  List<Object?> get props => [id, name, description, date, color, done];

  HabitState copyWith({
    int? id,
    String? name,
    String? description,
    DateTime? date,
    int? color,
    bool? done,
  }) {
    return HabitState(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      date: date ?? this.date,
      color: color ?? this.color,
      done: done ?? this.done,
    );
  }

  Habit toIsarModel() {
    return Habit()
      ..name = name
      ..description = description
      ..date = date
      ..color = color
      ..done = done;
  }
}
