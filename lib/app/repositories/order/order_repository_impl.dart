import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dw9_delivery_appp/app/core/exceptions/repository_exception.dart';
import 'package:dw9_delivery_appp/app/core/rest_client/custom_dio.dart';
import 'package:dw9_delivery_appp/app/dto/order_dto.dart';
import 'package:dw9_delivery_appp/app/models/payment_type_model.dart';
import 'package:dw9_delivery_appp/app/repositories/order/order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final CustomDio _dio;

  OrderRepositoryImpl(this._dio);

  @override
  Future<List<PaymentTypeModel>> getAllPaymentsTypes() async {
    try {
      final result = await _dio.auth().get('/payment-types');
      return result.data
          .map<PaymentTypeModel>((p) => PaymentTypeModel.fromMap(p))
          .toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar formas de pagamento', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar formas de pagamento');
    }
  }

  @override
  Future<void> saveOrder(OrderDto orderDto) async {
    try {
      await _dio.auth().post('/orders', data: {
        'products': orderDto.products
            .map(
              (e) => {
                'id': e.product.id,
                'amount': e.amount,
                'total_price': e.totalPrice,
              },
            )
            .toList(),
        'user_id': '#userAuthRef',
        'address': orderDto.address,
        'CPF': orderDto.document,
        'payment_method_id': orderDto.paymentMethodId,
      });
    } on DioError catch (e, s) {
      log('Erro ao registrar pedido', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao registrar pedido');
    }
  }
}
