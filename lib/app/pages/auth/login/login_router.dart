import 'package:dw9_delivery_appp/app/pages/auth/login/bloc/login_controller.dart';
import 'package:dw9_delivery_appp/app/pages/auth/login/login_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginRouter {
  LoginRouter._();

  static String route = "/auth/login";

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => LoginController(
              context.read(),
            ),
          )
        ],
        child: const LoginPage(),
      );
}
