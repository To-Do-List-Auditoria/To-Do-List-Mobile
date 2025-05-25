import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list_auditoria/modules/home/pages/todo_form/todo_form_page.dart';
import 'package:todo_list_auditoria/modules/home/pages/home/cubit/home_cubit.dart';
import 'package:todo_list_auditoria/modules/shared/components/card/card_component.dart';
import 'package:todo_list_auditoria/modules/shared/components/loading/loading_component.dart';
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
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [IconButton(icon: const Icon(Icons.logout), onPressed: () {})],
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: TextSpan(
                text: 'Seja bem vindo, ',
                style: TextStyle(color: Colors.black, fontSize: 20.0),
                children: [
                  TextSpan(
                    text: user?.email ?? 'Usuário',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Divider(color: Colors.grey),
            SizedBox(height: 20.0),
            Expanded(
              child: BlocBuilder<HomeCubit, HomeState>(
                bloc: cubit,
                builder: (context, state) {
                  switch (state) {
                    case HomeInitialState():
                      return SizedBox();

                    case HomeLoadingState():
                      return const Center(child: LoadingComponent());

                    case HomeErrorState _:
                      return Center(
                        child: Column(
                          children: [
                            Text("Erro ao carregar tarefas."),
                            SizedBox(height: 10.0),
                            TextButton(
                              child: Text("Tentar novamente"),
                              onPressed: () => cubit.fetchTodos(),
                            ),
                          ],
                        ),
                      );

                    case HomeSuccessState():
                      if (state.todos.isEmpty) {
                        return Center(
                          child: Column(
                            children: [
                              Text("Nenhuma tarefa encontrada."),
                              SizedBox(height: 10.0),
                              TextButton(
                                child: Text("Tentar novamente"),
                                onPressed: () => cubit.fetchTodos(),
                              ),
                            ],
                          ),
                        );
                      }

                      return ListView.separated(
                        itemCount: state.todos.length,
                        itemBuilder: (context, index) {
                          final todo = state.todos[index];
                          return CardComponent(
                            child: ListTile(
                              title: Text(
                                todo.title,
                                style: TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(todo.description),
                              trailing: IconButton(
                                icon: Icon(Icons.delete),
                                onPressed: () {},
                              ),
                            ),
                          );
                        },
                        separatorBuilder:
                            (context, index) => SizedBox(height: 15.0),
                      );
                  }
                },
              ),
            ),
          ],
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
