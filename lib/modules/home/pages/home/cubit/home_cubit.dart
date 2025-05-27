import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_auditoria/modules/home/models/todo_model.dart';
import 'package:todo_list_auditoria/modules/home/providers/home_provider.dart';
import 'package:todo_list_auditoria/modules/shared/controllers/account_info/account_info_controller.dart';
import 'package:todo_list_auditoria/modules/shared/controllers/analytics/analytics_controller.dart';
import 'package:todo_list_auditoria/modules/shared/controllers/analytics/event/analytics_event.dart';
import 'package:todo_list_auditoria/modules/shared/controllers/analytics/event/analytics_event_name.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeProvider homeProvider;
  final AnalyticsController analyticsController;
  final AccountInfoController accountInfoController;

  HomeCubit({
    required this.homeProvider,
    required this.analyticsController,
    required this.accountInfoController,
  }) : super(const HomeInitialState());

  Future<void> fetchTodos() async {
    emit(const HomeLoadingState());
    await Future.delayed(const Duration(seconds: 2));

    try {
      final result = await homeProvider.fetchTodos();
      emit(HomeSuccessState(todos: result));
      await analyticsController.log(
        AnalyticsEvent(
          name: AnalyticsEventName.fetchTodosWithSuccess,
          params: {"email": accountInfoController.getUser()!.email},
        ),
      );
    } catch (e) {
      emit(const HomeErrorState());
      await analyticsController.log(
        AnalyticsEvent(
          name: AnalyticsEventName.fetchTodosWithError,
          params: {
            "email": accountInfoController.getUser()!.email,
            "error": e.toString(),
          },
        ),
      );
    }
  }

  Future<void> deleteTodo({
    required DocumentReference documentReference,
  }) async {
    emit(const HomeLoadingState());
    await Future.delayed(const Duration(seconds: 2));

    try {
      await homeProvider.deleteTodo(documentReference: documentReference);
      final result = await homeProvider.fetchTodos();
      emit(HomeSuccessState(todos: result));
      await analyticsController.log(
        AnalyticsEvent(name: AnalyticsEventName.todoDeletedWithSuccess),
      );
    } catch (e) {
      emit(const HomeErrorState());
      await analyticsController.log(
        AnalyticsEvent(
          name: AnalyticsEventName.todoDeletedWithError,
          params: {
            "email": accountInfoController.getUser()!.email,
            "error": e.toString(),
          },
        ),
      );
    }
  }
}
