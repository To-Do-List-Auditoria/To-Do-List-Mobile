import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_auditoria/modules/auth/providers/auth_provider.dart';
import 'package:todo_list_auditoria/modules/shared/controllers/analytics/analytics_controller.dart';
import 'package:todo_list_auditoria/modules/shared/controllers/analytics/event/analytics_event.dart';
import 'package:todo_list_auditoria/modules/shared/controllers/analytics/event/analytics_event_name.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  final AuthProvider authProvider;
  final AnalyticsController analyticsController;

  RegisterCubit({required this.authProvider, required this.analyticsController})
    : super(const RegisterInitialState());

  Future<void> register({
    required String email,
    required String password,
  }) async {
    emit(const RegisterLoadingState());
    await Future.delayed(const Duration(seconds: 5));

    try {
      await authProvider.register(email: email, password: password);

      emit(const RegisterSuccessState());

      await analyticsController.log(
        AnalyticsEvent(
          name: AnalyticsEventName.userCreatedWithSuccess,
          params: {"email": email},
        ),
      );
    } catch (e) {
      emit(const RegisterErrorState());

      await analyticsController.log(
        AnalyticsEvent(
          name: AnalyticsEventName.userCreatedWithError,
          params: {"email": email, "error": e.toString()},
        ),
      );
    }
  }
}
