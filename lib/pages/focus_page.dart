import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pp692/ui_kit/colors.dart';
import 'package:pp692/ui_kit/text_styles.dart';
import 'package:pp692/ui_kit/widgets/app_elevated_button.dart';
import 'package:pp692/utils/constants.dart';

class FocusPage extends StatefulWidget {
  const FocusPage({super.key});

  @override
  State<FocusPage> createState() => _FocusPageState();
}

class _FocusPageState extends State<FocusPage> {
  int totalTime = 300;
  final stopwatch = Stopwatch();
  Timer? timer;
  int elapsed = 0;
  bool isStarted = false;
  bool isFocus = true;

  void updateMode(bool value) {
    if (elapsed > 0 || isStarted) return;
    setState(() {
      isFocus = value;
      totalTime = value ? AppConstants.focus.first : AppConstants.breaks.first;
    });
  }

  void start() {
    setState(() => isStarted = true);
    stopwatch.start();
    timer = Timer.periodic(
      const Duration(milliseconds: 200),
      (_) => setState(() {
        elapsed = stopwatch.elapsed.inSeconds;
        if (elapsed >= totalTime) {
          reset();
        }
      }),
    );
  }

  void pause() {
    setState(() => isStarted = false);
    stopwatch.stop();
  }

  void resume() {
    setState(() => isStarted = true);
    stopwatch.start();
  }

  void reset() {
    setState(() {
      isStarted = false;
      elapsed = 0;
    });
    stopwatch.stop();
    stopwatch.reset();
    timer?.cancel();
    timer = null;
  }

  void updateTotal(int value) {
    if (elapsed > 0 || isStarted) return;
    setState(() => totalTime = value);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          SizedBox(
            height: 20 +
                MediaQuery.of(context).viewInsets.top +
                MediaQuery.of(context).viewPadding.top,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () => updateMode(true),
                child: AnimatedDefaultTextStyle(
                  duration: AppConstants.duration200,
                  style: AppStyles.displayMedium.apply(
                    color: AppColors.onSurface.withOpacity(isFocus ? 1 : .2),
                  ),
                  child: const Text('Focus'),
                ),
              ),
              const SizedBox(width: 20),
              GestureDetector(
                onTap: () => updateMode(false),
                child: AnimatedDefaultTextStyle(
                  duration: AppConstants.duration200,
                  style: AppStyles.displayMedium.apply(
                    color: AppColors.onSurface.withOpacity(!isFocus ? 1 : .2),
                  ),
                  child: const Text('Break'),
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: elapsed > 0 ? reset : null,
                child: AnimatedOpacity(
                  opacity: elapsed > 0 ? 1 : 0,
                  duration: AppConstants.duration200,
                  child: const Icon(
                    Icons.close_rounded,
                    color: AppColors.onSurface,
                  ),
                ),
              ),
            ],
          ),
          const Spacer(flex: 4),
          Builder(
            builder: (context) {
              final value = totalTime - elapsed;
              return Text(
                '${"${value ~/ 60}".padLeft(2, '0')}:${"${value % 60}".padLeft(2, '0')}',
                style: AppStyles.displayXL,
              );
            },
          ),
          const SizedBox(height: 8),
          Builder(
            builder: (context) {
              final values = isFocus ? AppConstants.focus : AppConstants.breaks;
              return Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  values.length * 2 - 1,
                  (index) => index.isEven
                      ? GestureDetector(
                          onTap: () => updateTotal(values[index ~/ 2]),
                          child: AnimatedContainer(
                            duration: AppConstants.duration200,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: totalTime == values[index ~/ 2]
                                  ? AppColors.primary
                                  : null,
                            ),
                            width: 30,
                            height: 30,
                            child: Center(
                              child: Text(
                                '${values[index ~/ 2] ~/ 60}'.padLeft(2, '0'),
                                style: AppStyles.bodyMedium,
                              ),
                            ),
                          ),
                        )
                      : const SizedBox(width: 12),
                ),
              );
            },
          ),
          const Spacer(),
          SizedBox(
            width: 260,
            child: AppElevatedButton(
              buttonText: isStarted
                  ? 'Pause'
                  : elapsed > 0
                      ? 'Resume'
                      : 'Start',
              onTap: isStarted ? pause : start,
            ),
          ),
          const Spacer(flex: 3),
          SizedBox(
            height: 75 + MediaQuery.of(context).viewPadding.bottom,
          ),
        ],
      ),
    );
  }
}
