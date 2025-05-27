import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list_auditoria/modules/auth/pages/register/cubit/register_cubit.dart';
import 'package:todo_list_auditoria/modules/shared/components/button/button_component.dart';
import 'package:todo_list_auditoria/modules/shared/components/text_form_field/text_form_field_component.dart';
import 'package:todo_list_auditoria/modules/shared/controllers/analytics/analytics_controller.dart';
import 'package:todo_list_auditoria/modules/shared/controllers/analytics/event/analytics_event.dart';
import 'package:todo_list_auditoria/modules/shared/controllers/analytics/event/analytics_event_name.dart';
import 'package:todo_list_auditoria/modules/shared/validators/validators.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final cubit = GetIt.instance.get<RegisterCubit>();
  final analyticsController = GetIt.instance.get<AnalyticsController>();

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    analyticsController.log(
      AnalyticsEvent(name: AnalyticsEventName.registerPageViewed),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Criar conta')),
      body: BlocListener<RegisterCubit, RegisterState>(
        bloc: cubit,
        listener: (context, state) {
          switch (state) {
            case RegisterInitialState():
              break;

            case RegisterLoadingState():
              break;

            case RegisterSuccessState():
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Conta criada com sucesso!")),
              );
              Navigator.pop(context);

            case RegisterErrorState():
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Erro ao criar conta!")),
              );
          }
        },
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                key: formKey,
                child: Column(
                  children: [
                    TextFormFieldComponent(
                      label: "Email:",
                      prefixIcon: Icons.email,
                      controller: emailController,
                      validator: (text) => Validadors.emailValidator(text),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 10.0),
                    TextFormFieldComponent(
                      label: "Senha:",
                      prefixIcon: Icons.lock,
                      controller: passwordController,
                      obscureText: true,
                      validator: (text) => Validadors.passwordValidator(text),
                      keyboardType: TextInputType.text,
                    ),
                    const SizedBox(height: 10.0),
                    TextFormFieldComponent(
                      label: "Confirmar Senha:",
                      prefixIcon: Icons.lock,
                      controller: confirmPasswordController,
                      obscureText: true,
                      validator: (text) => Validadors.confirmPasswordValidator(
                        text,
                        passwordController.text,
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    BlocBuilder(
                      bloc: cubit,
                      builder: (context, state) {
                        return ButtonComponent(
                          title: "Criar conta",
                          isLoading: state is RegisterLoadingState,
                          onTap: () {
                            if (formKey.currentState!.validate()) {
                              cubit.register(
                                email: emailController.text,
                                password: passwordController.text,
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
