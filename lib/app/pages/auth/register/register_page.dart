import 'package:dw9_delivery_appp/app/core/ui/base_state/base_state.dart';
import 'package:dw9_delivery_appp/app/core/ui/styles/text_styles.dart';
import 'package:dw9_delivery_appp/app/core/ui/widgets/delivery_appbar.dart';
import 'package:dw9_delivery_appp/app/core/ui/widgets/delivery_button.dart';
import 'package:dw9_delivery_appp/app/pages/auth/register/bloc/register_controller.dart';
import 'package:dw9_delivery_appp/app/pages/auth/register/bloc/register_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends BaseState<RegisterPage, RegisterController> {
  final _formKey = GlobalKey<FormState>();

  final _nameEC = TextEditingController();
  final _emailEC = TextEditingController();
  final _passwordEC = TextEditingController();

  @override
  void dispose() {
    _nameEC.dispose();
    _emailEC.dispose();
    _passwordEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterController, RegisterState>(
      listener: (context, state) {
        state.status.matchAny(
          any: () => hideLoader(),
          register: () => showLoader(),
          error: () {
            hideLoader();
            showError('Erro ao registrar o usuário');
          },
          success: () {
            hideLoader();
            showSuccess('Cadastro realizado com sucesso!');
            Navigator.pop(context);
          },
        );
      },
      child: Scaffold(
        appBar: DeliveryAppbar(),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Cadastro',
                    style: context.textStyles.textTitle,
                  ),
                  Text(
                    'Preencha os campos abaixo para criar o seu cadastro.',
                    style: context.textStyles.textMedium.copyWith(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Nome'),
                    controller: _nameEC,
                    validator: Validatorless.required('Nome obrigatório'),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Email'),
                    controller: _emailEC,
                    validator: Validatorless.multiple([
                      Validatorless.required('Email obrigatório'),
                      Validatorless.email('Email inválido')
                    ]),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(labelText: 'Senha'),
                    controller: _passwordEC,
                    obscureText: true,
                    validator: Validatorless.multiple([
                      Validatorless.required('Senha obrigatório'),
                      Validatorless.min(
                          6, 'Senha dever conter pelo menos 6 caracteres'),
                    ]),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration:
                        const InputDecoration(labelText: 'Confirma Senha'),
                    obscureText: true,
                    validator: Validatorless.multiple([
                      Validatorless.required('Confirma Senha obrigatório'),
                      Validatorless.compare(
                          _passwordEC, 'Senha são diferentes'),
                    ]),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Center(
                    child: DeliveryButton(
                      width: double.infinity,
                      label: 'Cadastrar',
                      onPressed: () {
                        final valid =
                            _formKey.currentState?.validate() ?? false;
                        if (valid) {
                          controller.register(
                            _nameEC.text,
                            _emailEC.text,
                            _passwordEC.text,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
