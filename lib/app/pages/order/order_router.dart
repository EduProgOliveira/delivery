import 'package:dw9_delivery_appp/app/pages/order/order_completed_page.dart';
import 'package:dw9_delivery_appp/app/pages/order/order_controller.dart';
import 'package:dw9_delivery_appp/app/pages/order/order_page.dart';
import 'package:dw9_delivery_appp/app/repositories/order/order_repository.dart';
import 'package:dw9_delivery_appp/app/repositories/order/order_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrderRouter {
  OrderRouter._();

  static String route = "/order";
  static String routeCompleted = "/order/completed";

  static Widget get page => MultiProvider(
        providers: [
          Provider<OrderRepository>(
            create: (context) => OrderRepositoryImpl(context.read()),
          ),
          Provider(
            create: (context) => OrderController(context.read()),
          ),
        ],
        child: const OrderPage(),
      );

  static Widget get pageCompleted => const OrderCompletedPage();
}
