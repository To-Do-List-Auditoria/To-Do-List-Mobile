import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list_auditoria/modules/home/models/todo_model.dart';
import 'package:todo_list_auditoria/modules/home/pages/todo_form/cubit/todo_form_cubit.dart';
import 'package:todo_list_auditoria/modules/shared/components/button/button_component.dart';
import 'package:todo_list_auditoria/modules/shared/components/text_form_field/text_form_field_component.dart';
import 'package:todo_list_auditoria/modules/shared/validators/validators.dart';

class TodoFormPage extends StatefulWidget {
  const TodoFormPage({super.key});

  @override
  State<TodoFormPage> createState() => _TodoFormPageState();
}

class _TodoFormPageState extends State<TodoFormPage> {
  final cubit = GetIt.instance.get<TodoFormCubit>();

  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar To-Do')),
      body: BlocListener<TodoFormCubit, TodoFormState>(
        bloc: cubit,
        listener: (context, state) {
          switch (state) {
            case FormInitialState():
              break;

            case FormLoadingState():
              break;

            case FormSuccessState():
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("To-Do criado com sucesso!")),
              );
              Navigator.pop(context);

            case FormErrorState():
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Erro ao criar To-Do!")),
              );
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormFieldComponent(
                      label: "Título",
                      controller: titleController,
                      validator: (text) => Validadors.genericValidator(text),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 10.0),
                    TextFormFieldComponent(
                      label: "Descrição",
                      controller: descriptionController,
                      validator: (text) => Validadors.genericValidator(text),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 20.0),
                    BlocBuilder(
                      bloc: cubit,
                      builder: (context, state) {
                        return ButtonComponent(
                          isLoading: state is FormLoadingState,
                          title: "Criar",
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              cubit.registerTodo(
                                todo: TodoModel(
                                  title: titleController.text,
                                  description: descriptionController.text,
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
