import 'package:dw9_delivery_appp/app/pages/auth/register/bloc/register_controller.dart';
import 'package:dw9_delivery_appp/app/pages/auth/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterRouter {
  RegisterRouter._();

  static String route = '/auth/register';

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => RegisterController(
              context.read(),
            ),
          ),
        ],
        child: const RegisterPage(),
      );
}
