import 'package:flutter/material.dart';
import 'package:pp692/navigation/routes.dart';
import 'package:pp692/ui_kit/colors.dart';
import 'package:pp692/ui_kit/text_styles.dart';
import 'package:pp692/ui_kit/widgets/app_elevated_button.dart';
import 'package:pp692/utils/assets_paths.dart';
import 'package:pp692/utils/constants.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  late final PageController _controller;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _controller = PageController();
  }

  Future<void> _nextPage() async {
    if (_currentPage == 2) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.home);
    } else {
      setState(() => _currentPage++);
      await _controller.nextPage(
        duration: AppConstants.duration200,
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.onBoarding1),
                fit: BoxFit.cover,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 514),
                  const Text(
                    'Welcome to the\nHabitTracker!',
                    style: AppStyles.displayLarge,
                  ),
                  const Spacer(flex: 16),
                  Text(
                    'Start forming new habits and reach your\ngoals with HabitTracker.',
                    style: AppStyles.bodyMedium
                        .apply(color: AppColors.onBackground),
                  ),
                  const Spacer(flex: 52),
                  AppElevatedButton(
                    buttonText: "Next",
                    onTap: _nextPage,
                  ),
                  const Spacer(flex: 27),
                ],
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.onBoarding2),
                fit: BoxFit.cover,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 514),
                  const Text(
                    'Use our timer to\nfocus!',
                    style: AppStyles.displayLarge,
                  ),
                  const Spacer(flex: 16),
                  Text(
                    "Focus on important activities and don't get\ndistracted by unimportant things",
                    style: AppStyles.bodyMedium
                        .apply(color: AppColors.onBackground),
                  ),
                  const Spacer(flex: 52),
                  AppElevatedButton(
                    buttonText: "Next",
                    onTap: _nextPage,
                  ),
                  const Spacer(flex: 27),
                ],
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppImages.onBoarding2),
                fit: BoxFit.cover,
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 514),
                  const Text(
                    'Start your\nproductive day!',
                    style: AppStyles.displayLarge,
                  ),
                  const Spacer(flex: 16),
                  Text(
                    "Ready to improve your life? Start today!",
                    style: AppStyles.bodyMedium
                        .apply(color: AppColors.onBackground),
                  ),
                  const Spacer(flex: 72),
                  AppElevatedButton(
                    buttonText: _currentPage == 2 ? "Get Started" : "Next",
                    onTap: _nextPage,
                  ),
                  const Spacer(flex: 27),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
