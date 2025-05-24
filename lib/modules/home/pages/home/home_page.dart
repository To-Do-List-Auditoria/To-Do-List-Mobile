import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list_auditoria/modules/home/pages/todo_form/todo_form_page.dart';
import 'package:todo_list_auditoria/modules/home/pages/home/cubit/home_cubit.dart';
import 'package:todo_list_auditoria/modules/shared/controllers/account_info/account_info_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final cubit = GetIt.instance.get<HomeCubit>();
  final accountInfoController = GetIt.instance.get<AccountInfoController>();

  @override
  void initState() {
    cubit.fetchTodos();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = accountInfoController.getUser();

    return Scaffold(
      appBar: AppBar(title: const Text('Home Page')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [Text(user?.id.toString() ?? ""), Text(user?.email ?? "")],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const TodoFormPage()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
