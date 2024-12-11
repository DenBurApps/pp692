import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_info/flutter_app_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:pp692/bloc/habit_state.dart';
import 'package:pp692/bloc/habits_bloc.dart';
import 'package:pp692/navigation/routes.dart';
import 'package:pp692/pages/edit_habit_page.dart';
import 'package:pp692/pages/habit_page.dart';
import 'package:pp692/pages/home_page.dart';
import 'package:pp692/pages/onboarding_page.dart';
import 'package:pp692/pages/privacy_page.dart';
import 'package:pp692/pages/settings_page.dart';
import 'package:pp692/pages/splash_page.dart';
import 'package:pp692/remote_config.dart';
import 'package:pp692/storages/isar.dart';
import 'package:pp692/storages/shared_preferences.dart';
import 'package:pp692/ui_kit/colors.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await RemoteConfigService.init();
  await AppSharedPreferences.init();
  await AppIsarDatabase.init();

  final isFirstRun = AppSharedPreferences.getIsFirstRun() ?? true;
  if (isFirstRun) await AppSharedPreferences.setNotFirstRun();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(
    AppInfo(
      data: await AppInfoData.get(),
      child: MyApp(isFirstRun: isFirstRun),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.isFirstRun});

  final bool isFirstRun;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HabitsBloc(),
      child: _AppWidget(isFirstRun: isFirstRun),
    );
  }
}

class _AppWidget extends StatelessWidget {
  const _AppWidget({required this.isFirstRun});

  final bool isFirstRun;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<HabitsBloc>().getHabits(),
      builder: (context, snapshot) => MaterialApp(
        title: '',
        themeMode: ThemeMode.dark,
        theme: ThemeData(
          primaryColor: AppColors.primary,
          scaffoldBackgroundColor: AppColors.background,
          brightness: Brightness.dark,
          appBarTheme: const AppBarTheme(
            titleSpacing: 16,
            backgroundColor: AppColors.surface,
            surfaceTintColor: AppColors.surface,
          ),
        ),
        onUnknownRoute: (settings) => CupertinoPageRoute(
          builder: (context) => const HomePage(),
        ),
        onGenerateRoute: (settings) => switch (settings.name) {
          AppRoutes.onBoarding => CupertinoPageRoute(
              settings: settings,
              builder: (context) => const OnBoardingPage(),
            ),
          AppRoutes.editHabit => CupertinoPageRoute(
              settings: settings,
              builder: (context) =>
                  EditHabitPage(habit: settings.arguments! as HabitState),
            ),
          AppRoutes.editNote => CupertinoPageRoute(
              settings: settings,
              builder: (context) =>
                  EditHabitPage(habit: settings.arguments! as HabitState),
            ),
          AppRoutes.home => CupertinoPageRoute(
              settings: settings,
              builder: (context) => const HomePage(),
            ),
          AppRoutes.habit => CupertinoPageRoute(
              settings: settings,
              builder: (context) =>
                  HabitPage(habit: settings.arguments! as HabitState),
            ),
          AppRoutes.privacy => CupertinoPageRoute(
              settings: settings,
              builder: (context) => const PrivacyPage(),
            ),
          AppRoutes.settings => CupertinoPageRoute(
              settings: settings,
              builder: (context) => const SettingsPage(),
            ),
          _ => null,
        },
        home: SplashPage(isFirstRun: isFirstRun),
      ),
    );
  }
}
