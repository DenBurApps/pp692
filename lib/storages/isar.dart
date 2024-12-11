import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pp692/storages/models/habit.dart';
import 'package:pp692/storages/models/note.dart';

abstract class AppIsarDatabase {
  static late final Isar _instance;

  static Future<Isar> init() async {
    final dir = await getApplicationDocumentsDirectory();
    return _instance = await Isar.open(
      [HabitSchema, NoteSchema],
      directory: dir.path,
    );
  }

  static Future<List<Habit>> getHabits(DateTime date) async {
    return await _instance.writeTxn(
      () async => await _instance.habits
          .filter()
          .dateBetween(
            date,
            date.add(const Duration(days: 1)),
            includeUpper: false,
          )
          .findAll(),
    );
  }

  static Future<void> addHabit(Habit habit) async {
    await _instance.writeTxn(() async => await _instance.habits.put(habit));
  }

  static Future<void> deleteHabit(int id) async {
    await _instance.writeTxn(() async => await _instance.habits.delete(id));
  }

  static Future<void> updateHabit(int id, Habit newHabit) async {
    await _instance.writeTxn(() async {
      final habit = await _instance.habits.get(id);
      if (habit != null) {
        habit
          ..name = newHabit.name
          ..description = newHabit.description
          ..date = newHabit.date
          ..color = newHabit.color
          ..done = newHabit.done;
        return await _instance.habits.put(habit);
      }
    });
  }

  static Future<List<Note>> getNotes(DateTime date) async {
    return await _instance.writeTxn(
      () async => await _instance.notes
          .filter()
          .dateBetween(
            date,
            date.add(const Duration(days: 1)),
            includeUpper: false,
          )
          .findAll(),
    );
  }

  static Future<void> addNote(Note note) async {
    await _instance.writeTxn(() async => await _instance.notes.put(note));
  }

  static Future<void> deleteNote(int id) async {
    await _instance.writeTxn(() async => await _instance.notes.delete(id));
  }

  static Future<void> updateNote(int id, Note newNote) async {
    await _instance.writeTxn(() async {
      final note = await _instance.notes.get(id);
      if (note != null) {
        note
          ..description = newNote.description
          ..date = newNote.date;
        return await _instance.notes.put(note);
      }
    });
  }
}
