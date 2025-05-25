import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:todo_list_auditoria/modules/home/models/todo_model.dart';
import 'package:todo_list_auditoria/modules/home/providers/home_provider.dart';

class HomeProviderFirebase implements HomeProvider {
  final FirebaseAuth firebaseAuth;
  final FirebaseFirestore firebaseFirestore;

  HomeProviderFirebase({
    required this.firebaseAuth,
    required this.firebaseFirestore,
  });

  @override
  Future<List<TodoModel>> fetchTodos() async {
    try {
      final response = firebaseFirestore
          .collection("todos")
          .where("userId", isEqualTo: FirebaseAuth.instance.currentUser?.uid);

      final List<TodoModel> todos = await response.get().then(
        (query) => query.docs.map((e) => TodoModel.fromFirebase(e)).toList(),
      );

      return todos;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> saveTodo({required TodoModel todo}) async {
    try {
      final response = firebaseFirestore.collection("todos");

      final todoMap = {
        "title": todo.title,
        "description": todo.description,
        "userId": firebaseAuth.currentUser?.uid,
      };

      response.add(todoMap);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
