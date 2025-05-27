import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_auditoria/modules/home/models/todo_model.dart';
import 'package:todo_list_auditoria/modules/home/providers/home_provider.dart';
import 'package:todo_list_auditoria/modules/shared/controllers/account_info/account_info_controller.dart';
import 'package:todo_list_auditoria/modules/shared/controllers/analytics/analytics_controller.dart';
import 'package:todo_list_auditoria/modules/shared/controllers/analytics/event/analytics_event.dart';
import 'package:todo_list_auditoria/modules/shared/controllers/analytics/event/analytics_event_name.dart';

part 'todo_form_state.dart';

class TodoFormCubit extends Cubit<TodoFormState> {
  final HomeProvider homeProvider;
  final AnalyticsController analyticsController;
  final AccountInfoController accountInfoController;

  TodoFormCubit({
    required this.homeProvider,
    required this.analyticsController,
    required this.accountInfoController,
  }) : super(const FormInitialState());

  Future<void> registerTodo({required TodoModel todo}) async {
    emit(const FormLoadingState());
    await Future.delayed(const Duration(seconds: 5));
    try {
      await homeProvider.saveTodo(todo: todo);
      emit(const FormSuccessState());
      await analyticsController.log(
        AnalyticsEvent(
          name: AnalyticsEventName.todoCreatedWithSuccess,
          params: {
            "email": accountInfoController.getUser()!.email,
            "title": todo.title,
          },
        ),
      );
    } catch (e) {
      emit(const FormErrorState());
      await analyticsController.log(
        AnalyticsEvent(
          name: AnalyticsEventName.todoCreatedWithError,
          params: {
            "email": accountInfoController.getUser()!.email,
            "title": todo.title,
            "error": e.toString(),
          },
        ),
      );
    }
  }
}
