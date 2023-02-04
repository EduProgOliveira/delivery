import 'package:dw9_delivery_appp/app/core/global/global_context.dart';
import 'package:dw9_delivery_appp/app/core/provider/application_binding.dart';
import 'package:dw9_delivery_appp/app/core/ui/theme/theme_config.dart';
import 'package:dw9_delivery_appp/app/pages/auth/login/login_page.dart';
import 'package:dw9_delivery_appp/app/pages/auth/login/login_router.dart';
import 'package:dw9_delivery_appp/app/pages/order/order_router.dart';
import 'package:dw9_delivery_appp/app/pages/auth/register/register_router.dart';
import 'package:dw9_delivery_appp/app/pages/home/home_router.dart';
import 'package:dw9_delivery_appp/app/pages/product_detail/product_detail.router.dart';
import 'package:dw9_delivery_appp/app/pages/splash/splash_router.dart';
import 'package:flutter/material.dart';

class Dw9DeliveryApp extends StatelessWidget {
  final _navKey = GlobalKey<NavigatorState>();

  Dw9DeliveryApp({super.key}) {
    GlobalContext.instance.navigatorKey = _navKey;
  }

  @override
  Widget build(BuildContext context) {
    return ApplicationBinding(
      child: MaterialApp(
        navigatorKey: _navKey,
        theme: ThemeConfig.theme,
        title: 'Delivery App',
        routes: {
          SplashRouter.route: (context) => SplashRouter.page,
          HomeRouter.route: (context) => HomeRouter.page,
          ProductDetailRouter.route: (context) => ProductDetailRouter.page,
          LoginRouter.route: (context) => LoginRouter.page,
          RegisterRouter.route: (context) => RegisterRouter.page,
          OrderRouter.route: (context) => OrderRouter.page,
          OrderRouter.routeCompleted: (context) => OrderRouter.pageCompleted,
        },
      ),
    );
  }
}
