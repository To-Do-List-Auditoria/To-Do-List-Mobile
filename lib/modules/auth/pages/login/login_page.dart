import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:todo_list_auditoria/modules/auth/pages/login/cubit/login_cubit.dart';
import 'package:todo_list_auditoria/modules/auth/pages/register/register_page.dart';
import 'package:todo_list_auditoria/modules/home/pages/home/home_page.dart';
import 'package:todo_list_auditoria/modules/shared/components/button/button_component.dart';
import 'package:todo_list_auditoria/modules/shared/components/text_form_field/text_form_field_component.dart';
import 'package:todo_list_auditoria/modules/shared/controllers/analytics/analytics_controller.dart';
import 'package:todo_list_auditoria/modules/shared/controllers/analytics/event/analytics_event.dart';
import 'package:todo_list_auditoria/modules/shared/controllers/analytics/event/analytics_event_name.dart';
import 'package:todo_list_auditoria/modules/shared/validators/validators.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final cubit = GetIt.instance.get<LoginCubit>();
  final analyticsController = GetIt.instance.get<AnalyticsController>();

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    analyticsController.log(
      AnalyticsEvent(name: AnalyticsEventName.loginPageViewed),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: BlocListener(
          bloc: cubit,
          listener: (context, state) {
            switch (state) {
              case LoginLoadingState():
                setState(() => isLoading = true);

              case LoginSuccessState():
                setState(() => isLoading = false);
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                );

              case LoginErrorState():
                setState(() => isLoading = false);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Erro ao realizar login!")),
                );
            }
          },
          child: Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    Text(
                      "To-Do List App",
                      style: TextStyle(
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 50.0),
                    Form(
                      key: formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormFieldComponent(
                            label: "Email:",
                            prefixIcon: Icons.email,
                            controller: emailController,
                            validator:
                                (text) => Validadors.emailValidator(text),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 20.0),
                          TextFormFieldComponent(
                            label: "Senha:",
                            prefixIcon: Icons.lock,
                            controller: passwordController,
                            obscureText: true,
                            validator:
                                (text) => Validadors.passwordValidator(text),
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 40.0),
                          ButtonComponent(
                            title: "Entrar",
                            isLoading: isLoading,
                            onTap: () {
                              if (formKey.currentState!.validate()) {
                                cubit.login(
                                  emailController.text,
                                  passwordController.text,
                                );
                              }
                            },
                          ),
                          const SizedBox(height: 20.0),
                          ButtonComponent(
                            title: "Criar conta",
                            onTap:
                                () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => const RegisterPage(),
                                  ),
                                ),
                          ),
                        ],
                      ),
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
