import 'package:cloud_firestore/cloud_firestore.dart';

class NoteModel {
  final String? id;
  final String? title;
  final String? body;

  NoteModel({this.body, this.id, this.title});

  factory NoteModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot) {
    return NoteModel(
      title: snapshot['title'],
      body: snapshot['body'],
      id: snapshot['id'],
    );
  }

  Map<String, dynamic> toDocument() => {
    "title": title,
    "id": id,
    "body": body,
  };
}