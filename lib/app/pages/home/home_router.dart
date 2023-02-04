import 'package:dw9_delivery_appp/app/pages/home/bloc/home_controller.dart';
import 'package:dw9_delivery_appp/app/pages/home/home_page.dart';
import 'package:dw9_delivery_appp/app/repositories/products/products_repository.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeRouter {
  HomeRouter._();

  static String get route => "/home";

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => ProductsRepository(
              context.read(),
            ),
          ),
          Provider(
            create: (context) => HomeController(
              context.read(),
            ),
          )
        ],
        child: const HomePage(),
      );
}
