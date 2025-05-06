import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:todo_list_auditoria/modules/auth/models/user_model.dart';
import 'package:todo_list_auditoria/modules/auth/providers/auth_provider.dart';

class AuthProviderFirebase implements AuthProvider {
  final FirebaseAuth firebaseAuth;

  AuthProviderFirebase({required this.firebaseAuth});

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final result = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return UserModel(id: result.user!.uid, email: result.user!.email!);
    } catch (e) {
      throw Exception('Error logging in: $e');
    }
  }

  @override
  Future<void> register({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception('Error creating user: $e');
    }
  }
}
