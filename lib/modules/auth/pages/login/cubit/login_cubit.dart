import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_list_auditoria/modules/auth/providers/auth_provider.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  final AuthProvider authProvider;

  LoginCubit({required this.authProvider}) : super(const LoginInitialState());

  Future<void> login(String email, String password) async {
    emit(const LoginLoadingState());
    await Future.delayed(const Duration(seconds: 5));

    try {
      await authProvider.login(email: email, password: password);
      emit(const LoginSuccessState());
    } catch (e) {
      emit(const LoginErrorState());
    }
  }
}
