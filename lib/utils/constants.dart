import 'package:pp692/utils/assets_paths.dart';

abstract class AppConstants {
  static const isFirstRun = "isFirstRun";
  static const duration200 = Duration(milliseconds: 200);
  static const pages = [
    (AppIcons.home, 'Home'),
    (AppIcons.habits, 'Habits'),
    (AppIcons.focus, 'Focus'),
    (AppIcons.journal, 'Journal'),
  ];
  static const focus = [300, 900, 1500, 3600];
  static const breaks = [60, 300, 900, 1800];
}
