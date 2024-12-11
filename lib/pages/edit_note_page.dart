import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:pp692/bloc/habits_bloc.dart';
import 'package:pp692/bloc/note_state.dart';
import 'package:pp692/ui_kit/colors.dart';
import 'package:pp692/ui_kit/text_styles.dart';
import 'package:pp692/utils/constants.dart';

class EditNotePage extends StatefulWidget {
  const EditNotePage({super.key, required this.note});

  final NoteState note;

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  String desc = '';

  void updateValue(String value) {
    setState(() => desc = value.trim());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 16,
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.background,
        surfaceTintColor: AppColors.background,
        title: Row(
          children: [
            Text(
              DateFormat('EEE, d MMM').format(widget.note.date),
              style: AppStyles.displayMedium,
            ),
            const Spacer(),
            GestureDetector(
              onTap: desc.isNotEmpty
                  ? () async {
                      if (widget.note.id != null) {
                        await context.read<HabitsBloc>().updateNote(
                              widget.note.id ?? 0,
                              widget.note.copyWith(description: desc),
                            );
                      } else {
                        await context
                            .read<HabitsBloc>()
                            .addNote(widget.note.copyWith(description: desc));
                      }
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    }
                  : Navigator.of(context).pop,
              child: AnimatedSwitcher(
                duration: AppConstants.duration200,
                child: desc.isNotEmpty
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
          ],
        ),
      ),
      body: SafeArea(
        child: TextFormField(
          autofocus: true,
          initialValue: widget.note.description,
          style: AppStyles.bodyMedium,
          cursorHeight: 20,
          cursorWidth: 1,
          onChanged: updateValue,
          maxLines: null,
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            hintStyle: AppStyles.bodyMedium
                .apply(color: AppColors.onSurface.withOpacity(.5)),
            hintText:
                'How did you feel today? What were your\nthoughts? What did you active?',
            focusedBorder: InputBorder.none,
            enabledBorder: InputBorder.none,
            errorBorder: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
