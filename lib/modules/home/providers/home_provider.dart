import 'package:todo_list_auditoria/modules/home/models/todo_model.dart';

abstract class HomeProvider {
  Future<void> fetchTodos();
  Future<void> saveTodo({required TodoModel todo});
}
