import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' hide AuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list_auditoria/firebase_options.dart';
import 'package:todo_list_auditoria/modules/auth/pages/login/cubit/login_cubit.dart';
import 'package:todo_list_auditoria/modules/auth/pages/register/cubit/register_cubit.dart';
import 'package:todo_list_auditoria/modules/auth/providers/auth_provider.dart';
import 'package:todo_list_auditoria/modules/auth/providers/auth_provider_firebase.dart';
import 'package:todo_list_auditoria/modules/home/pages/todo_form/cubit/todo_form_cubit.dart';
import 'package:todo_list_auditoria/modules/home/pages/home/cubit/home_cubit.dart';
import 'package:todo_list_auditoria/modules/home/providers/home_provider.dart';
import 'package:todo_list_auditoria/modules/home/providers/home_provider_firebase.dart';
import 'package:todo_list_auditoria/modules/shared/controllers/account_info/account_info_controller.dart';

class AppDependencies {
  static final injector = GetIt.instance;

  Future<void> setupDependencies() async {
    await _setupFirebase();
    _setupAccountInfoController();
    _setupProviders();
    _setupCubits();
  }

  Future<void> _setupFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  void _setupAccountInfoController() {
    injector.registerLazySingleton(
      () => AccountInfoController(firebaseAuth: FirebaseAuth.instance),
    );
  }

  void _setupProviders() {
    injector
      ..registerLazySingleton<AuthProvider>(
        () => AuthProviderFirebase(firebaseAuth: FirebaseAuth.instance),
      )
      ..registerLazySingleton<HomeProvider>(
        () => HomeProviderFirebase(
          firebaseAuth: FirebaseAuth.instance,
          firebaseFirestore: FirebaseFirestore.instance,
        ),
      );
  }

  void _setupCubits() {
    injector
      ..registerLazySingleton(
        () => LoginCubit(authProvider: injector.get<AuthProvider>()),
      )
      ..registerLazySingleton(
        () => RegisterCubit(authProvider: injector.get<AuthProvider>()),
      )
      ..registerLazySingleton(
        () => HomeCubit(homeProvider: injector.get<HomeProvider>()),
      )
      ..registerLazySingleton(
        () => TodoFormCubit(homeProvider: injector.get<HomeProvider>()),
      );
  }
}
