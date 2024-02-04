import 'package:flutter/material.dart';
import 'package:to_do_app/widgets/button_widget.dart';
import 'package:to_do_app/widgets/form_widget.dart';
import '../database/database_handler.dart';
import '../models/note_model.dart';
import '../widgets/diolog_box_widget.dart';

class EditNotePage extends StatefulWidget {
  final NoteModel noteModel;
  const EditNotePage({super.key, required this.noteModel});

  @override
  State<EditNotePage> createState() => _EditNotePageState();
}

class _EditNotePageState extends State<EditNotePage> {
  TextEditingController? _titleController;
  TextEditingController? _bodyController;

  bool _isNoteEditing = false;

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.noteModel.title);
    _bodyController = TextEditingController(text: widget.noteModel.body);
    super.initState();
  }

  @override
  void dispose() {
    _titleController!.dispose();
    _bodyController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: AbsorbPointer(
        absorbing: _isNoteEditing,
        child: Stack(
        alignment: Alignment.center,
        children: [
          _isNoteEditing == true
              ? Image.asset(
            "../assets/ios_loading.gif",
            width: 50,
            height: 50,
          )
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
                  icon: Icons.save_outlined,
                  onTap: () {
                    showDialogBoxWidget(
                        context,
                        height: 200,
                        title: 'Save Changes ?',
                        onTapYes: () {
                          _editNote();
                          Navigator.pop(context);
                        }
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 30,),
            FormWidget(
              fontSize: 40,
              controller: _titleController!,
              hintText: 'Title',
            ),
            const SizedBox(height: 10,),
            FormWidget(
              maxLines: 15,
              fontSize: 20,
              controller: _bodyController!,
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

  _editNote() {
    setState(() => _isNoteEditing = true);
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      if (_titleController!.text.isEmpty) {
        setState(() => _isNoteEditing = false);
        return;
      }
      if (_bodyController!.text.isEmpty) {
        setState(() => _isNoteEditing = false);
        return;
      }
      DatabaseHandler.updateNote(NoteModel(
        id: widget.noteModel.id,
        title: _titleController!.text,
        body: _bodyController!.text,
      )).then((value) {
        _isNoteEditing = false;
        Navigator.pop(context);
      });
    });
  }
}