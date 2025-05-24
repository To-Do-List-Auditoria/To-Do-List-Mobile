import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_auditoria/modules/home/models/todo_model.dart';
import 'package:todo_list_auditoria/modules/home/providers/home_provider.dart';

part 'todo_form_state.dart';

class TodoFormCubit extends Cubit<TodoFormState> {
  final HomeProvider homeProvider;

  TodoFormCubit({required this.homeProvider}) : super(const FormInitialState());

  Future<void> registerTodo({required TodoModel todo}) async {
    emit(const FormLoadingState());
    await Future.delayed(const Duration(seconds: 5));
    try {
      await homeProvider.saveTodo(todo: todo);
      emit(const FormSuccessState());
    } catch (e) {
      emit(const FormErrorState());
    }
  }
}
