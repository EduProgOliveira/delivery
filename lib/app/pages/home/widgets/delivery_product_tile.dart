import 'package:dw9_delivery_appp/app/core/ui/extensions/formatter_extension.dart';
import 'package:dw9_delivery_appp/app/core/ui/styles/colors_app.dart';
import 'package:dw9_delivery_appp/app/core/ui/styles/text_styles.dart';
import 'package:dw9_delivery_appp/app/dto/order_product_dto.dart';
import 'package:dw9_delivery_appp/app/pages/home/bloc/home_controller.dart';
import 'package:dw9_delivery_appp/app/pages/product_detail/product_detail.router.dart';
import 'package:flutter/material.dart';

import 'package:dw9_delivery_appp/app/models/product_model.dart';
import 'package:provider/provider.dart';

class DeliveryProductTile extends StatelessWidget {
  final ProductModel product;
  final OrderProductDto? orderProduct;

  const DeliveryProductTile({
    Key? key,
    required this.product,
    required this.orderProduct,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        final controller = context.read<HomeController>();
        final orderProductResult = await Navigator.of(context).pushNamed(
          ProductDetailRouter.route,
          arguments: {
            'product': product,
            'order': orderProduct,
          },
        );
        if (orderProductResult != null) {
          controller.addOrUpdateBag(
              orderProduct: orderProductResult as OrderProductDto);
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Text(
                      product.name,
                      style: TextStyles.instance.textExtraBold.copyWith(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Text(
                      product.description,
                      style: TextStyles.instance.textLight.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 0),
                    child: Text(
                      product.price.currencyPTBR,
                      style: TextStyles.instance.textMedium.copyWith(
                        fontSize: 12,
                        color: ColorsApp.instance.secondary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            FadeInImage.assetNetwork(
              placeholder: 'assets/images/loading.gif',
              image: product.image,
              width: 100,
              height: 100,
              fit: BoxFit.contain,
            ),
          ],
        ),
      ),
    );
  }
}
