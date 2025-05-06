import 'package:firebase_auth/firebase_auth.dart';
import 'package:todo_list_auditoria/modules/auth/models/user_model.dart';

class AccountInfoController {
  final FirebaseAuth firebaseAuth;

  AccountInfoController({required this.firebaseAuth});

  UserModel? getUser() {
    final firebaseUser = firebaseAuth.currentUser;

    if (firebaseUser == null) {
      return null;
    }

    return UserModel(id: firebaseUser.uid, email: firebaseUser.email!);
  }
}
