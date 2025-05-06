import 'package:todo_list_auditoria/modules/auth/models/user_model.dart';

abstract class AuthProvider {
  Future<UserModel> login({required String email, required String password});

  Future<void> register({required String email, required String password});
}
