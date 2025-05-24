import 'package:cloud_firestore/cloud_firestore.dart';

class TodoModel {
  final String title;
  final String description;
  final DocumentReference? documentReference;

  TodoModel({
    required this.title,
    required this.description,
    this.documentReference,
  });

  factory TodoModel.fromFirebase(DocumentSnapshot doc) {
    return TodoModel(
      title: doc['title'],
      description: doc['description'],
      documentReference: doc.reference,
    );
  }
}
