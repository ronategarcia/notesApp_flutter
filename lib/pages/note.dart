import 'package:flutter/material.dart';
import 'package:to_do_app/database/database_handler.dart';
import 'package:to_do_app/widgets/button_widget.dart';
import 'package:to_do_app/widgets/form_widget.dart';
import '../models/note_model.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _bodyController = TextEditingController();

  bool _isNoteCreating = false;

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AbsorbPointer(
        absorbing: _isNoteCreating,
        child: Stack(
        alignment: Alignment.center,
        children: [
          _isNoteCreating == true
              ? CircularProgressIndicator()
              : Container(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 50),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ButtonWidget(
                      icon: Icons.arrow_back,
                      onTap: () => Navigator.pop(context),
                    ),
                    ButtonWidget(
                      icon: Icons.done,
                      onTap: _createNote,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                FormWidget(
                  fontSize: 40,
                  controller: _titleController,
                  hintText: 'Title',
                ),
                const SizedBox(
                  height: 10,
                ),
                FormWidget(
                  maxLines: 15,
                  fontSize: 20,
                  controller: _bodyController,
                  hintText: 'Note here...',
                ),
              ],
            ),
          ),
        ],
      ),
      ),
    );
  }

  _createNote() {
    setState(() => _isNoteCreating = true);
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      if (_titleController.text.isEmpty) {
        setState(() => _isNoteCreating = false);
        return;
      }
      if (_bodyController.text.isEmpty) {
        setState(() => _isNoteCreating = false);
        return;
      }
      DatabaseHandler.createNote(NoteModel(
        title: _titleController.text,
        body: _bodyController.text,
      )).then((value) {
        _isNoteCreating = false;
        Navigator.pop(context);
      });
    });
  }
}
