import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/note_model.dart';

class DatabaseHandler {
  // create note
  static Future<void> createNote(NoteModel note) async {
    String uid = _getUid();
    final noteCollection = FirebaseFirestore.instance.collection(uid);
    final id = noteCollection.doc().id;
    final newNote =
        NoteModel(id: id, title: note.title, body: note.body).toDocument();

    try {
      noteCollection.doc(id).set(newNote);
    } catch (e) {
      print('Some error occur $e');
    }
  }

  // read note
  static Stream<List<NoteModel>> getNotes() {
    String uid = _getUid();
    final noteCollection = FirebaseFirestore.instance.collection(uid);
    return noteCollection.snapshots().map((querySnapshot) =>
        querySnapshot.docs.map((e) => NoteModel.fromSnapshot(e)).toList());
  }

  // update note
  static Future<void> updateNote(NoteModel note) async {
    String uid = _getUid();
    final noteCollection = FirebaseFirestore.instance.collection(uid);
    final newNote = NoteModel(
      id: note.id,
      title: note.title,
      body: note.body
    ).toDocument();

    try {
      noteCollection.doc(note.id).update(newNote);
    } catch (e) {
      print('Some error occur $e');
    }
  }

  // delete note
  static Future<void> deleteNote(String id) async {
    String uid = _getUid();
    final noteCollection = FirebaseFirestore.instance.collection(uid);

    try {
      await noteCollection.doc(id).delete();
    } catch (e) {
      print('Some error occur $e');
    }
  }

  static String _getUid() {
    final User? user = FirebaseAuth.instance.currentUser;
    final String? uid = user?.uid;
    if (uid == null) {
      throw Exception('User not authenticated');
    }
    return uid;
  }
}