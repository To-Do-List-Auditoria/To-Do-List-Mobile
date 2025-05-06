import 'package:flutter/material.dart';
import 'package:todo_list_auditoria/app/app_theme.dart';
import 'package:todo_list_auditoria/modules/auth/pages/login/login_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Todo List App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const LoginPage(),
    );
  }
}
