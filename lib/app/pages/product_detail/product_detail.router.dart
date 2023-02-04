import 'package:dw9_delivery_appp/app/pages/product_detail/bloc/product_detail_controller.dart';
import 'package:dw9_delivery_appp/app/pages/product_detail/product_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductDetailRouter {
  ProductDetailRouter._();

  static String get route => "/product-detail";

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => ProductDetailController(),
          ),
        ],
        builder: (context, child) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return ProductDetailPage(
            product: args['product'],
            order: args['order'],
          );
        },
      );
}
