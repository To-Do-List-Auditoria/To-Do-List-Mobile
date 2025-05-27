import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_auditoria/modules/auth/providers/auth_provider.dart';
import 'package:todo_list_auditoria/modules/shared/controllers/analytics/analytics_controller.dart';
import 'package:todo_list_auditoria/modules/shared/controllers/analytics/event/analytics_event.dart';
import 'package:todo_list_auditoria/modules/shared/controllers/analytics/event/analytics_event_name.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthProvider authProvider;
  final AnalyticsController analyticsController;

  LoginCubit({required this.authProvider, required this.analyticsController})
    : super(const LoginInitialState());

  Future<void> login(String email, String password) async {
    emit(const LoginLoadingState());
    await Future.delayed(const Duration(seconds: 5));

    try {
      await authProvider.login(email: email, password: password);

      emit(const LoginSuccessState());

      await analyticsController.log(
        AnalyticsEvent(
          name: AnalyticsEventName.userLoggedInWithSuccess,
          params: {"email": email},
        ),
      );
    } catch (e) {
      emit(const LoginErrorState());

      await analyticsController.log(
        AnalyticsEvent(
          name: AnalyticsEventName.userLoggedInWithError,
          params: {"email": email, "error": e.toString()},
        ),
      );
    }
  }
}
