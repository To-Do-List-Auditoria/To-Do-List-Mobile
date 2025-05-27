import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_list_auditoria/modules/home/models/todo_model.dart';

abstract class HomeProvider {
  Future<List<TodoModel>> fetchTodos();
  Future<void> saveTodo({required TodoModel todo});
  Future<void> deleteTodo({required DocumentReference documentReference});
}
