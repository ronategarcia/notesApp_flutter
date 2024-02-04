import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/pages/edit_note.dart';
import 'package:to_do_app/pages/note.dart';
import 'package:to_do_app/widgets/diolog_box_widget.dart';
import '../database/database_handler.dart';
import '../models/note_model.dart';
import '../widgets/single_note_widget.dart';

class NotesPage extends StatefulWidget {
  const NotesPage({super.key});

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.grey.shade800,
        automaticallyImplyLeading: false,
        title: const Text(
          'Notes',
          style: TextStyle(fontSize: 40, color: Colors.white),
        ),
        actions: [
          IconButton(onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushNamed(context, 'login_screen');
          }, icon: Icon(Icons.logout))
        ],
      ),
      floatingActionButton: SizedBox(
        width: 60,
        height: 60,
        child: FloatingActionButton(
          backgroundColor: Colors.blue.shade900,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const NotePage()),
            );
          },
          child: Icon(
            Icons.add,
            size: 30,
            color: Colors.blue.shade100,
          ),
        ),
      ),
      body: StreamBuilder<List<NoteModel>>(
        stream: DatabaseHandler.getNotes(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData == false) {
            return _noNotesWidget();
          }
          if (snapshot.data!.isEmpty) {
            return _noNotesWidget();
          }
          if (snapshot.hasData) {
            final notes = snapshot.data;
            return ListView.builder(
              itemCount: notes!.length,
              itemBuilder: (context, index) {
                return SingleNoteWidget(
                  title: notes[index].title,
                  body: notes[index].body,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => EditNotePage(noteModel: notes[index],)),
                    );
                  },
                  onLongPress: () {
                    showDialogBoxWidget(context,
                        height: 250,
                        title: 'Are you sure you want\nto delete this note ?',
                        onTapYes: () {
                          DatabaseHandler.deleteNote(notes[index].id!);
                          Navigator.pop(context);
                        });
                  },
                );
              },
            );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }

  _noNotesWidget() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Create a new note!\n Click on the + sign in the bottom right corner',
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w400),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
