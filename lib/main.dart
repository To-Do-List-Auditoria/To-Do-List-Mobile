import 'package:flutter/material.dart';
import 'package:todo_list_auditoria/app/app_dependencies.dart';
import 'package:todo_list_auditoria/app/app_widget.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppDependencies().setupDependencies();
  runApp(const AppWidget());
}
