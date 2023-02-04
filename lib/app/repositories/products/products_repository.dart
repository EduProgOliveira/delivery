// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dw9_delivery_appp/app/core/exceptions/repository_exception.dart';
import 'package:dw9_delivery_appp/app/core/rest_client/custom_dio.dart';
import 'package:dw9_delivery_appp/app/models/product_model.dart';

import './i_products_repository.dart';

class ProductsRepository implements IProductsRepository {
  final CustomDio _dio;

  ProductsRepository(
    this._dio,
  );

  @override
  Future<List<ProductModel>> findAllProducts() async {
    try {
      final result = await _dio.unauth().get('/products');
      return result.data
          .map<ProductModel>((p) => ProductModel.fromMap(p))
          .toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar produtos', error: e, stackTrace: s);
      throw RepositoryException(message: 'Erro ao buscar produtos');
    }
  }
}
