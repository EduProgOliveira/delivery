import 'package:auto_size_text/auto_size_text.dart';
import 'package:dw9_delivery_appp/app/core/ui/base_state/base_state.dart';
import 'package:dw9_delivery_appp/app/core/ui/extensions/formatter_extension.dart';
import 'package:dw9_delivery_appp/app/core/ui/helpers/size_extensions.dart';
import 'package:dw9_delivery_appp/app/core/ui/styles/text_styles.dart';
import 'package:dw9_delivery_appp/app/core/ui/widgets/delivery_appbar.dart';
import 'package:dw9_delivery_appp/app/core/ui/widgets/delivery_increment_decrement_button.dart';
import 'package:dw9_delivery_appp/app/dto/order_product_dto.dart';
import 'package:dw9_delivery_appp/app/models/product_model.dart';
import 'package:dw9_delivery_appp/app/pages/product_detail/bloc/product_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel product;
  final OrderProductDto? order;

  const ProductDetailPage({super.key, required this.product, this.order});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState
    extends BaseState<ProductDetailPage, ProductDetailController> {
  @override
  void onReady() {
    super.onReady();
    final amount = widget.order?.amount ?? 1;
    controller.initial(amount, widget.order != null);
  }

  void _showConfirmDelete(int amount) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(
            'Deseja excluir o produto?',
            style: context.textStyles.textBold,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Cancelar',
                style: context.textStyles.textBold.copyWith(color: Colors.red),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.of(context).pop(
                  OrderProductDto(
                    product: widget.product,
                    amount: amount,
                  ),
                );
              },
              child: Text(
                'Confirmar',
                style: context.textStyles.textBold,
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: DeliveryAppbar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: context.screenHeight,
            height: context.percentHeight(.4),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget.product.image),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Text(
              widget.product.name,
              style: context.textStyles.textExtraBold.copyWith(fontSize: 22),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Text(
                  widget.product.description,
                  style: context.textStyles.textMedium,
                ),
              ),
            ),
          ),
          const Divider(),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                width: context.percentWidth(.5),
                height: 68,
                child: BlocBuilder<ProductDetailController, int>(
                    builder: (context, amount) {
                  return DeliveryIncrementDecrementButton(
                    decrementTap: () {
                      controller.decrement();
                    },
                    incrementTap: () {
                      controller.increment();
                    },
                    amount: amount,
                  );
                }),
              ),
              Container(
                padding: const EdgeInsets.all(8),
                width: context.percentWidth(0.5),
                height: 68,
                child: BlocBuilder<ProductDetailController, int>(
                  builder: (context, amount) {
                    return ElevatedButton(
                      style: amount == 0
                          ? ElevatedButton.styleFrom(
                              backgroundColor: Colors.red)
                          : null,
                      onPressed: () {
                        if (amount == 0) {
                          _showConfirmDelete(amount);
                        } else {
                          Navigator.of(context).pop(
                            OrderProductDto(
                              product: widget.product,
                              amount: amount,
                            ),
                          );
                        }
                      },
                      child: Visibility(
                        visible: amount > 0,
                        replacement: Text(
                          'Excluir produto',
                          style: context.textStyles.textExtraBold,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Adicionar',
                              style: context.textStyles.textExtraBold
                                  .copyWith(fontSize: 13),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: AutoSizeText(
                                (widget.product.price * amount).currencyPTBR,
                                maxFontSize: 13,
                                minFontSize: 5,
                                maxLines: 1,
                                textAlign: TextAlign.center,
                                style: context.textStyles.textExtraBold
                                    .copyWith(fontSize: 13),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
