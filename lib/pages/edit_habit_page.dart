import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:pp692/bloc/habit_bloc.dart';
import 'package:pp692/bloc/habit_state.dart';
import 'package:pp692/bloc/habits_bloc.dart';
import 'package:pp692/ui_kit/colors.dart';
import 'package:pp692/ui_kit/text_styles.dart';
import 'package:pp692/ui_kit/widgets/app_text_form_field.dart';
import 'package:pp692/utils/assets_paths.dart';
import 'package:pp692/utils/constants.dart';

class EditHabitPage extends StatelessWidget {
  const EditHabitPage({super.key, required this.habit});

  final HabitState habit;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HabitBloc(habit),
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 16,
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.surface,
          surfaceTintColor: AppColors.surface,
          title: Row(
            children: [
              const Text('Create a habit', style: AppStyles.displayMedium),
              const Spacer(),
              BlocBuilder<HabitBloc, HabitState>(
                builder: (context, state) => GestureDetector(
                  onTap: state.name.isNotEmpty
                      ? () async {
                          if (habit.id != null) {
                            await context
                                .read<HabitsBloc>()
                                .updateHabit(habit.id ?? 0, state);
                          } else {
                            await context.read<HabitsBloc>().addHabit(state);
                          }
                          if (context.mounted) {
                            Navigator.of(context).pop();
                          }
                        }
                      : Navigator.of(context).pop,
                  child: AnimatedSwitcher(
                    duration: AppConstants.duration200,
                    child: state.name.isNotEmpty
                        ? const Icon(
                            Icons.check_rounded,
                            color: AppColors.onSurface,
                          )
                        : const Icon(
                            Icons.close_rounded,
                            color: AppColors.onSurface,
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  const Text('I want to', style: AppStyles.displaySmall),
                  const Spacer(),
                  BlocSelector<HabitBloc, HabitState, int>(
                    selector: (state) => state.color,
                    builder: (context, color) => GestureDetector(
                      onTap: () => showModalBottomSheet(
                        backgroundColor: AppColors.background,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(10),
                          ),
                        ),
                        useSafeArea: true,
                        isScrollControlled: true,
                        context: context,
                        builder: (_) => BlocProvider.value(
                          value: context.read<HabitBloc>(),
                          child: const _ColorPicker(),
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 10,
                        backgroundColor: Color(color),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 28),
              BlocSelector<HabitBloc, HabitState, String>(
                selector: (state) => state.name,
                builder: (context, name) => AppTextFormField(
                  initialValue: name,
                  hint: 'Name of habit',
                  onChanged: context.read<HabitBloc>().updateName,
                  formatters: [LengthLimitingTextInputFormatter(40)],
                ),
              ),
              const SizedBox(height: 8),
              BlocSelector<HabitBloc, HabitState, String>(
                selector: (state) => state.description,
                builder: (context, description) => AppTextFormField(
                  initialValue: description,
                  hint: 'Description of the habit (optional)',
                  onChanged: context.read<HabitBloc>().updateDescription,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    child: BlocSelector<HabitBloc, HabitState, DateTime>(
                      selector: (state) => state.date,
                      builder: (context, date) => GestureDetector(
                        onTap: () => showCupertinoModalPopup<void>(
                          context: context,
                          builder: (_) => Container(
                            height: 216,
                            padding: const EdgeInsets.only(top: 6.0),
                            margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            color: AppColors.background,
                            child: SafeArea(
                              top: false,
                              child: CupertinoDatePicker(
                                initialDateTime: date,
                                mode: CupertinoDatePickerMode.time,
                                use24hFormat: true,
                                showDayOfWeek: true,
                                onDateTimeChanged:
                                    context.read<HabitBloc>().updateTime,
                              ),
                            ),
                          ),
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: AppColors.outline),
                            ),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Text(
                                DateFormat('HH:mm').format(date),
                                style: AppStyles.bodyMedium,
                              ),
                              const Spacer(),
                              SvgPicture.asset(AppIcons.time),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: BlocSelector<HabitBloc, HabitState, DateTime>(
                      selector: (state) => state.date,
                      builder: (context, date) => GestureDetector(
                        onTap: () => showCupertinoModalPopup<void>(
                          context: context,
                          builder: (_) => Container(
                            height: 216,
                            padding: const EdgeInsets.only(top: 6.0),
                            margin: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            color: AppColors.background,
                            child: SafeArea(
                              top: false,
                              child: CupertinoDatePicker(
                                initialDateTime: date,
                                mode: CupertinoDatePickerMode.date,
                                use24hFormat: true,
                                showDayOfWeek: true,
                                onDateTimeChanged:
                                    context.read<HabitBloc>().updateDate,
                              ),
                            ),
                          ),
                        ),
                        child: Container(
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom: BorderSide(color: AppColors.outline),
                            ),
                          ),
                          padding: const EdgeInsets.all(12),
                          child: Row(
                            children: [
                              Text(
                                DateFormat('d MMM. yyyy').format(date),
                                style: AppStyles.bodyMedium,
                              ),
                              const Spacer(),
                              SvgPicture.asset(AppIcons.calendar),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ColorPicker extends StatelessWidget {
  const _ColorPicker();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(width: 30),
              const Text('Color picker', style: AppStyles.displaySmall),
              GestureDetector(
                onTap: Navigator.of(context).pop,
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.onSurface.withOpacity(.4),
                  ),
                  width: 30,
                  height: 30,
                  child: const Icon(
                    Icons.close_rounded,
                    color: AppColors.onSurface,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          BlocSelector<HabitBloc, HabitState, int>(
            selector: (state) => state.color,
            builder: (context, state) => ColorPicker(
              padding: EdgeInsets.zero,
              color: Color(state),
              onColorChanged: (value) =>
                  context.read<HabitBloc>().updateColor(value.value),
              enableOpacity: true,
              pickersEnabled: const {
                ColorPickerType.both: false,
                ColorPickerType.primary: false,
                ColorPickerType.accent: false,
                ColorPickerType.bw: false,
                ColorPickerType.custom: false,
                ColorPickerType.customSecondary: false,
                ColorPickerType.wheel: true,
              },
              enableShadesSelection: false,
              opacitySubheading: const Align(
                alignment: Alignment.centerLeft,
                child: Text('OPACITY', style: AppStyles.bodyMedium),
              ),
            ),
          ),
          SizedBox(height: 20 + MediaQuery.of(context).viewPadding.bottom),
        ],
      ),
    );
  }
}
