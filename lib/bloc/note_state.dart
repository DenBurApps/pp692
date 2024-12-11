import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:pp692/storages/models/note.dart';

class NoteState extends Equatable {
  const NoteState({
    this.id,
    this.description = '',
    required this.date,
  });

  factory NoteState.fromIsarModel(Note note) {
    return NoteState(
      id: note.id,
      description: note.description ?? '',
      date: note.date ?? DateUtils.dateOnly(DateTime.now()),
    );
  }

  final int? id;
  final String description;
  final DateTime date;

  @override
  List<Object?> get props => [id, description, date];

  NoteState copyWith({
    int? id,
    String? description,
    DateTime? date,
  }) {
    return NoteState(
      id: id ?? this.id,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }

  Note toIsarModel() {
    return Note()
      ..description = description
      ..date = date;
  }
}
