import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:pp692/bloc/habits_bloc.dart';
import 'package:pp692/bloc/habits_state.dart';
import 'package:pp692/bloc/note_state.dart';
import 'package:pp692/navigation/routes.dart';
import 'package:pp692/ui_kit/colors.dart';
import 'package:pp692/ui_kit/text_styles.dart';
import 'package:pp692/utils/assets_paths.dart';

class JournalPage extends StatelessWidget {
  const JournalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocSelector<HabitsBloc, HabitsState, List<NoteState>>(
      selector: (state) => state.notes,
      builder: (context, notes) => notes.isEmpty
          ? Center(
              child: GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(
                  AppRoutes.editNote,
                  arguments: NoteState(date: DateTime.now()),
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    bottom: 75 + MediaQuery.of(context).viewPadding.bottom,
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SvgPicture.asset(AppImages.polygon),
                      const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.add_rounded,
                            size: 40,
                            color: AppColors.onSurface,
                          ),
                          Text('Write new', style: AppStyles.displayXL),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  Column(
                    children: List.generate(
                      notes.length,
                      (index) => _NoteTile(notes[index]),
                    ),
                  ),
                  SizedBox(
                    height: 75 + MediaQuery.of(context).viewPadding.bottom,
                  ),
                ],
              ),
            ),
    );
  }
}

class _NoteTile extends StatelessWidget {
  const _NoteTile(this.note);

  final NoteState note;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      endActionPane: ActionPane(
        extentRatio: 60 / MediaQuery.sizeOf(context).width,
        motion: const ScrollMotion(),
        children: [
          GestureDetector(
            onTap: () async =>
                await context.read<HabitsBloc>().deleteNote(note.id ?? 0),
            child: Container(
              color: AppColors.red,
              width: 60,
              child: Center(child: SvgPicture.asset(AppIcons.trash)),
            ),
          ),
        ],
      ),
      child: GestureDetector(
        onTap: () => Navigator.of(context)
            .pushNamed(AppRoutes.editNote, arguments: note),
        behavior: HitTestBehavior.translucent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      DateFormat('HH:mm').format(note.date),
                      style: AppStyles.bodyLarge,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      note.description,
                      style: AppStyles.bodyMedium
                          .apply(color: AppColors.onSurface.withOpacity(.4)),
                      maxLines: 5,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.arrow_forward_ios, color: AppColors.onSurface),
            ],
          ),
        ),
      ),
    );
  }
}
