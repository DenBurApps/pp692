import 'package:isar/isar.dart';

part 'habit.g.dart';

@collection
class Habit {
  Id id = Isar.autoIncrement;

  String? name;
  String? description;
  DateTime? date;
  int? color;
  bool? done;
}
